import 'package:flutter/material.dart';

SnackBar buildCustomSnackBar({
  required String title,
  required String message,
  required Color backgroundColor,
  required IconData icon,
  required Color iconColor,
}) {
  return SnackBar(
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    content: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 70,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 25,
          left: 20,
          child: ClipRRect(
            child: Stack(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
