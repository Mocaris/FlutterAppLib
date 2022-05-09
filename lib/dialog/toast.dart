import 'dart:async';
import 'package:flutter/material.dart';

enum TGravity {
  top,
  bottom,
  center,
}

class _ToastEntry {
  final Duration duration;

  late OverlayEntry overlayEntry;

  _ToastEntry(String content,
      {gravity = TGravity.center, this.duration = Toast.short, horizontalOffset = 0, verticalOffset = 0}) {
    overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Align(
              alignment: _buildToastAlignment(gravity),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalOffset, vertical: verticalOffset),
                  child: AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: _buildToastWidget(context, content),
                  ),
                ),
              ),
            ));
  }

  Widget _buildToastWidget(BuildContext context, String content) {
    return Builder(builder: (context) {
      var light = Theme.of(context).brightness == Brightness.light;
      return Center(
        child: Card(
          color: light ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              content,
              style: TextStyle(color: light ? Colors.white : Colors.black, fontSize: 14.0),
            ),
          ),
        ),
      );
    });
  }

  Alignment _buildToastAlignment(TGravity gravity) {
    switch (gravity) {
      case TGravity.top:
        return const Alignment(0, -0.3);
      case TGravity.bottom:
        return const Alignment(0, -0.3);
      case TGravity.center:
        return const Alignment(0, 0.7);
    }
  }
}

class Toast {
  static const short = Duration(milliseconds: 2500);
  static const long = Duration(milliseconds: 4000);

  static OverlayEntry? _overlayEntry;

  static Timer? _timer;

  static show(BuildContext context, String content,
      {TGravity gravity = TGravity.center,
        Duration duration = Toast.short,
      double horizontalOffset = 0,
      double verticalOffset = 0}) {
    var tEntry =
        _ToastEntry(content, duration: duration, horizontalOffset: horizontalOffset, verticalOffset: verticalOffset);
    _showEntry(context, tEntry);
  }

  static _showEntry(BuildContext context, _ToastEntry tEntry) {
    if (null != _timer && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
    if (null != _overlayEntry) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    _overlayEntry = tEntry.overlayEntry;
    Overlay.of(context)?.insert(_overlayEntry!);
    _timer = Timer(tEntry.duration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

/*
  static show(BuildContext context, String content,
      {TGravity gravity = TGravity.CENTER,
      int duration = Toast.SHORT_LENGTH,
      double horizontalOffset = 0,
      double verticalOffset = 0}) {
    _toastQueue.add(
        _ToastEntry(content, duration: duration, horizontalOffset: horizontalOffset, verticalOffset: verticalOffset));
    if (!_show) {
      _showEntry(context);
    }
  }

  static _showEntry(BuildContext context) {
    if (_toastQueue.isEmpty) {
      _show = false;
      return;
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
    _show = true;
    _timer?.cancel();
    _timer = null;
    var first = _toastQueue.first;
    _toastQueue.remove(first);
    _overlayEntry = first.overlayEntry;
    Overlay.of(context)?.insert(_overlayEntry!);
    _timer = Timer(Duration(milliseconds: first.duration), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _showEntry(context);
    });
  }
  */
}
