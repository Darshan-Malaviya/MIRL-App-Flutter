import 'package:flutter/cupertino.dart';

extension CustomPadding on Widget {
  addAllPadding(double padding) => Padding(padding: EdgeInsets.all(padding), child: this);

  addPaddingX(double paddingX) => Padding(padding: EdgeInsets.symmetric(horizontal: paddingX), child: this);

  addPaddingY(double paddingY) => Padding(padding: EdgeInsets.symmetric(vertical: paddingY), child: this);

  addPaddingXY({required double paddingX, required double paddingY}) =>
      Padding(padding: EdgeInsets.symmetric(vertical: paddingY, horizontal: paddingX), child: this);

  addPaddingTop(double padding) => Padding(padding: EdgeInsets.only(top: padding), child: this);

  addPaddingLeft(double padding) => Padding(padding: EdgeInsets.only(left: padding), child: this);

  addPaddingBottom(double padding) => Padding(padding: EdgeInsets.only(bottom: padding), child: this);

  addPaddingRight(double padding) => Padding(padding: EdgeInsets.only(right: padding), child: this);
}


