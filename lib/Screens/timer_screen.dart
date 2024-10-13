import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Center(
              child: Text("Timer",
                style: GoogleFonts.kanit(
                  color: Color(0xFFEAECFF),
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              )
          ),
        ),
      ),

    );
  }
}
