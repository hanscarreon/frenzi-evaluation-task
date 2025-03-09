import 'package:frenzi_app/features/journey/domain/models/location_model.dart';

class JourneyModel {
  final List<JourneyDetailModel> trips;

  JourneyModel({required this.trips});

  factory JourneyModel.empty() {
    return JourneyModel(
      trips: [],
    );
  }

  factory JourneyModel.fromJson(Map<String, dynamic> json) {
    return JourneyModel(
      trips: List<JourneyDetailModel>.from(
        json['trips'] is List
            ? json['trips'].map(
                (x) => JourneyDetailModel.fromJson(x),
              )
            : [],
      ),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'trips': trips.map((trip) => trip.toJson()).toList(),
    };
  }
}

class JourneyDetailModel {
  final int id;
  final String pickUpName;
  final String pickUpAddress;
  final String dropOffName;
  final String dropOffAddress;
  final double fare;
  final String date;
  final LocationModel pickUpLocation;
  final LocationModel dropOffLocation;

  JourneyDetailModel({
    required this.id,
    required this.pickUpName,
    required this.pickUpAddress,
    required this.dropOffName,
    required this.dropOffAddress,
    required this.fare,
    required this.date,
    required this.pickUpLocation,
    required this.dropOffLocation,
  });

  factory JourneyDetailModel.empty() {
    return JourneyDetailModel(
      id: 0,
      pickUpName: '',
      pickUpAddress: '',
      dropOffName: '',
      dropOffAddress: '',
      fare: 0,
      date: '',
      pickUpLocation: LocationModel.empty(),
      dropOffLocation: LocationModel.empty(),
    );
  }

  factory JourneyDetailModel.fromJson(Map<String, dynamic> json) {
    return JourneyDetailModel(
      id: json['id'],
      pickUpName: json['pickUpName'],
      pickUpAddress: json['pickUpAddress'],
      dropOffName: json['dropOffName'],
      dropOffAddress: json['dropOffAddress'],
      fare: json['fare'],
      date: json['date'],
      pickUpLocation: LocationModel.fromJson(
        json['pickUpLocation'],
      ),
      dropOffLocation: LocationModel.fromJson(
        json['dropOffLocation'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pickUpName': pickUpName,
      'pickUpAddress': pickUpAddress,
      'dropOffName': dropOffName,
      'dropOffAddress': dropOffAddress,
      'fare': fare,
      'date': date,
      'pickUpLocation': pickUpLocation.toJson(),
      'dropOffLocation': dropOffLocation.toJson(),
    };
  }
}
