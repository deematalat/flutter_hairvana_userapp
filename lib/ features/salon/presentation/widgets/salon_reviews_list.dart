import 'package:flutter/material.dart';

class SalonReviewsList extends StatelessWidget {
  final List<String> reviews;
  const SalonReviewsList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        ...reviews.map((review) => ListTile(title: Text(review))).toList(),
      ],
    );
  }
} 