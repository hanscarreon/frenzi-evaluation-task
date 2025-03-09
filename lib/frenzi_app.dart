import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frenzi_app/core/navigation/routes.dart';
import 'package:frenzi_app/gen/colors.gen.dart';
import 'package:frenzi_app/generated/l10n.dart';
import 'package:frenzi_app/core/service_locator/service_locator.dart';
import 'package:google_fonts/google_fonts.dart';

class FrenziApp extends StatefulWidget {
  const FrenziApp({super.key});

  @override
  State<FrenziApp> createState() => _FrenziAppState();
}

class _FrenziAppState extends State<FrenziApp> {
  @override
  void initState() {
    super.initState();
    ServiceLocator.register();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: frenziAppRouting,
      title: 'Frenzi App',
      theme: ThemeData(
        primaryColor: ColorName.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
