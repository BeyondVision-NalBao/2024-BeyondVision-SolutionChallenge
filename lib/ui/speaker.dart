import 'package:beyond_vision/core/core.dart';
import 'package:flutter/material.dart';

class Speaker extends StatelessWidget {
  const Speaker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const SizedBox(height: 70),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: const Color(boxColor),
                    borderRadius: BorderRadius.circular(30)),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "무엇을 하고\n싶으신가요?",
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(fontYellowColor),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            CustomPaint(
              size: const Size(50, 50), // 원하는 크기로 조절
              painter: InvertedTrianglePainter(),
            ),
            const SizedBox(
              height: 350,
            ),
            const CircleAvatar(
                radius: 50,
                backgroundColor: Color(boxColor),
                child: Icon(Icons.mic, size: 50, color: Color(fontYellowColor)))
          ],
        ));
  }
}

class InvertedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(boxColor)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // 왼쪽 하단
    path.lineTo(size.width, 0); // 상단 중앙
    path.lineTo(size.width / 2, size.height); // 오른쪽 하단
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
