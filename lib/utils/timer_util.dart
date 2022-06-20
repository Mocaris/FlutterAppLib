import 'dart:async';

typedef OnTick = Function(Duration untilFinished);
typedef OnFinish = Function();

const Duration kDefaultInterval = Duration(milliseconds: Duration.millisecondsPerSecond);

class CountDownTimer {
  Duration _interval;
  Duration _totalTime;
  Timer? _timer;

  OnTick? _tickCallback;
  OnFinish? _finishCallback;

  CountDownTimer({
    Duration interval = kDefaultInterval,
    required Duration totalTime,
    OnTick? tickCallback,
    OnFinish? finishCallback,
  })  : _interval = interval,
        _totalTime = totalTime,
        _tickCallback = tickCallback,
        _finishCallback = finishCallback;

  setCallback({OnTick? tickCallback, OnFinish? finishCallback}) {
    this._tickCallback = tickCallback;
    this._finishCallback = finishCallback;
  }

  start() {
    _timer?.cancel();
    if (_totalTime < _interval) {
      throw Exception("CountDownTimer totalTime can not lesser than interval");
    }
    _tickCallback?.call(_totalTime);
    _timer = Timer.periodic(_interval, (timer) => _tick(timer));
  }

  _tick(Timer timer) {
    var tick = _totalTime.inMilliseconds - timer.tick * _interval.inMilliseconds;
    if (tick <= 0) {
      _finishCallback?.call();
    } else {
      _tickCallback?.call(Duration(milliseconds: tick));
    }
  }

  cancel() {
    _timer?.cancel();
  }

  dispose() {
    _tickCallback = null;
    _finishCallback = null;
    _timer?.cancel();
  }

  updateTime({Duration interval = kDefaultInterval, required Duration totalTime}) {
    this._interval = interval;
    this._totalTime = totalTime;
    start();
  }
}
