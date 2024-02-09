import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/utils.dart';

typedef OnChangeCallback = void Function(int index);

class SlideRatingDialog extends StatefulWidget {
  /// Callback When rating changes.
  final Function(int value)? onRatingChanged;

  /// Submit button pressed.
  final Function()? buttonOnTap;

  /// pointer widget
  final Widget? pointerWidget;

  /// Dialog Title
  final String title;

  /// Dialog Sub Title
  final String subTitle;

  /// Button Title
  final String buttonTitle;

  /// Color for submit Button
  final Color buttonColor;

  /// Color for background
  final Color backgroundColor;

  /// Color for foreground
  final Color foregroundColor;

  /// Color for tint
  final Color? ratingBarBackgroundColor;

  /// opacity
  final double? opacity;

  /// offset for the handle
  final double? yOffset;

  /// Dialog Cancel button
  final bool cancelButton;

  /// list of offsets
  final List<double>? positionList;

  const SlideRatingDialog(
      {Key? key,
      required this.onRatingChanged,
      this.title = "Rating",
      this.subTitle = "How was your experience with us?",
      this.buttonColor = Colors.deepPurpleAccent,
      this.backgroundColor = Colors.white,
      this.foregroundColor = Colors.black,
      this.pointerWidget,
      this.positionList,
      this.opacity,
      this.yOffset,
      this.cancelButton = true,
      required this.buttonOnTap,
      this.ratingBarBackgroundColor = const Color(0xFFF1F5F8),
      this.buttonTitle = "Submit"})
      : super(key: key);

  @override
  State<SlideRatingDialog> createState() => _SlideRatingDialogState();
}

class _SlideRatingDialogState extends State<SlideRatingDialog> {
  int starCount = 4;
  double dxSet = 200;
  double left = 0.0;
  double right = 0.0;

  List<int> list = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: widget.backgroundColor,
      surfaceTintColor: widget.backgroundColor,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        width: size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.cancelButton
                  ? Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: widget.foregroundColor,
                          size: 24.0,
                        ),
                      ),
                    )
                  : SizedBox(),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28.0, color: widget.foregroundColor, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 12.0,
                width: 0.0,
              ),
              Text(
                widget.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: widget.foregroundColor, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20.0,
                width: 0.0,
              ),
              /*      Image.asset(
                "assets/images/i$starCount.png",
                package: 'slide_rating_dialog',
                height: 110.0,
              ),
              const SizedBox(
                height: 12.0,
                width: 0.0,
              ),*/
              Text(
                getMessage(starCount),
                style: TextStyle(fontSize: 20.0, color: widget.foregroundColor, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30.0,
                width: 0.0,
              ),
              Stack(
                children: [
                  Container(
                    width: size.width * 0.8,
                    height: 64.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: widget.ratingBarBackgroundColor,
                    ),
                  ),
                  AnimatedContainer(
                    width: getWidth(context, starCount),
                    height: 64.0,
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: widget.backgroundColor.withOpacity(widget.opacity ?? 0.8),
                    ),
                  ),
                  Row(
                    children: List.generate(
                        list.length,
                        (index) => GestureDetector(
                              onTap: () {
                                managePosition(index + 1);
                              },
                              child: Container(
                                decoration: BoxDecoration(shape: BoxShape.circle, color: starCount < index + 1 ? ColorConstants.yellowButtonColor : ColorConstants.primaryColor),
                                height: 40,
                                width: 40,
                                child: Center(child: Text((index + 1).toString())),
                              ),
                            )),
                  ),
                  /*  Container(
                    width: size.width * 0.8,
                    height: 62.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.transparent),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              managePosition(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orangeAccent),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              managePosition(2);
                            },
                            */ /*  child: Image.asset(
                              starCount < 2 ? "assets/images/star_unselected.png" : "assets/images/star_selected.png",
                              package: 'slide_rating_dialog',
                              height: 38.0,
                              width: 38.0,
                            ),*/ /*

                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: starCount < 2 ? Colors.grey : Colors.orangeAccent),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              managePosition(3);
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: starCount < 3 ? Colors.grey : Colors.orangeAccent),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              managePosition(4);
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: starCount < 4 ? Colors.grey : Colors.orangeAccent),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              managePosition(5);
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: starCount < 5 ? Colors.grey : Colors.orangeAccent),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  Transform.translate(
                    //offset to manage
                    offset: Offset(dxSet, widget.yOffset ?? 0),
                    child: Draggable(
                      axis: Axis.horizontal,
                      affinity: Axis.horizontal,
                      maxSimultaneousDrags: 1,
                      onDragUpdate: (valo) {
                        if (valo.globalPosition.dx < size.width * 0.19) {
                          setState(() {
                            starCount = 1;
                          });
                        } else if (valo.globalPosition.dx > size.width * 0.25 && valo.globalPosition.dx < size.width * 0.3) {
                          setState(() {
                            starCount = 2;
                          });
                        } else if (valo.globalPosition.dx > size.width * 0.4 && valo.globalPosition.dx < size.width * 0.48) {
                          setState(() {
                            starCount = 3;
                          });
                        } else if (valo.globalPosition.dx > size.width * 0.57 && valo.globalPosition.dx < size.width * 0.63) {
                          setState(() {
                            starCount = 4;
                          });
                        } else if (valo.globalPosition.dx > size.width * 0.71) {
                          setState(() {
                            starCount = 5;
                          });
                        }
                      },
                      onDragEnd: (val) {
                        if (val.offset.dx < size.width * 0.14) {
                          managePosition(1);
                        } else if (val.offset.dx > size.width * 0.15 && val.offset.dx < size.width * 0.3) {
                          managePosition(2);
                        } else if (val.offset.dx > size.width * 0.3 && val.offset.dx < size.width * 0.48) {
                          managePosition(3);
                        } else if (val.offset.dx > size.width * 0.48 && val.offset.dx < size.width * 0.63) {
                          managePosition(4);
                        } else if (val.offset.dx > size.width * 0.7) {
                          managePosition(5);
                        } else {
                          managePosition(4);
                        }
                      },
                      feedback: poinerWid(),
                      childWhenDragging: SizedBox(
                        width: 50,
                        height: 50.0,
                      ),
                      child: poinerWid(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
                width: 0.0,
              ),
              GestureDetector(
                onTap: widget.buttonOnTap,
                child: Container(
                  width: size.width * 0.8,
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: widget.buttonColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.buttonTitle,
                    style: TextStyle(fontSize: 20.0, color: widget.backgroundColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void managePosition(int star) {
    double ab = 0.00;
    double value = ab;

    if (widget.positionList != null) {
      switch (star) {
        case 1:
          value = widget.positionList![0];
        case 2:
          value = widget.positionList![1];
        case 3:
          value = widget.positionList![2];
        case 4:
          value = widget.positionList![3];
        case 5:
          value = widget.positionList![4];
        case 6:
          value = widget.positionList![5];
        case 7:
          value = widget.positionList![6];
        case 8:
          value = widget.positionList![7];
        case 9:
          value = widget.positionList![8];
        case 10:
          value = widget.positionList![9];
      }
    } else {
      value = ab + (66 * (star - 1));
    }

    setState(() {
      starCount = star;
      dxSet = value;
    });
    widget.onRatingChanged!(star);
  }

  Widget poinerWid() {
    return widget.pointerWidget ?? Image.asset(ImageConstants.rating);
  }
}
