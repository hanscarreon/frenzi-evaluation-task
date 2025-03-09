import 'package:flutter/material.dart';
import 'package:frenzi_app/core/navigation/route_names.dart';
import 'package:frenzi_app/core/widgets/layout/spaced_column.dart';
import 'package:frenzi_app/core/widgets/layout/spaced_row.dart';
import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';
import 'package:frenzi_app/gen/colors.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedJourneyTemplate extends StatelessWidget {
  final JourneyDetailModel journey;
  final bool showFullDetails;

  const CompletedJourneyTemplate({
    super.key,
    required this.journey,
    this.showFullDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return showFullDetails
        ? showFullJourneyDetails(context)
        : showJourneyThumbnail(context);
  }

  Widget showJourneyThumbnail(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          RouteNames.journeyDetailScreen,
          extra: journey,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SpacedRow(
          spacing: 10,
          children: [
            const Icon(
              Icons.history,
              color: Colors.black,
            ),
            Expanded(
              child: SpacedColumn(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    journey.dropOffName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    journey.dropOffAddress,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showFullJourneyDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SpacedRow(
            children: [
              SpacedColumn(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.circle_rounded,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 2,
                    height: 70,
                    color: Colors.blue,
                  ),
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ],
              ),
              Expanded(
                child: SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SpacedRow(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: SpacedColumn(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PICK UP',
                                style: GoogleFonts.poppins(
                                  color: ColorName.black,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SpacedColumn(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      journey.pickUpName,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: ColorName.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      journey.pickUpAddress,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: ColorName.black.withOpacity(0.5),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SpacedRow(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: SpacedColumn(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DROP OFF',
                                style: GoogleFonts.poppins(
                                  color: ColorName.black,
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SpacedColumn(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      journey.dropOffName,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: ColorName.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      journey.dropOffAddress,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: ColorName.black.withOpacity(0.5),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SpacedRow(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: SpacedRow(
                            children: [
                              Text(
                                'Fare',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: ColorName.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '₱ ${journey.fare.toString()}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: ColorName.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
