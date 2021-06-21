import 'package:flutter/material.dart';

class ConnectionLostScreen extends StatelessWidget {
  static const String id = 'ConnectionLost';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            child: ClipShadowPath(
              clipper: _CircularClipper(),
              shadow: Shadow(blurRadius: 20.0),
              child: Image(
                width: double.infinity,
                image: AssetImage('assets/images/connection_lost.png'),
              ),
            ),
          ),
          Text(
            "Connection Lost",
            style: Theme.of(context).textTheme.headline3!,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                "\nBeep Bop Beep Bop,\n\nError in connecting to the server!\n\n Try Again Later!!!",
                style: TextStyle(fontSize: 35),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - size.width / 4,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    required this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({
    required this.shadow,
    required this.clipper,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
