import 'dart:math';

import 'package:flutter/material.dart';
import 'package:generic_picker_scroll/src/models/generic_value_picker_options.dart';
import 'package:generic_picker_scroll/src/extensions/string_extension.dart';

/// A generic picker widget for selecting numeric values with decimal and unit
/// 
/// Example: 185 , 0 cm
/// - Integer part (min-max)
/// - Comma (fixed, always unselectedStyle)
/// - Decimal part (0-9)
/// - Unit (array of strings, always unselectedStyle when selected)
class GenericValuePicker extends StatefulWidget {
  const GenericValuePicker({
    Key? key,
    required this.value,
    required this.unit,
    required this.minValue,
    required this.maxValue,
    required this.units,
    required this.onValueChanged,
    GenericValuePickerOptions? options,
    GenericValueScrollViewOptions? integerOptions,
    GenericValueScrollViewOptions? decimalOptions,
    GenericValueScrollViewOptions? unitOptions,
    this.indicator,
  })  : options = options ?? const GenericValuePickerOptions(),
        integerOptions = integerOptions ?? const GenericValueScrollViewOptions(),
        decimalOptions = decimalOptions ?? const GenericValueScrollViewOptions(),
        unitOptions = unitOptions ?? const GenericValueScrollViewOptions(alwaysUseUnselectedStyle: true),
        super(key: key);

  /// Current selected value
  final double value;

  /// Current selected unit
  final String unit;

  /// Minimum value for integer part
  final int minValue;

  /// Maximum value for integer part
  final int maxValue;

  /// List of available units
  final List<String> units;

  /// Callback when value or unit changes
  /// Returns: (double value, String unit)
  final void Function(double value, String unit) onValueChanged;

  /// Options for the picker
  final GenericValuePickerOptions options;

  /// Options for the integer scroll view
  final GenericValueScrollViewOptions integerOptions;

  /// Options for the decimal scroll view
  final GenericValueScrollViewOptions decimalOptions;

  /// Options for the unit scroll view
  final GenericValueScrollViewOptions unitOptions;

  /// Indicator displayed in the center of the GenericValuePicker
  final Widget? indicator;

  @override
  State<GenericValuePicker> createState() => _GenericValuePickerState();
}

class _GenericValuePickerState extends State<GenericValuePicker> {
  late FixedExtentScrollController _integerController;
  late FixedExtentScrollController _decimalController;
  late FixedExtentScrollController _unitController;

  late Widget _integerScrollView;
  late Widget _commaView;
  late Widget _decimalScrollView;
  late Widget _unitScrollView;

  late double _currentValue;
  late String _currentUnit;
  late int _integerPart;
  late int _decimalPart;
  late int _unitIndex;

  List<int> _integerValues = [];
  List<int> _decimalValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  int get selectedIntegerIndex {
    if (!_integerValues.contains(_integerPart)) {
      return 0;
    }
    return _integerValues.indexOf(_integerPart);
  }

  int get selectedDecimalIndex {
    if (!_decimalValues.contains(_decimalPart)) {
      return 0;
    }
    return _decimalValues.indexOf(_decimalPart);
  }

  int get selectedUnitIndex {
    if (!widget.units.contains(_currentUnit) || widget.units.isEmpty) {
      return 0;
    }
    return widget.units.indexOf(_currentUnit);
  }

  int get selectedInteger {
    if (_integerController.hasClients) {
      return _integerValues[_integerController.selectedItem % _integerValues.length];
    }
    return _integerPart;
  }

  int get selectedDecimal {
    if (_decimalController.hasClients) {
      return _decimalValues[_decimalController.selectedItem % _decimalValues.length];
    }
    return _decimalPart;
  }

  String get selectedUnit {
    if (_unitController.hasClients && widget.units.isNotEmpty) {
      return widget.units[_unitController.selectedItem % widget.units.length];
    }
    return _currentUnit;
  }

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    _currentUnit = widget.unit;

    // Decompose value into integer and decimal parts
    _integerPart = _currentValue.floor();
    _decimalPart = ((_currentValue - _integerPart) * 10).round().clamp(0, 9);

    // Validate integer part
    if (_integerPart < widget.minValue) {
      _integerPart = widget.minValue;
    } else if (_integerPart > widget.maxValue) {
      _integerPart = widget.maxValue;
    }

    // Initialize integer values list
    _integerValues = [
      for (int i = widget.minValue; i <= widget.maxValue; i++) i
    ];

    // Initialize controllers
    _integerController =
        FixedExtentScrollController(initialItem: selectedIntegerIndex);
    _decimalController =
        FixedExtentScrollController(initialItem: selectedDecimalIndex);
    _unitIndex = selectedUnitIndex;
    _unitController =
        FixedExtentScrollController(initialItem: _unitIndex);

