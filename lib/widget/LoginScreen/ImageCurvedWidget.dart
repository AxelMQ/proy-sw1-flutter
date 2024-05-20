
import 'package:flutter/material.dart';

class ImageCurvedWidget extends StatelessWidget {
  const ImageCurvedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCurveClipper(),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: double.infinity,
        child: Image.asset(
          'assets/plato_comida.jpeg',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Parte inferior izquierda
    path.quadraticBezierTo(size.width / 2, size.height + 17, size.width,
        size.height - 50); // Curva
    path.lineTo(size.width, 0); // Parte inferior derecha
    path.close(); // Cerrar la forma
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
