import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

typedef RatingChangeCallback = void Function(int rating);

class ReviewRatingWidget extends ConsumerStatefulWidget {
  final int ratingCount;
  final int rating;
  final RatingChangeCallback onRatingChanged;

  const ReviewRatingWidget({super.key, this.ratingCount = 5, this.rating = 0, required this.onRatingChanged});

  @override
  ConsumerState<ReviewRatingWidget> createState() => _ReviewRatingWidgetState();
}

class _ReviewRatingWidgetState extends ConsumerState<ReviewRatingWidget> {
  Widget buildStar(BuildContext context, int index) {
    Row icon;
    if (index >= widget.rating) {
      icon = Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: ColorConstants.yellowButtonColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.dropDownBorderColor,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: BodySmallText(
                title: '${index + 1}',
                titleColor: ColorConstants.buttonTextColor,
                titleTextAlign: TextAlign.center,
                fontFamily: FontWeightEnum.w400.toInter,
              ),
            ),
          ).addMarginX(4),
        ],
      );
    } else {
      icon = Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.dropDownBorderColor,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: BodySmallText(
                title: '${index + 1}',
                titleColor: ColorConstants.buttonTextColor,
                titleTextAlign: TextAlign.center,
                fontFamily: FontWeightEnum.w400.toInter,
              ),
            ),
          ).addMarginX(4),
        ],
      );
    }
    return InkResponse(
      onTap: () => widget.onRatingChanged(index + 1),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            widget.ratingCount,
            (index) => InkResponse(child: buildStar(context, index))));
  }
}
