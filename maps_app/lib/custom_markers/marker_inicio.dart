import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarkerInicioPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    
    final double circuloNegroR=20;
    final double circuloBlancoR=10;

    Paint paint = new Paint()
      ..color = Colors.black;

    canvas.drawCircle(
      Offset(circuloNegroR,size.height-circuloNegroR),
      20, 
      paint);

    paint.color=Colors.white;
    canvas.drawCircle(
      Offset(circuloNegroR, size.height -circuloNegroR),
      circuloBlancoR,
      paint);

      // sombra
      final Path path = new Path();

      path.moveTo(40 ,20 );
      path.lineTo(size.width-10, 20);
      path.lineTo(size.width-10, 100);
      path.lineTo(40, 100);
      canvas.drawShadow(
        path, 
        Colors.black87, 
        10, 
        false
        );
        // cajs

        final cajaBlanca= Rect.fromLTWH(40, 20, size.width-55, 80);
        canvas.drawRect(cajaBlanca, paint);
        paint.color=Colors.black;
        final cajaNegra= Rect.fromLTWH(40, 20, 70, 80);
        canvas.drawRect(cajaNegra, paint);

  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}