import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockVie extends StatefulWidget {
  final double? size;

  const ClockVie({Key? key, this.size}) : super(key: key);

  @override
  State<ClockVie> createState() => _ClockVieState();
}

class _ClockVieState extends State<ClockVie> {
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
      height: widget.size,
      width: widget.size,
      child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          )),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  // 60 sec -  360 , 1 sec 6degree
  //12 hour,1 hr - 30degree , 1 - min 0.2 degree

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerY, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()
      ..color = const Color(
        0xFF444974,
      );
    var OutlineBrush = Paint()
      ..color = const Color(0xFFEAeCFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var CenterfillBrush = Paint()..color = Color(0xFFEAeCFF);

    var SecHandBrush = Paint()
      ..color = const Color.fromARGB(255, 255, 183, 77)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 60;
    //
    var MinHandBrush = Paint()
      ..shader = const RadialGradient(colors: [
        Color(0xFFEa74AB),
        Color(0xFFC279FB),
      ]).createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 30;
    //
    //

    var HourHandBrush = Paint()
      ..color = const Color(0xFFEAeCFF)
      ..shader = const RadialGradient(colors: [
        Color(0xFF748EF6),
        Color(0xFF77DDFF),
      ]).createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 24;

    var dashBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius * 0.7, fillBrush);
    canvas.drawCircle(center, radius * 0.7, OutlineBrush);

    var hourHandx = centerX +
        radius *
            0.4 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandx, hourHandY), HourHandBrush);

    var minHandX = centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);

    canvas.drawLine(center, Offset(minHandX, minHandY), MinHandBrush);

    var secHandX = centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);

    canvas.drawLine(center, Offset(secHandX, secHandY), SecHandBrush);

    canvas.drawCircle(center, radius * 0.12, CenterfillBrush);

    //1.center = starting point ,2. offset = ending point thiredone is paint

    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
