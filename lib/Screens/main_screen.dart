import 'package:alarm_clock/Screens/stopwatch_screen.dart';
import 'package:alarm_clock/Screens/timer_screen.dart';
import 'package:flutter/material.dart';

import 'alarm_screen.dart';
import 'clock_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  List pages = [
    const ClockScreen(),
    const AlarmScreen(),
    const StopWatchScreen(),
    const TimerScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(30),

        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            // fixedColor: Color(0xFFEAECFF),
            backgroundColor: const Color(0xFFEAECFF),
            currentIndex: currentPageIndex,
            onTap: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            type : BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items:  [
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time,color: currentPageIndex==0?Colors.black : Colors.grey[700]),
                label: 'Clock',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm,color: currentPageIndex==1?Colors.black : Colors.grey[700]),
                label: 'Alarm',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer,color: currentPageIndex==2?Colors.black : Colors.grey[700]),
                label: 'Stopwatch',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hourglass_bottom,color: currentPageIndex==3?Colors.black : Colors.grey[700]),
                label: 'Timer',
              ),
            ],
          ),
        ),
      ),
      body: pages[currentPageIndex],
    );
  }
}
