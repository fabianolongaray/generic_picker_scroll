import 'package:flutter/material.dart';

/// Options for the GenericValuePicker widget
class GenericValuePickerOptions {
  const GenericValuePickerOptions({
    this.itemExtent = 30.0,
    this.diameterRatio = 3,
    this.perspective = 0.01,
    this.isLoop,
    this.backgroundColor = Colors.white,
    this.indicatorColor,
    this.indicatorBorderRadius,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  /// Size of each child in the main axis
  final double itemExtent;

  /// {@macro flutter.rendering.wheelList.diameterRatio}
  final double diameterRatio;

  /// {@macro flutter.rendering.wheelList.perspective}
  final double perspective;

  /// Optional boolean to define if all/none scrollViews should loop
  final bool? isLoop;

  /// The color to paint behind the picker
  final Color backgroundColor;

  /// The color of the indicator displayed in the center of the GenericValuePicker
  final Color? indicatorColor;

  /// The border radius of the indicator displayed in the center of the GenericValuePicker
  final BorderRadius? indicatorBorderRadius;

  /// Main axis alignment for the picker row
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment for the picker row
  final CrossAxisAlignment crossAxisAlignment;
}

/// Options for individual scroll views in GenericValuePicker
class GenericValueScrollViewOptions {
  const GenericValueScrollViewOptions({
    this.label = '',
    this.alignment = Alignment.centerLeft,
    this.margin,
    this.width,
    this.horizontalPadding = 0,
    this.selectedTextStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    this.textStyle =
        const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    this.isLoop = true,
    this.textScaleFactor = 1,
    this.alwaysUseUnselectedStyle = false,
  });

  /// The text printed next to the value.
  final String label;

  /// Text alignment method.
  final Alignment alignment;

  /// The amount of space that can be added.
  final EdgeInsets? margin;

  /// Overrides the width of each column. If null, width is calculated dynamically.
  final double? width;

  /// Extra horizontal space added to both sides of the column content.
  final double horizontalPadding;

  /// An immutable style describing how to format and paint text.
  final TextStyle textStyle;

  /// An invariant style that specifies the selected text format and explains how to draw it.
  final TextStyle selectedTextStyle;

  /// Define for each ScrollView if it should loop
  final bool isLoop;

  /// The scaling factor for the text within this widget.
  final double textScaleFactor;

  /// If true, always uses unselectedStyle even when selected (for fixed elements like comma, unit)
  final bool alwaysUseUnselectedStyle;

  /// Creates a copy of this [GenericValueScrollViewOptions] with the given fields replaced with the new values.
  GenericValueScrollViewOptions copyWith({
    String? label,
    Alignment? alignment,
    EdgeInsets? margin,
    double? width,
    double? horizontalPadding,
    TextStyle? textStyle,
    TextStyle? selectedTextStyle,
    bool? isLoop,
    double? textScaleFactor,
    bool? alwaysUseUnselectedStyle,
  }) {
    return GenericValueScrollViewOptions(
      label: label ?? this.label,
      alignment: alignment ?? this.alignment,
      margin: margin ?? this.margin,
      width: width ?? this.width,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      textStyle: textStyle ?? this.textStyle,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      isLoop: isLoop ?? this.isLoop,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      alwaysUseUnselectedStyle: alwaysUseUnselectedStyle ?? this.alwaysUseUnselectedStyle,
    );
  }
}

