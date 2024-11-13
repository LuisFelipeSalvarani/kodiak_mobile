import 'package:flutter/material.dart';

import '../utils/constants.dart';

Widget buildSquareButton(IconData icon, String label, VoidCallback onPressed) {
  return Expanded(
    child: AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onPressed,
        child: LayoutBuilder(builder: (context, constrains) {
          double iconSize = constrains.maxWidth * 0.4;
          double fontSize = constrains.maxWidth * 0.12;

          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(darkBlue),
                      Color(lightBlue),
                    ]),
                color: const Color(darkBlue),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 5))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: iconSize,
                  color: const Color(white),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  label,
                  style:
                      TextStyle(color: const Color(white), fontSize: fontSize),
                )
              ],
            ),
          );
        }),
      ),
    ),
  );
}
