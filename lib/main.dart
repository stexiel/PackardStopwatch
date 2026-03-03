import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Packard Stopwatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
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
  int _milliseconds = 0;
  bool _isRunning = false;
  Timer? _timer;
  DateTime? _lastTapTime;
  bool _liveActivityActive = false;
  
  static const platform = MethodChannel('com.packard.stopwatch/live_activity');

  void _startStop() {
    setState(() {
      if (_isRunning) {
        _timer?.cancel();
        _isRunning = false;
      } else {
        _isRunning = true;
        _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
          setState(() {
            _milliseconds += 10;
            if (_liveActivityActive && _milliseconds % 100 == 0) {
              _updateLiveActivity();
            }
          });
        });
      }
      if (_liveActivityActive) {
        _updateLiveActivity();
      }
    });
  }

  void _reset() {
    setState(() {
      _timer?.cancel();
      _milliseconds = 0;
      _isRunning = false;
      if (_liveActivityActive) {
        _updateLiveActivity();
      }
    });
  }
  
  Future<void> _toggleLiveActivity() async {
    if (!Platform.isIOS) return;
    
    try {
      if (_liveActivityActive) {
        await platform.invokeMethod('endLiveActivity');
        setState(() {
          _liveActivityActive = false;
        });
      } else {
        await platform.invokeMethod('startLiveActivity', {
          'elapsedTime': _milliseconds / 1000.0,
          'isRunning': _isRunning,
        });
        setState(() {
          _liveActivityActive = true;
        });
      }
    } catch (e) {
      print('Error toggling Live Activity: $e');
    }
  }
  
  Future<void> _updateLiveActivity() async {
    if (!_liveActivityActive || !Platform.isIOS) return;
    
    try {
      await platform.invokeMethod('updateLiveActivity', {
        'elapsedTime': _milliseconds / 1000.0,
        'isRunning': _isRunning,
      });
    } catch (e) {
      print('Error updating Live Activity: $e');
    }
  }

  String _formatTime(int milliseconds) {
    int totalSeconds = milliseconds ~/ 1000;
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    int ms = (milliseconds % 1000) ~/ 10;
    
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
  }

  void _handleTap() {
    final now = DateTime.now();
    
    if (_lastTapTime != null && now.difference(_lastTapTime!) < const Duration(milliseconds: 300)) {
      _reset();
      _lastTapTime = null;
    } else {
      _lastTapTime = now;
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_lastTapTime == now) {
          _startStop();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: _handleTap,
            child: Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatTime(_milliseconds),
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: _isRunning ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Tap - Start/Pause\nDouble Tap - Reset',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (Platform.isIOS)
            Positioned(
              top: 50,
              right: 20,
              child: GestureDetector(
                onTap: _toggleLiveActivity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _liveActivityActive 
                        ? Colors.green.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                    border: Border.all(
                      color: _liveActivityActive 
                          ? Colors.green
                          : Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _liveActivityActive ? '✓' : '📌',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _liveActivityActive ? 'Live Activity' : 'Enable Live Activity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
