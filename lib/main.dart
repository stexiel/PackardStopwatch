import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Packard Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Offset _position = const Offset(100, 100);
  int _lastTapTime = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime() {
    final milliseconds = _stopwatch.elapsedMilliseconds;
    final minutes = (milliseconds ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((milliseconds % 60000) ~/ 1000).toString().padLeft(2, '0');
    final ms = ((milliseconds % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds:$ms';
  }

  void _handleTap() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeDiff = currentTime - _lastTapTime;

    if (timeDiff < 300 && timeDiff > 0) {
      // Двойной тап - сброс
      setState(() {
        _stopwatch.reset();
      });
    } else {
      // Одиночный тап - старт/пауза
      Future.delayed(const Duration(milliseconds: 300), () {
        if (DateTime.now().millisecondsSinceEpoch - currentTime < 350) {
          setState(() {
            if (_stopwatch.isRunning) {
              _stopwatch.stop();
            } else {
              _stopwatch.start();
            }
          });
        }
      });
    }

    _lastTapTime = currentTime;
  }

  void _handleLongPress() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выход'),
        content: const Text('Выйти из секундомера?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // На iOS это просто закроет диалог
            },
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
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
                  color: _stopwatch.isRunning ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
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
                    letterSpacing: 2,
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
