import 'dart:async';

import 'package:flutter/material.dart';

/// A slider that debounces rapid changes to prevent excessive updates
class DebouncedSlider extends StatefulWidget { // false for debounce, true for throttle
  
  const DebouncedSlider({
    required this.value, required this.onChanged, super.key,
    this.onChangedEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.debounceDuration = const Duration(milliseconds: 100),
    this.semanticFormatterCallback,
    this.useThrottle = false, // Default to debounce
  });
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onChangedEnd;
  final double min;
  final double max;
  final int? divisions;
  final Color? activeColor;
  final Color? inactiveColor;
  final Duration debounceDuration;
  final SemanticFormatterCallback? semanticFormatterCallback;
  final bool useThrottle;

  @override
  State<DebouncedSlider> createState() => _DebouncedSliderState();
}

class _DebouncedSliderState extends State<DebouncedSlider> {
  Timer? _debounceTimer;
  DateTime? _lastThrottleTime;
  late double _localValue;
  
  // Track if we're currently debouncing/throttling
  bool _isProcessing = false;
  
  // Track if external update is pending
  bool _hasPendingExternalUpdate = false;

  @override
  void initState() {
    super.initState();
    _localValue = widget.value.clamp(widget.min, widget.max);
  }

  @override
  void didUpdateWidget(DebouncedSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle external value changes
    if (oldWidget.value != widget.value && !_isProcessing) {
      setState(() {
        _localValue = widget.value.clamp(widget.min, widget.max);
      });
    } else if (oldWidget.value != widget.value) {
      // Mark that we have a pending external update
      _hasPendingExternalUpdate = true;
    }
    
    // Re-clamp if min/max changed
    if (oldWidget.min != widget.min || oldWidget.max != widget.max) {
      setState(() {
        _localValue = _localValue.clamp(widget.min, widget.max);
      });
    }
  }

  void _handleChanged(double value) {
    // Stop any existing debounce timer
    _debounceTimer?.cancel();
    
    setState(() {
      _localValue = value.clamp(widget.min, widget.max);
    });
    
    _isProcessing = true;
    
    if (widget.useThrottle) {
      _handleThrottledChange(value);
    } else {
      _handleDebouncedChange(value);
    }
  }

  void _handleDebouncedChange(double value) {
    _debounceTimer = Timer(widget.debounceDuration, () {
      _finalizeChange(value);
    });
  }

  void _handleThrottledChange(double value) {
    final now = DateTime.now();
    final shouldThrottle = _lastThrottleTime != null &&
        now.difference(_lastThrottleTime!) < widget.debounceDuration;
    
    if (!shouldThrottle) {
      _lastThrottleTime = now;
      _finalizeChange(value);
    } else {
      // Schedule for later if needed
      _debounceTimer?.cancel();
      _debounceTimer = Timer(widget.debounceDuration, () {
        _finalizeChange(value);
      });
    }
  }

  void _finalizeChange(double value) {
    if (!mounted) return;
    
    _isProcessing = false;
    
    // Check if there's a pending external update
    if (_hasPendingExternalUpdate) {
      setState(() {
        _localValue = widget.value.clamp(widget.min, widget.max);
      });
      _hasPendingExternalUpdate = false;
    }
    
    widget.onChanged(value.clamp(widget.min, widget.max));
  }

  void _handleChangeEnd(double value) {
    _debounceTimer?.cancel();
    _isProcessing = false;
    
    final clampedValue = value.clamp(widget.min, widget.max);
    
    // Ensure final value is set
    setState(() {
      _localValue = clampedValue;
    });
    
    widget.onChanged(clampedValue);
    widget.onChangedEnd?.call(clampedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _localValue,
      onChanged: _handleChanged,
      onChangeEnd: _handleChangeEnd,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      semanticFormatterCallback: widget.semanticFormatterCallback,
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

/// Extension for easier usage
extension DebouncedSliderExtension on DebouncedSlider {
  /// Creates a volume slider with common settings
  static DebouncedSlider volume({
    required double value,
    required ValueChanged<double> onChanged,
    ValueChanged<double>? onChangedEnd,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return DebouncedSlider(
      value: value,
      onChanged: onChanged,
      onChangedEnd: onChangedEnd,
      divisions: 10,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      debounceDuration: const Duration(milliseconds: 50),
    );
  }
}