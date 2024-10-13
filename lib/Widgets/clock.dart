import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  //60 sec - 360, 1 sec - 6degree
  //12 hours  - 360, 1 hour - 30degrees, 1 min - 0.5degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = const Color(0xFFEAECFF);
    var fullFillBrush = Paint()..color = const Color(0xFF2D2F41);

    var outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    var coverOutlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    var coverOutlineBrushGradient = Paint()
      ..shader = RadialGradient(
        colors: [Color(0xFFEAECFF), Color(0xFF2D2F41)],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;


    var centerFillBrush = Paint()..color = Colors.red;

    var secHandBrush = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    var minHandBrush = Paint()
      ..shader = const RadialGradient(colors: [Color(0xFF2D2F41), Color(0xFF2D2F41)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    var hourHandBrush = Paint()
      ..shader = const RadialGradient(colors: [Color(0xFF2D2F41), Color(0xFF2D2F41)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    var longDashBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    var shortDashBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;

    canvas.drawCircle(center, radius - 10, fullFillBrush);
    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX +
        50 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        50 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 90 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 90 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 3, centerFillBrush);

    var outerLongCircleRadius = radius - 30;
    var innerLongCircleRadius = radius - 20;
    for (double i = 0; i < 360; i += 30) {
      var x1 = centerX + outerLongCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerLongCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerLongCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerLongCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), longDashBrush);
    }

    var outerShortCircleRadius = radius - 26;
    var innerShortCircleRadius = radius - 30;
    for (double i = 0; i < 360; i += 6) {
      var x1 = centerX + outerShortCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerShortCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerShortCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerShortCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), shortDashBrush);
    }

    for (int i = 1; i <= 12; i++) {
      double angle = (i * 30) * pi / 180;
      double x = centerX + (radius - 55) * cos(angle);
      double y = centerX + (radius - 55) * sin(angle);

      var textPainter = TextPainter(
        text: TextSpan(
          text: i.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      // Save the current state of the canvas
      canvas.save();

      // Move the canvas origin to the text position
      canvas.translate(x, y);

      // Rotate the canvas
      canvas.rotate((0 * 30) * pi / 180 + pi / 2);

      // Draw the text at the new origin
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

      // Restore the canvas to its previous state
      canvas.restore();

      canvas.drawCircle(center, radius - 10, coverOutlineBrush);

      canvas.drawCircle(center, radius - 3, coverOutlineBrushGradient);
    }



  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}