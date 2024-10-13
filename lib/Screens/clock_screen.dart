import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Widgets/clock.dart';
import '../Widgets/time.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {


  @override
  Widget build(BuildContext context) {
    String formattedDay = DateFormat('EEEE').format(DateTime.now());
    String formattedDate = DateFormat('d  MMM').format(DateTime.now());
    String formattedYear = DateFormat('y').format(DateTime.now());


    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Center(
            child: Text(
              "Clock",
              style: GoogleFonts.kanit(
                color: Color(0xFFEAECFF),
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFF2D2F41),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              formattedDay,
              style: GoogleFonts.kanit(
                color: Color(0xFFEAECFF),
                fontSize: 45,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30),

            ClockView(),

            SizedBox(height: 20),


            const TimeView(),

            // SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedDate,
                  style: GoogleFonts.kanit(
                    color: Color(0xFFEAECFF),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    formattedYear,
                    style: GoogleFonts.kanit(
                      color: Color(0xFFEAECFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
