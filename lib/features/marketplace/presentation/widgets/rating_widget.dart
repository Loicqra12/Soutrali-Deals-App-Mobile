import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color? color;
  final bool showText;

  const RatingWidget({
    Key? key,
    required this.rating,
    this.size = 16,
    this.color,
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final starColor = color ?? Colors.amber[700]!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return Icon(Icons.star, size: size, color: starColor);
            } else if (index == rating.floor() && rating % 1 != 0) {
              return Icon(Icons.star_half, size: size, color: starColor);
            } else {
              return Icon(Icons.star_border, size: size, color: starColor);
            }
          }),
        ),
        if (showText) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size * 0.75,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
