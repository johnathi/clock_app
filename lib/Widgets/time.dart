import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimeView extends StatefulWidget {
  const TimeView({super.key});

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    String formattedTime = DateFormat('hh:mm').format(dateTime);
    String format = DateFormat('a').format(dateTime).toUpperCase();


    return Container(
      // margin: EdgeInsets.only(left:50),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(formattedTime,
            style: GoogleFonts.kanit(
            color: Color(0xFFEAECFF),
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),),
        SizedBox(width: 10,),
        Padding(
          padding: const EdgeInsets.only(bottom:5),
          child: Text(format,
              style: GoogleFonts.kanit(
              color: Color(0xFFEAECFF),
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),),
        ),
        ],
      )
    );
  }
}
