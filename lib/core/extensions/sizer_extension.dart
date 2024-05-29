import 'package:flutter/material.dart';

extension SizerX on num {
  /// [verticalSpacing] is used to add vertical spacing between widgets.
  ///
  /// usage: `10.verticalSpacing`
  ///
  SizedBox get verticalSpacing => SizedBox(
        height: toDouble(),
      );

  /// [horizontalSpacing] is used to add horizontal spacing between widgets.
  ///
  /// usage: `10.horizontalSpacing`
  SizedBox get horizontalSpacing => SizedBox(
        width: toDouble(),
      );

  /// [verticalPadding] is used to add vertical padding to a widget.
  ///
  /// usage: `10.verticalPadding`
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(
        vertical: toDouble(),
      );

  /// [horizontalPadding] is used to add horizontal padding to a widget.
  ///
  /// usage: `10.horizontalPadding`
  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(
        horizontal: toDouble(),
      );

  /// [allPadding] is used to add padding to all sides of a widget.
  ///
  /// usage: `10.allPadding`
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());
}
