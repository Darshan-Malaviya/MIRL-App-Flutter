import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ReviewRatingWidget extends ConsumerStatefulWidget {
  const ReviewRatingWidget({super.key});

  @override
  ConsumerState<ReviewRatingWidget> createState() => _ReviewRatingWidgetState();
}

class _ReviewRatingWidgetState extends ConsumerState<ReviewRatingWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(ref.read(reportReviewProvider).afterLayout);
  }

/*  Widget buildStar(BuildContext context, int index) {
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
  }*/

  @override
  Widget build(BuildContext context) {
    final feedBackWatch = ref.watch(reportReviewProvider);
    final feedBackRead = ref.read(reportReviewProvider);

    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(
                feedBackWatch.formKeyList.length,
                (index) {
                  if (feedBackWatch.isLoaded) {
                    if (feedBackWatch.currentPosition[index].dx <= feedBackWatch.localPosition) {
                      feedBackWatch.criteriaSelectedIndex = index;
                    }
                  }
                  if (index == 0) {
                    return SizedBox(key: feedBackWatch.formKeyList[index], height: 50, width: 24);
                  }
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        feedBackRead.changeCriteriaSelectedIndex(index);
                      },
                      child: Container(
                        key: feedBackWatch.formKeyList[index],
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: feedBackWatch.isLoaded
                                ? feedBackWatch.currentPosition[index].dx <= feedBackWatch.localPosition
                                    ? ColorConstants.primaryColor
                                    : ColorConstants.yellowButtonColor
                                : ColorConstants.yellowButtonColor),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: BodySmallText(
                            title: index.toString(),
                            titleColor: ColorConstants.buttonTextColor,
                            fontFamily: FontWeightEnum.w400.toInter,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: feedBackWatch.localPosition,
            child: GestureDetector(
              onHorizontalDragStart: feedBackRead.onHorizontalDragUpdate,
              onHorizontalDragUpdate: feedBackRead.onHorizontalDragUpdate,
              child: const Image(image: AssetImage(ImageConstants.rating)),
            ),
          )
        ],
      ),
    );
    // return Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(widget.ratingCount, (index) => InkResponse(child: buildStar(context, index))));
  }
}
