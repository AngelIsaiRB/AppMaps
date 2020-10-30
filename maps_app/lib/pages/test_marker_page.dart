import 'package:flutter/material.dart';
import 'package:maps_app/custom_markers/custom_markers.dart';


class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          
          child: CustomPaint(
            // painter: MarkerInicioPainter(50),
            painter: MarkerDestinoPainter("este es la descrsdadadqwwe  essdfs dfsipciondsksd,asdasd", 2500),
          ),
        ),
      ),
    );
  }
}