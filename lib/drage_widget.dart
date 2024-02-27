import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';

import 'package:vector_math/vector_math.dart' as v_math;

typedef OnChange = void Function(int index);

class ReviewSlider extends StatefulWidget {
  const ReviewSlider({
    Key? key,
    required this.onChange,
    this.initialValue = 0,
    // this.options = const ['Terrible', 'Bad', 'Okay', 'Good', 'Great'],
    this.options = const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    this.optionStyle,
    this.width,
    this.circleDiameter = 60,
  })  : assert(
          initialValue >= 0 && initialValue <= 9,
          'Initial value should be between 0 and 4',
        ),
        assert(
          options.length == 10,
          'Reviews options should be 10',
        ),
        super(key: key);

  /// The onChange callback calls every time when a pointer have changed
  /// the value of the slider and is no longer in contact with the screen.
  /// Callback function argument is an int number from 0 to 4, where
  /// 0 is the worst review value and 4 is the best review value

  /// ```dart
  /// ReviewSlider(
  ///  onChange: (int value){
  ///    print(value);
  ///  }),
  /// ),
  /// ```

  final OnChange onChange;
  final int initialValue;
  final List<String> options;
  final TextStyle? optionStyle;
  final double? width;
  final double circleDiameter;

  @override
  _ReviewSliderState createState() => _ReviewSliderState();
}

