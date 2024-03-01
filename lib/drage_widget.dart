import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';

typedef OnChange = void Function(int index);

class ReviewSlider extends StatefulWidget {
  const ReviewSlider({Key? key, required this.onChange}) : super(key: key);

  final OnChange onChange;

  @override
  _ReviewSliderState createState() => _ReviewSliderState();
}

class _ReviewSliderState extends State<ReviewSlider> with SingleTickerProviderStateMixin {
  List formKeyList = List.generate(11, (index) => GlobalKey<FormState>());
  List<Offset> currentPosition = [];
  double localPosition = 0.0;
  bool isLoaded = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    for (var element in formKeyList) {
      RenderBox box = element.currentContext?.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      currentPosition.add(position);
    }
    isLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: List.generate(
                    formKeyList.length,
                    (index) {
                      if (isLoaded) {
                        if (currentPosition[index].dx <= localPosition) {
                          selectedIndex = index;
                        }
                      }
                      if (index == 0) {
                        return SizedBox(key: formKeyList[index], height: 50, width: 24);
                      }
                      return Flexible(
                        child: GestureDetector(
                          onTap: () {
                            RenderBox box = formKeyList[index].currentContext?.findRenderObject() as RenderBox;
                            Offset position = box.localToGlobal(Offset.zero);
                            localPosition = position.dx;
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Container(
                            key: formKeyList[index],
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isLoaded
                                    ? currentPosition[index].dx <= localPosition
                                        ? Colors.purple
                                        : Colors.yellow
                                    : Colors.yellow),
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Text(
                                index.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: isLoaded
                                        ? currentPosition[index].dx <= localPosition
                                            ? Colors.white
                                            : Colors.black
                                        : Colors.black),
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
                left: localPosition,
                child: GestureDetector(
                  onHorizontalDragStart: onHorizontalDragUpdate,
                  onHorizontalDragUpdate: onHorizontalDragUpdate,
                  child: const Image(image: AssetImage(ImageConstants.rating)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onHorizontalDragUpdate(details) {
    if (details.globalPosition.dx - 30 <= currentPosition.first.dx) {
      return;
    }
    if (currentPosition.last.dx + 50 >= details.globalPosition.dx) {
      localPosition = details.globalPosition.dx;
      setState(() {});
    }
  }
}