    _initScrollViews();
  }

  @override
  void didUpdateWidget(covariant GenericValuePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_currentValue != widget.value || _currentUnit != widget.unit) {
      _currentValue = widget.value;
      _currentUnit = widget.unit;

      // Decompose value
      _integerPart = _currentValue.floor();
      _decimalPart = ((_currentValue - _integerPart) * 10).round().clamp(0, 9);

      // Validate integer part
      if (_integerPart < widget.minValue) {
        _integerPart = widget.minValue;
      } else if (_integerPart > widget.maxValue) {
        _integerPart = widget.maxValue;
      }

      // Update integer values if min/max changed
      if (oldWidget.minValue != widget.minValue || oldWidget.maxValue != widget.maxValue) {
        _integerValues = [
          for (int i = widget.minValue; i <= widget.maxValue; i++) i
        ];
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_integerController.hasClients) {
          _integerController.animateToItem(
            selectedIntegerIndex.clamp(0, _integerValues.length - 1),
            curve: Curves.ease,
            duration: const Duration(microseconds: 500),
          );
        }
        if (_decimalController.hasClients) {
          _decimalController.animateToItem(
            selectedDecimalIndex,
            curve: Curves.ease,
            duration: const Duration(microseconds: 500),
          );
        }
        if (_unitController.hasClients && widget.units.isNotEmpty) {
          _unitController.animateToItem(
            selectedUnitIndex.clamp(0, widget.units.length - 1),
            curve: Curves.ease,
            duration: const Duration(microseconds: 500),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _integerController.dispose();
    _decimalController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  void _initScrollViews() {
    // Integer scroll view
    _integerScrollView = _ValueScrollView(
      key: const Key("integer"),
      items: _integerValues.map((v) => v.toString()).toList(),
      controller: _integerController,
      options: widget.options,
      scrollViewOptions: widget.integerOptions,
      selectedIndex: selectedIntegerIndex,
      onTap: (int index) => _integerController.jumpToItem(index),
      onChanged: (_) => _onValueChanged(),
    );

    // Fixed comma view
    _commaView = _FixedItemView(
      item: ',',
      options: widget.options,
      scrollViewOptions: GenericValueScrollViewOptions(
        alignment: Alignment.center,
        textStyle: widget.integerOptions.textStyle,
        selectedTextStyle: widget.integerOptions.selectedTextStyle,
        alwaysUseUnselectedStyle: true,
      ),
    );

    // Decimal scroll view
    _decimalScrollView = _ValueScrollView(
      key: const Key("decimal"),
      items: _decimalValues.map((v) => v.toString()).toList(),
      controller: _decimalController,
      options: widget.options,
      scrollViewOptions: widget.decimalOptions,
      selectedIndex: selectedDecimalIndex,
      onTap: (int index) => _decimalController.jumpToItem(index),
      onChanged: (_) => _onValueChanged(),
    );

    // Unit scroll view
    _unitScrollView = _ValueScrollView(
      key: const Key("unit"),
      items: widget.units,
      controller: _unitController,
      options: widget.options,
      scrollViewOptions: widget.unitOptions,
      selectedIndex: selectedUnitIndex,
      onTap: (int index) => _unitController.jumpToItem(index),
      onChanged: (_) => _onValueChanged(),
      alwaysUseUnselectedStyle: widget.unitOptions.alwaysUseUnselectedStyle,
    );
  }

  void _onValueChanged() {
    final newInteger = selectedInteger;
    final newDecimal = selectedDecimal;
    final newUnit = selectedUnit;

    _currentValue = newInteger + (newDecimal / 10);
    _currentUnit = newUnit;

    widget.onValueChanged(_currentValue, _currentUnit);
  }

  @override
  Widget build(BuildContext context) {
    final indicator = widget.indicator ??
        Container(
          height: widget.options.itemExtent,
          decoration: BoxDecoration(
            color: widget.options.indicatorColor ??
                Colors.grey.withValues(alpha: 0.15),
            borderRadius: widget.options.indicatorBorderRadius ??
                const BorderRadius.all(Radius.circular(4)),
          ),
        );

    return Stack(
      alignment: Alignment.center,
      children: [
        // Place indicator beneath scroll content
        IgnorePointer(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              child: indicator,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: widget.options.mainAxisAlignment,
          crossAxisAlignment: widget.options.crossAxisAlignment,
          children: [
            _integerScrollView,
            _commaView,
            _decimalScrollView,
            _unitScrollView,
          ],
        ),
        // Gradient overlay on top for fade effect
        IgnorePointer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        widget.options.backgroundColor,
                        widget.options.backgroundColor.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: widget.options.itemExtent),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        widget.options.backgroundColor.withValues(alpha: 0.7),
                        widget.options.backgroundColor,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Internal scroll view for value picker items
class _ValueScrollView extends StatefulWidget {
  const _ValueScrollView({
    Key? key,
    required this.items,
    required this.controller,
    required this.options,
    required this.scrollViewOptions,
    required this.selectedIndex,
    required this.onTap,
    required this.onChanged,
    this.alwaysUseUnselectedStyle = false,
  }) : super(key: key);

  final List<String> items;
  final FixedExtentScrollController controller;
  final GenericValuePickerOptions options;
  final GenericValueScrollViewOptions scrollViewOptions;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onChanged;
  final bool alwaysUseUnselectedStyle;

  @override
  State<_ValueScrollView> createState() => _ValueScrollViewState();
}

class _ValueScrollViewState extends State<_ValueScrollView> {
  late int _currentSelectedIndex;

  @override
  void initState() {
    super.initState();
    _currentSelectedIndex = widget.selectedIndex;
    widget.controller.addListener(_onScrollChanged);
  }

  @override
  void didUpdateWidget(_ValueScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onScrollChanged);
      widget.controller.addListener(_onScrollChanged);
    }
    // Update if the initial selectedIndex changed from parent
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _currentSelectedIndex = widget.selectedIndex;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScrollChanged);
    super.dispose();
  }

  void _onScrollChanged() {
    if (widget.controller.hasClients) {
      final newSelectedIndex = widget.controller.selectedItem % widget.items.length;
      if (newSelectedIndex != _currentSelectedIndex) {
        setState(() {
          _currentSelectedIndex = newSelectedIndex;
        });
      }
    }
  }

  double _getScrollViewWidth(BuildContext context) {
    final padding = widget.scrollViewOptions.horizontalPadding * 2;
    if (widget.scrollViewOptions.width != null) {
      return widget.scrollViewOptions.width! + padding;
    }

    double textWidth = 0;
    for (final item in widget.items) {
      final text = '$item${widget.scrollViewOptions.label}';
      final selectedWidth = text.width(
        context,
        style: widget.scrollViewOptions.selectedTextStyle,
      );
      final unselectedWidth = text.width(
        context,
        style: widget.scrollViewOptions.textStyle,
      );
      textWidth = max(textWidth, max(selectedWidth, unselectedWidth));
    }

    return textWidth + 8 + padding;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int _maximumCount = constraints.maxHeight ~/ widget.options.itemExtent;
        return Container(
          margin: widget.scrollViewOptions.margin,
          width: _getScrollViewWidth(context),
          child: ListWheelScrollView.useDelegate(
            itemExtent: widget.options.itemExtent,
            diameterRatio: widget.options.diameterRatio,
            controller: widget.controller,
            physics: const FixedExtentScrollPhysics(),
            perspective: widget.options.perspective,
            onSelectedItemChanged: (index) {
              // Update internal state first
              if (widget.controller.hasClients) {
                final newSelectedIndex = index % widget.items.length;
                if (newSelectedIndex != _currentSelectedIndex) {
                  setState(() {
                    _currentSelectedIndex = newSelectedIndex;
                  });
                }
              }
              // Then call the external callback
              widget.onChanged(index);
            },
            childDelegate: (widget.options.isLoop ?? widget.scrollViewOptions.isLoop) &&
                    widget.items.length > _maximumCount
                ? ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      widget.items.length,
                      (index) => _buildItemView(index: index),
                    ),
                  )
                : ListWheelChildListDelegate(
                    children: List<Widget>.generate(
                      widget.items.length,
                      (index) => _buildItemView(index: index),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildItemView({required int index}) {
    // Use the current selected index from state
    final currentSelectedItem = widget.controller.hasClients
        ? _currentSelectedIndex
        : widget.selectedIndex;
    final isSelected = currentSelectedItem == index && !widget.alwaysUseUnselectedStyle;
    
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.scrollViewOptions.horizontalPadding,
        ),
        alignment: widget.scrollViewOptions.alignment,
        child: Text(
          '${widget.items[index]}${widget.scrollViewOptions.label}',
          style: isSelected
              ? widget.scrollViewOptions.selectedTextStyle
              : widget.scrollViewOptions.textStyle,
          textScaler: TextScaler.linear(widget.scrollViewOptions.textScaleFactor),
        ),
      ),
    );
  }
}

/// Fixed item view for comma and other non-scrollable elements
class _FixedItemView extends StatelessWidget {
  const _FixedItemView({
    Key? key,
    required this.item,
    required this.options,
    required this.scrollViewOptions,
  }) : super(key: key);

  final String item;
  final GenericValuePickerOptions options;
  final GenericValueScrollViewOptions scrollViewOptions;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: scrollViewOptions.margin,
      width: scrollViewOptions.width ?? 20,
      height: options.itemExtent,
      alignment: scrollViewOptions.alignment,
      child: Text(
        '$item${scrollViewOptions.label}',
        style: scrollViewOptions.textStyle, // Always use unselected style
        textScaler: TextScaler.linear(scrollViewOptions.textScaleFactor),
      ),
    );
  }
}