class _ReviewSliderState extends State<ReviewSlider> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late double _animationValue;
  late double _xOffset;
  var initValue = 0.0;

  late AnimationController _controller;
  late Tween<double> _tween;
  int selectedValue1 = 0;
  int selectedValue2 = 0;

  void onChange1(int value) {
    setState(() {
      selectedValue1 = value;
    });
  }

  void onChange2(int value) {
    setState(() {
      selectedValue2 = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    initValue = widget.initialValue.toDouble();
    _controller = AnimationController(
      value: initValue,
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _tween = Tween(end: initValue);
    _animation = _tween.animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: _controller,
      ),
    )..addListener(() {
        setState(() {
          _animationValue = _animation.value;
        });
      });
    _animationValue = initValue;
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    widget.onChange(widget.initialValue);
    print("afterlayout :::::: ${widget.initialValue}");
  }

  void handleTap(int state) {
    _controller.duration = Duration(milliseconds: 400);
    _tween.begin = _tween.end;
    _tween.end = state.toDouble();
    _controller.reset();
    _controller.forward();

    widget.onChange(state);
    print("handleTap ::::::::::: $state");
    print("tween.begin ::::::::::: ${_tween.end}");
    print("tween.end ::::::::::: ${state.toDouble()}");
  }

  void _onDrag(double dx, innerWidth) {
    var newAnimatedValue = _calcAnimatedValueFormDragX(dx, innerWidth);

    if (newAnimatedValue > 0 && newAnimatedValue < widget.options.length - 1) {
      setState(
        () {
          _animationValue = newAnimatedValue;
        },
      );
    }
  }

  void _onDragEnd(_) {
    _controller.duration = Duration(milliseconds: 100);
    _tween.begin = _animationValue;
    _tween.end = _animationValue.round().toDouble();
    _controller.reset();
    _controller.forward();
    // _controller.animateTo(_animationValue);

    widget.onChange(_animationValue.round());
    print("_onDragEnd onchange : ${_animationValue.round()} ");
  }

  void _onDragStart(x, width) {
    var oneStepWidth = (width - widget.circleDiameter) / (widget.options.length - 1);
    print("oneStepWidth ::::::::::: $oneStepWidth");
    _xOffset = x - (oneStepWidth * _animationValue);
    print("_xOffset ::::::::::: $_xOffset");
  }

  _calcAnimatedValueFormDragX(x, innerWidth) {
    x = x - _xOffset;
    print("_calcAnimatedValueFormDragX : $x");
    print("_calcAnimatedValueFormDragXfor : ${x / (innerWidth - widget.circleDiameter) * (widget.options.length - 1)}");
    return x / (innerWidth - widget.circleDiameter) * (widget.options.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    print("animation value ::::::: ${_animationValue}");
    print("initial value ::::::: ${initValue}");
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, size) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                MeasureLine(
                  states: widget.options,
                  handleTap: handleTap,
                  animationValue: _animationValue,
                  width: widget.width != null && widget.width! < size.maxWidth ? widget.width! : size.maxWidth,
                  optionStyle: widget.optionStyle,
                  circleDiameter: widget.circleDiameter,
                ),
                MyIndicator(
                  circleDiameter: widget.circleDiameter,
                  animationValue: _animationValue,
                  width: widget.width != null && widget.width! < size.maxWidth ? widget.width : size.maxWidth,
                  onDragStart: (details) {
                    _onDragStart(details.globalPosition.dx, widget.width != null && widget.width! < size.maxWidth ? widget.width : size.maxWidth);
                    //_controller.animateTo(_animationValue);
                  },
                  onDrag: (details) {
                    _onDrag(details.globalPosition.dx, widget.width != null && widget.width! < size.maxWidth ? widget.width : size.maxWidth);
                    //_controller.animateTo(_animationValue);
                  },
                  onDragEnd: _onDragEnd,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//const double circleDiameter = 30;
const double paddingSize = 0;

class MeasureLine extends StatelessWidget {
  MeasureLine({
    required this.handleTap,
    required this.animationValue,
    required this.states,
    required this.width,
    this.optionStyle,
    required this.circleDiameter,
  });

  final double animationValue;
  final Function handleTap;
  final List<String> states;
  final double width;
  final TextStyle? optionStyle;
  final double circleDiameter;

  List<Widget> _buildUnits() {
    var res = <Widget>[];
    var animatingUnitIndex = animationValue.round();
    var unitAnimatingValue = (animationValue * 10 % 10 / 10).abs() * 3;
    print("unitAnimatingValue ::::::::::: $unitAnimatingValue");

    states.asMap().forEach((index, text) {
      var paddingTop = 0.0;
      var scale = 0.5;
      var opacity = .3;
      if (animatingUnitIndex == index) {
        paddingTop = 0.0;
        scale = (1 - unitAnimatingValue);
        opacity = 0.3 + unitAnimatingValue * 0.7;
      }

     /* res.add(LimitedBox(
        key: ValueKey(text),
        maxWidth: circleDiameter,
        child: GestureDetector(
          onTap: () {
            handleTap(index);
          },
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(shape: BoxShape.circle, color: index < animationValue.round() ? Colors.purple : Colors.yellow),
            height: 30,
            width: 30,
            child: Center(child: Text((index + 1).toString(),style: TextStyle(fontSize: 12),)),
          ),
        ),
      ));  */

      res.add(GestureDetector(
        onTap: () {
          handleTap(index);
        },
        child: Container(
          key: ValueKey(text),
          margin: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(shape: BoxShape.circle, color: index < animationValue.round() ? Colors.purple : Colors.yellow),
          height: 30,
          width: 30,
          child: Center(child: Text((index + 1).toString(),style: TextStyle(fontSize: 12),)),
        ),
      ));
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildUnits(),
    );
  }
}

class MyIndicator extends StatelessWidget {
  MyIndicator({
    required this.animationValue,
    required width,
    required this.onDrag,
    required this.onDragStart,
    required this.onDragEnd,
    required this.circleDiameter,
  })  : width = width - circleDiameter,
        possition = animationValue == 0 ? 0 : animationValue / 20;

  final double animationValue;
  final Function(DragUpdateDetails) onDrag;
  final Function(DragEndDetails) onDragEnd;
  final Function(DragStartDetails) onDragStart;
  final double possition;
  final double width;
  final double circleDiameter;

  _buildIndicator() {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDrag,
      onHorizontalDragEnd: onDragEnd,
      child: const Image(image: AssetImage(ImageConstants.rating)),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("indicator width ::::::::::: ${width}");
    print("indicator position ::::::::::: ${possition * 10}");
    return Container(
      child: Positioned(
        top: 0,
        left: width * possition,
        child: _buildIndicator(),
      ),
    );
  }
}

class Head extends StatelessWidget {
  Head({
    this.color = const Color(0xFFc9ced2),
    this.hasShadow = false,
    required this.circleDiameter,
  });

  final Color color;
  final bool hasShadow;
  final double circleDiameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleDiameter,
      width: circleDiameter,
      decoration: BoxDecoration(
        boxShadow: hasShadow
            ? [
                const BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 5.0,
                )
              ]
            : null,
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
