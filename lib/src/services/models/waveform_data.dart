import 'dart:math';

import 'package:audio/src/services/models/waveform_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class WaveformData {
  final WaveformResponse waveformResponse;
  List<double> _scaledData;

  WaveformData(this.waveformResponse, this._scaledData);

  int frameIdxFromPercent(double percent) {
    if (percent == null) {
      return 0;
    }

    if (percent < 0) {
      percent = 0;
    } else if (percent > 100) {
      percent = 100;
    }

    if (percent > 0.0 && percent < 1) {
      return ((waveformResponse.data.length.toDouble() / 2) * percent).floor();
    }

    var idx = ((waveformResponse.data.length.toDouble() / 2) * (percent / 100))
        .floor();
    final maxIdx = (waveformResponse.data.length.toDouble() / 2 * 0.98).floor();
    if (idx > maxIdx) {
      idx = maxIdx;
    }
    return idx;
  }

  Path path(
    Size size, {
    double zoomLevel = 1.0,
    int fromFrame = 0,
  }) {
    if (!_isDataScaled()) {
      _scaleData();
    }

    if (zoomLevel == null || zoomLevel < 1) {
      zoomLevel = 1;
    } else if (zoomLevel > 100) {
      zoomLevel = 100;
    }

    if (zoomLevel == 1.0 && fromFrame == 0) {
      return _path(_scaledData, size);
    }

    if (fromFrame * 2 > (waveformResponse.data.length * 0.98).floor()) {
      debugPrint('from frame is too far at $fromFrame');
      fromFrame = ((waveformResponse.data.length / 2) * 0.98).floor();
    }

    final endFrame = (fromFrame * 2 +
            ((_scaledData.length - fromFrame * 2) * (1 - (zoomLevel / 100))))
        .floor();

    return _path(_scaledData.sublist(fromFrame * 2, endFrame), size);
  }

  bool _isDataScaled() {
    return _scaledData != null &&
        _scaledData.length == waveformResponse.data.length;
  }

  Path _path(List<double> samples, Size size) {
    final middle = size.height / 2;
    var i = 0;

    final minPoints = [];
    final maxPoints = [];

    final t = size.width / samples.length;
    for (var _i = 0; _i < samples.length; _i++) {
      final d = samples[_i];

      if (_i % 2 != 0) {
        minPoints.add(Offset(t * i, middle - middle * d));
      } else {
        maxPoints.add(Offset(t * i, middle - middle * d));
      }

      i++;
    }

    final path = Path();
    path.moveTo(0, middle);
    maxPoints.forEach((o) => path.lineTo(o.dx, o.dy));
    path.lineTo(size.width, middle);
    minPoints.reversed
        .forEach((o) => path.lineTo(o.dx, middle - (middle - o.dy)));

    path.close();
    return path;
  }

  void _scaleData() {
    final max = pow(2, waveformResponse.bits - 1).toDouble();
    final dataSize = waveformResponse.data.length;
    _scaledData = List<double>(dataSize);

    for (var i = 0; i < dataSize; i++) {
      _scaledData[i] = waveformResponse.data[i].toDouble() / max;
      if (_scaledData[i] > 1) {
        _scaledData[i] = 1;
      }
      if (_scaledData[i] < -1) {
        _scaledData[i] = -1;
      }
    }
  }
}
