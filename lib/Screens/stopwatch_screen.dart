import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  List<String> _flags = [];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _stopwatch.start();
    });
  }

  void _stopStopwatch() {
    setState(() {
      _stopwatch.stop();
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _flags.clear();
    });
  }

  void _flagTime() {
    setState(() {
      _flags.add(_formatTime(_stopwatch.elapsedMilliseconds));
    });
  }

  String _formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    var milli = (milliseconds % 1000).toString().padLeft(3, '0');
    return "$hours:$minutes:$seconds.$milli";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Center(
              child: Text("Stopwatch",
                style: GoogleFonts.kanit(
                  color: Color(0xFFEAECFF),
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              )
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _formatTime(_stopwatch.elapsedMilliseconds),
            style: TextStyle(fontSize: 48.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _resetStopwatch,
                child: Text('Reset'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _flagTime,
                child: Text('Flag'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _flags.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_flags[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}