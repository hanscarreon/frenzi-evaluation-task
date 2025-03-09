// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzi_app/core/constants/app_constants.dart';
import 'package:frenzi_app/core/navigation/route_names.dart';
import 'package:frenzi_app/core/navigation/routing.dart';
import 'package:frenzi_app/core/service_locator/service_locator.dart';
import 'package:frenzi_app/core/widgets/dialogs.dart';
import 'package:frenzi_app/core/widgets/layout/spaced_column.dart';
import 'package:frenzi_app/core/widgets/layout/spaced_row.dart';
import 'package:frenzi_app/features/journey/presentation/blocs/bloc/journey_bloc.dart';
import 'package:frenzi_app/gen/colors.gen.dart';
import 'package:frenzi_app/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;

class CreateNewJourneyScreen extends StatefulWidget {
  const CreateNewJourneyScreen({super.key});

  @override
  State<CreateNewJourneyScreen> createState() => _CreateNewJourneyScreenState();
}

class _CreateNewJourneyScreenState extends State<CreateNewJourneyScreen> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController dropOffController = TextEditingController();
  bool isSearching = false;
  late JourneyBloc bloc;
  bool isDialogOpen = false;
  List<dynamic> predictions = [];

  @override
  void initState() {
    bloc = getIt<JourneyBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final language = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Journey',
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
        child: BlocConsumer<JourneyBloc, JourneyState>(
          bloc: bloc,
          listener: (context, state) async {
            if (state is JourneyLoading) {
              isDialogOpen = true;
              await Dialogs.showLoadingDialog(
                  context: context,
                  dialogHeight: 100,
                  message: language.bookingJourney);
            }

            if (state is JourneyError) {
              isDialogOpen = true;
              context.pop();
              await Dialogs.showErrorDialog(
                context: context,
                title: language.oops,
                message: language.oopsSomethingWentWrongPleaseTryAgainLater,
              );
            }

            if (state is JourneyAdded) {
              isDialogOpen = true;

              await Dialogs.showSuccessDialog(
                context: context,
                onDismissCallback: (type) {
                  isDialogOpen = false;
                },
                title: language.journeyAdded,
                buttonText: language.proceed,
                btnOkOnPress: () {
                  FrenziAppRouting.removeAllRoute(context: context);
                  context.go(RouteNames.homeScreen);
                },
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpacedColumn(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SpacedRow(
                    spacing: 10,
                    children: [
                      const Icon(
                        Icons.circle_rounded,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: GooglePlaceAutoCompleteTextField(
                          textEditingController: pickUpController,
                          googleAPIKey: AppConstants.googleApiKey,
                          isCrossBtnShown: true,
                          containerHorizontalPadding: 10,
                          // placeType: PlaceType.,
                          inputDecoration: InputDecoration(
                            label: Text(
                              language.pickUpAt,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          seperatedBuilder: const Divider(),
                          itemClick: (Prediction prediction) {
                            // DO SOMETHING
                          },
                          itemBuilder: (context, index, prediction) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(prediction.description ?? ""))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SpacedRow(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: language.whereTo,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: isSearching
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) async {
                            if (value.length > 2) {
                              setState(() {
                                isSearching = true;
                              });

                              try {
                                final response = await http.get(
                                  Uri.parse(
                                      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
                                      '?input=${Uri.encodeComponent(value)}'
                                      '&components=country:uk'
                                      '&types=geocode' // Add this to get more precise locations
                                      '&key=${AppConstants.googleApiKey}'),
                                );

                                if (response.statusCode == 200) {
                                  final data = json.decode(response.body);
                                  if (data['status'] == 'OK') {
                                    setState(() {
                                      predictions = data['predictions'];
                                      isSearching = false;
                                    });
                                  } else {
                                    throw Exception(data['error_message'] ??
                                        'Failed to get predictions');
                                  }
                                } else {
                                  throw Exception(
                                      'Failed to fetch predictions');
                                }
                              } catch (e) {
                                setState(() {
                                  isSearching = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            } else {
                              setState(() {
                                predictions = [];
                                isSearching = false;
                              });
                            }
                          },
                        ),
                        // GooglePlaceAutoCompleteTextField(
                        //   textEditingController: dropOffController,
                        //   googleAPIKey: AppConstants.googleApiKey,
                        //   isCrossBtnShown: true,
                        //   containerHorizontalPadding: 10,
                        //   // placeType: PlaceType.,
                        //   inputDecoration: InputDecoration(
                        //     label: Text(
                        //       language.whereTo,
                        //       style: GoogleFonts.poppins(
                        //         fontWeight: FontWeight.w400,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        //   seperatedBuilder: Divider(),
                        //   itemClick: (Prediction prediction) {},
                        //   itemBuilder: (context, index, prediction) {
                        //     return Container(
                        //       padding: EdgeInsets.all(10),
                        //       child: Row(
                        //         children: [
                        //           Icon(Icons.location_on),
                        //           SizedBox(
                        //             width: 7,
                        //           ),
                        //           Expanded(
                        //               child: Text(prediction.description ?? ""))
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      language.pleaseNoteThatTheApiKeyThatWeUsedFor,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(
                        CreateNewJourneyEvent(simulateErrorScenario: false),
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      language.bookThisJourney,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: ColorName.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bloc.add(
                        CreateNewJourneyEvent(simulateErrorScenario: true),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      language.simulateError,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: ColorName.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
