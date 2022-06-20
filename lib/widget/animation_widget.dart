
import 'package:flutter/material.dart';

/// [value] lowerBound ~ upperBound
typedef AnimationChildBuilder = Widget Function(BuildContext context, double value);

class AnimationWidget extends StatefulWidget {
  final Duration duration;
  final Duration? reverseDuration;
  final bool enable;
  final bool repeat;
  final bool reverse;
  final double lowerBound;
  final double upperBound;
  final AnimationChildBuilder builder;

  AnimationWidget(
      {Key? key,
      this.enable = true,
      this.repeat = true,
      this.reverse = true,
      required this.duration,
      this.reverseDuration,
      this.lowerBound = 0.0,
      this.upperBound = 1.0,
      required this.builder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnimationWidgetState();
  }
}

class _AnimationWidgetState extends State<AnimationWidget> with TickerProviderStateMixin {
  late AnimationController _anmCl;

  @override
  void initState() {
    _anmCl = AnimationController(
        vsync: this,
        duration: widget.duration,
        reverseDuration: widget.reverseDuration,
        lowerBound: widget.lowerBound,
        upperBound: widget.upperBound);
    super.initState();
    start();
  }

  start() {
    if (widget.enable) {
      if (widget.repeat) {
        _anmCl.repeat(reverse: widget.reverse);
      } else {
        _anmCl.forward(from: widget.lowerBound);
      }
    } else {
      stopAnimation();
    }
  }

  stopAnimation() {
    _anmCl.stop();
  }

  @override
  void didUpdateWidget(covariant AnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lowerBound != widget.lowerBound ||
        oldWidget.upperBound != widget.upperBound ||
        oldWidget.duration != widget.duration ||
        oldWidget.reverseDuration != widget.reverseDuration ||
        oldWidget.reverse != widget.reverse) {
      stopAnimation();
      _anmCl = AnimationController(
          vsync: this,
          duration: widget.duration,
          reverseDuration: widget.reverseDuration,
          lowerBound: widget.lowerBound,
          upperBound: widget.upperBound);
      start();
    } else if (oldWidget.enable != widget.enable ||
        oldWidget.reverse != widget.reverse ||
        oldWidget.repeat != widget.repeat) {
      start();
    }
  }

  @override
  void dispose() {
    _anmCl.stop();
    _anmCl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _anmCl, builder: (ct, child) => widget.builder(context, _anmCl.value));
  }
}
