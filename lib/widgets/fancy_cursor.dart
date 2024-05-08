import 'package:flutter/material.dart';

class FancyCursor extends StatelessWidget {
  final Offset position;
  const FancyCursor({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 10, // Adjust based on cursor width
      top: position.dy - 60, // Adjust based on cursor height
      child: Container(
        width: 40, // Cursor width
        height: 120, // Cursor height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 0.8],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 20,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
