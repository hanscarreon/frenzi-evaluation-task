import 'package:flutter/material.dart';
import 'package:frenzi_app/core/widgets/layout/spaced_linear_layout.dart';

/// A custom widget similar to [Row], but allows
/// setting the [spacing] between each [children].
class SpacedRow extends SpacedLinearLayout {
  const SpacedRow({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.children,
    super.spacing,
  });

  @override
  final Axis axis = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      // ignore: avoid-returning-widgets
      children: getChildren(),
    );
  }
}
