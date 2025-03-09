import 'dart:convert';

import 'package:flutter/services.dart';

abstract class FixtureReader {
  static Future<dynamic> loadJsonFromAssets({required String name}) async {
    final filePath = 'assets/json/$name';
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
}
