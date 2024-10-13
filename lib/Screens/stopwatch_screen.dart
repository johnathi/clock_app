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
      // _flags.insert(0, _formatTime(_stopwatch.elapsedMilliseconds));
    });
  }

  int _parseTime(String formattedTime) {
    var parts = formattedTime.split(RegExp(r'[:.]'));
    var hours = int.parse(parts[0]);
    var minutes = int.parse(parts[1]);
    var seconds = int.parse(parts[2]);
    var milliseconds = int.parse(parts[3]);
    return (hours * 3600 + minutes * 60 + seconds) * 1000 + milliseconds;
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40,),
          Text(
            _formatTime(_stopwatch.elapsedMilliseconds),
            style: GoogleFonts.kanit(
              color: Color(0xFFEAECFF),
              fontSize: 48,
              fontWeight: FontWeight.w400,
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width*.95,
              height: MediaQuery.sizeOf(context).height*.4,
              child: ListView.builder(
                itemCount: _flags.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          '${index + 1}. ',
                          style: GoogleFonts.kanit(
                          color: Color(0xFFEAECFF),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),),

                        SizedBox(width:10),

                        Text(_flags[index],
                          style: GoogleFonts.kanit(
                          color: Color(0xFFEAECFF),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),),

                        SizedBox(width:10),

                        Text(
                          index == 0
                              ? '${_flags[index]}'
                              : '+ ${_formatTime(_parseTime(_flags[index]) - _parseTime(_flags[index - 1]))}',
                          style: GoogleFonts.kanit(
                            color: Color(0xFFEAECFF),
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                    child: Container(
                        margin:  EdgeInsets.all(5),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFEAECFF),
                        ),
                        child: Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow,size: 30,))),
                        // child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'))),
                SizedBox(width: 50),
                GestureDetector(
                  onTap: _stopwatch.isRunning ?_flagTime : _resetStopwatch,
                  child: Container(
                    margin:  EdgeInsets.all(5),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFEAECFF),
                    ),
                    child: Icon(_stopwatch.isRunning ? Icons.flag :Icons.stop,size: 30,),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}