import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;

  const StarRating({super.key, this.starCount = 5, this.rating = 0, required this.onRatingChanged});

  Widget buildStar(BuildContext context, int index) {
    Image icon;
    if (index >= rating) {
      icon = Image.asset(ImageConstants.rating);
    }
    /* else if (index > rating - 1 && index < rating) {
      icon =  Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    }*/
    else {
      icon = Image.asset(ImageConstants.starFill);
    }
    return InkResponse(
      onTap: () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
            starCount,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: buildStar(context, index),
                )));
  }
}
