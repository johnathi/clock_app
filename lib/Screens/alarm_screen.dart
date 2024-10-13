import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Center(
              child: Text("Alarm",
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
