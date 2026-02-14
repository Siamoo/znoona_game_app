import 'dart:async';
import 'package:flutter/material.dart';

class DebouncedSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onChangedEnd;
  final double min;
  final double max;
  final int? divisions;
  final Color? activeColor;
  final Color? inactiveColor;
  final Duration debounceDuration;
  
  // Fixed: This should be SemanticFormatterCallback type, not String?
  final SemanticFormatterCallback? semanticFormatterCallback;

  const DebouncedSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangedEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.debounceDuration = const Duration(milliseconds: 100),
    this.semanticFormatterCallback, // Now correct type
  });

  @override
  State<DebouncedSlider> createState() => _DebouncedSliderState();
}

class _DebouncedSliderState extends State<DebouncedSlider> {
  Timer? _debounceTimer;
  late double _localValue;
  
  // Track if we're currently debouncing
  bool _isDebouncing = false;

  @override
  void initState() {
    super.initState();
    _localValue = widget.value;
  }

  @override
  void didUpdateWidget(DebouncedSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update if the value changed externally and we're not in the middle of debouncing
    if (oldWidget.value != widget.value && !_isDebouncing) {
      setState(() {
        _localValue = widget.value;
      });
    }
  }

  void _handleChanged(double value) {
    setState(() {
      _localValue = value;
    });

    _isDebouncing = true;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      _isDebouncing = false;
      widget.onChanged(value);
    });
  }

  void _handleChangeEnd(double value) {
    _debounceTimer?.cancel();
    _isDebouncing = false;
    widget.onChanged(value);
    widget.onChangedEnd?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _localValue.clamp(widget.min, widget.max),
      onChanged: _handleChanged,
      onChangeEnd: _handleChangeEnd,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      semanticFormatterCallback: widget.semanticFormatterCallback, // Now correctly typed
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}