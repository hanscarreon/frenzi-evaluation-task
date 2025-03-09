// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';
import 'package:frenzi_app/features/home/presentation/widgets/completed_journey_template.dart';
import 'package:frenzi_app/gen/colors.gen.dart';
import 'package:frenzi_app/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JourneyDetailPage extends StatefulWidget {
  final JourneyDetailModel journey;
  const JourneyDetailPage({
    super.key,
    required this.journey,
  });

  @override
  State<JourneyDetailPage> createState() => _JourneyDetailPageState();
}

class _JourneyDetailPageState extends State<JourneyDetailPage> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  late LatLng pickUpLocation = LatLng(
    widget.journey.pickUpLocation.latitude,
    widget.journey.pickUpLocation.longitude,
  );

  late LatLng dropOffLocation = LatLng(
    widget.journey.dropOffLocation.latitude,
    widget.journey.dropOffLocation.longitude,
  );

  @override
  void initState() {
    makeLines();

    super.initState();
  }

  void addPolyline() {
    const polyLineId = PolylineId("id");
    final polyline = Polyline(
      polylineId: polyLineId,
      color: Colors.blue,
      points: polylineCoordinates,
    );

    polylines[polyLineId] = polyline;
    setState(() {});
  }

  Future<void> makeLines() async {
    await polylinePoints
        .getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyChOuKpfWNxzqlmDJH6R31DiTQTpCU2ZfE',
      request: PolylineRequest(
        origin: PointLatLng(
          pickUpLocation.latitude,
          pickUpLocation.longitude,
        ),
        destination: PointLatLng(
          dropOffLocation.latitude,
          dropOffLocation.longitude,
        ),
        mode: TravelMode.driving,
      ),
    )
        .then((value) {
      value.points.forEach((PointLatLng latlng) {
        polylineCoordinates.add(
          LatLng(
            latlng.latitude,
            latlng.longitude,
          ),
        );
      });
    }).then((value) {
      addPolyline();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(
      () {
        markers.add(
          Marker(
            markerId: const MarkerId('pickUpMarker'),
            position: pickUpLocation,
            infoWindow: InfoWindow(
              title: widget.journey.pickUpName,
            ),
          ),
        );
        markers.add(
          Marker(
            markerId: const MarkerId('dropOffMarker'),
            position: dropOffLocation,
            infoWindow: InfoWindow(
              title: widget.journey.dropOffName,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).tripDetails,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: ColorName.black,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                markers: markers,
                compassEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: pickUpLocation,
                  zoom: 12,
                ),
                polylines: Set<Polyline>.of(polylines.values),
              ),
            ),
            CompletedJourneyTemplate(
              journey: widget.journey,
              showFullDetails: true,
            ),
          ],
        ),
      ),
    );
  }
}
