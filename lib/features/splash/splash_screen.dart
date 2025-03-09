import 'package:flutter/material.dart';
import 'package:frenzi_app/core/navigation/route_names.dart';
import 'package:frenzi_app/core/navigation/routing.dart';
import 'package:frenzi_app/core/widgets/layout/spaced_column.dart';
import 'package:frenzi_app/gen/colors.gen.dart';
import 'package:frenzi_app/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final language = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF0000),
                Color(0xFF0000FF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SpacedColumn(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 100,
                  ),
                  Center(
                    child: Text(
                      language.frenziApp,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        fontSize: 38,
                        color: ColorName.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FrenziAppRouting.removeAllRoute(context: context);
                      context.push(RouteNames.homeScreen);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      language.continueWord,
                      style: const TextStyle(
                        color: ColorName.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
