import 'package:frenzi_app/core/navigation/custom_transition_page.dart';
import 'package:frenzi_app/core/navigation/route_names.dart';
import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';
import 'package:frenzi_app/features/home/presentation/home_screen.dart';
import 'package:frenzi_app/features/home/presentation/journey_detail.dart';
import 'package:frenzi_app/features/journey/presentation/create_new_journey_screen.dart';
import 'package:frenzi_app/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final frenziAppRouting = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.splashScreen,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.homeScreen,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.journeyDetailScreen,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: JourneyDetailPage(
          journey: state.extra as JourneyDetailModel,
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.newJourney,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const CreateNewJourneyScreen(),
      ),
    ),
  ],
);
