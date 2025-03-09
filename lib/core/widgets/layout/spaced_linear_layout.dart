// coverage:ignore-file

import 'package:flutter/widgets.dart';

abstract class SpacedLinearLayout extends StatelessWidget {
  const SpacedLinearLayout({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    this.spacing = 4,
  }) : assert(spacing > 0);

  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Iterable<Widget> children;

  Axis get axis;

  @protected
  List<Widget> getChildren() {
    final newChildren = <Widget>[];

    for (final w in children) {
      newChildren.add(w);
      if (children.last != w) {
        late SizedBox spacer;

        switch (axis) {
          case Axis.horizontal:
            spacer = SizedBox(width: spacing);
            break;
          case Axis.vertical:
            spacer = SizedBox(height: spacing);
            break;
        }

        newChildren.add(spacer);
      }
    }

    return newChildren;
  }
}
