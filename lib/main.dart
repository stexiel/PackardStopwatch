import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Packard Stopwatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Offset _position = const Offset(100, 100);
  bool _isRunning = false;
  int _lastTapTime = 0;
  static const int _doubleTapThreshold = 300;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {});
    });
  }

  void _handleTap() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeDiff = currentTime - _lastTapTime;

    if (timeDiff < _doubleTapThreshold && timeDiff > 0) {
      _handleDoubleTap();
    } else {
      _handleSingleTap();
    }

    _lastTapTime = currentTime;
  }

  void _handleSingleTap() {
    setState(() {
      if (_isRunning) {
        _stopwatch.stop();
        _timer?.cancel();
        _isRunning = false;
      } else {
        _stopwatch.start();
        _startTimer();
        _isRunning = true;
      }
    });
  }

  void _handleDoubleTap() {
    setState(() {
      _stopwatch.reset();
      _stopwatch.stop();
      _timer?.cancel();
      _isRunning = false;
    });
  }

  void _handleLongPress() {
    _timer?.cancel();
    Navigator.of(context).pop();
  }

  String _formatTime() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    final minutes = (milliseconds ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((milliseconds % 60000) ~/ 1000).toString().padLeft(2, '0');
    final millis = ((milliseconds % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds:$millis';
  }

  Color _getBackgroundColor() {
    if (_isRunning) {
      return Colors.green;
    } else if (_stopwatch.elapsedMilliseconds > 0) {
      return Colors.red;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Stack(
        children: [
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: GestureDetector(
              onTap: _handleTap,
              onLongPress: _handleLongPress,
              onPanUpdate: (details) {
                setState(() {
                  _position = Offset(
                    _position.dx + details.delta.dx,
                    _position.dy + details.delta.dy,
                  );
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  _formatTime(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
