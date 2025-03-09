import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class FrenziAppRouting {
  static void removeAllRoute({
    required BuildContext context,
  }) {
    while (context.canPop()) {
      context.pop();
    }
  }
}
