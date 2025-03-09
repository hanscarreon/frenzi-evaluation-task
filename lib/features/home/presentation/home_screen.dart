// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzi_app/core/navigation/route_names.dart';
import 'package:frenzi_app/core/service_locator/service_locator.dart';
import 'package:frenzi_app/core/widgets/dialogs.dart';
import 'package:frenzi_app/core/widgets/layout/spaced_column.dart';
import 'package:frenzi_app/features/home/presentation/blocs/bloc/home_bloc.dart';
import 'package:frenzi_app/features/home/presentation/widgets/completed_journey_template.dart';
import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';
import 'package:frenzi_app/gen/colors.gen.dart';
import 'package:frenzi_app/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;
  bool isDialogOpen = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  JourneyModel journeys = JourneyModel.empty();

  @override
  void initState() {
    super.initState();
    bloc = getIt<HomeBloc>();
    bloc.add(LoadCompletedJourneysEvent());
  }

  @override
  Widget build(BuildContext context) {
    final language = S.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: bloc,
          listener: (context, state) async {
            if (state is HomeError) {
              if (!isDialogOpen) {
                await Dialogs.showErrorDialog(
                  context: context,
                  title: language.oops,
                  onDismissCallback: (type) {
                    setState(
                      () {
                        isDialogOpen = false;
                      },
                    );
                  },
                );
                setState(
                  () {
                    isDialogOpen = true;
                  },
                );
              }
            }

            if (state is ResetCacheSuccess) {
              bloc.add(LoadCompletedJourneysEvent());
            }
          },
          builder: (context, state) {
            journeys = state is LoadedJourneyState
                ? state.completedTrips
                : JourneyModel.empty();

            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SpacedColumn(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    language.completedTrips,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: ColorName.black,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: journeys.trips.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 2,
                        color: Colors.green,
                      ),
                      itemBuilder: (context, index) {
                        return CompletedJourneyTemplate(
                          journey: journeys.trips[index],
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: journeys.trips.length == 8
                        ? null
                        : () {
                            context.push(RouteNames.newJourney).then((value) {
                              bloc.add(LoadCompletedJourneysEvent());
                            });
                          },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      language.addNewJourney,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: ColorName.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(ResetCacheEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      language.resetCache,
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
