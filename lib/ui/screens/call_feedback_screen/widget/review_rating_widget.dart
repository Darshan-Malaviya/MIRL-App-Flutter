import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/call_feedback_screen/componnet/call_feedback_model.dart';

class ReviewRatingWidget extends ConsumerStatefulWidget {
  const ReviewRatingWidget({super.key, this.index});

  final index;

  @override
  ConsumerState<ReviewRatingWidget> createState() => _ReviewRatingWidgetState();
}

class _ReviewRatingWidgetState extends ConsumerState<ReviewRatingWidget> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(reportReviewProvider).afterLayout(widget.index);
      },
    );
  }

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
                feedBackWatch.callFeedbackList[widget.index].callFeedbackDataList.length,
                (position) {
                  CallFeedbackData element =
                      feedBackWatch.callFeedbackList[widget.index].callFeedbackDataList[position];
                  if (feedBackWatch.isLoaded) {
                    if (feedBackWatch.callFeedbackList[widget.index].callFeedbackDataList[position].currentDxPosition <=
                        feedBackWatch.callFeedbackList[widget.index].localPosition) {
                      element.criteriaSelectedIndex = position;
                      print(element.criteriaSelectedIndex);
                      selectedIndex.value = position;
                    }
                  }
                  if (position == 0) {
                    return SizedBox(
                        key: feedBackWatch.callFeedbackList[widget.index].callFeedbackDataList[position].formKey,
                        height: 50,
                        width: 24);
                  }
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        feedBackRead.changeCriteriaSelectedIndex(index: widget.index, position: position);
                      },
                      child: Container(
                        key: feedBackWatch.callFeedbackList[widget.index].callFeedbackDataList[position].formKey,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: feedBackWatch.isLoaded
                                ? feedBackWatch.callFeedbackList[widget.index].callFeedbackDataList[position]
                                            .currentDxPosition <=
                                        feedBackWatch.callFeedbackList[widget.index].localPosition
                                    ? ColorConstants.primaryColor
                                    : ColorConstants.yellowButtonColor
                                : ColorConstants.yellowButtonColor),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: BodySmallText(
                            title: position.toString(),
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
          ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (context, value, child) {
              if (!feedBackWatch.isLoaded) SizedBox.shrink();
              return Positioned(
                left: feedBackWatch.callFeedbackList[widget.index].localPosition,
                child: GestureDetector(
                  onHorizontalDragStart: (detail) {
                    feedBackRead.onHorizontalDragUpdate(detail, index: widget.index);
                  },
                  onHorizontalDragUpdate: (detail) {
                    feedBackRead.onHorizontalDragUpdate(detail, index: widget.index);
                  },
                  child: const Image(image: AssetImage(ImageConstants.rating)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
