import 'package:flutter/cupertino.dart';

extension CustomMargin on Widget {
  addAllMargin(double padding) => Container(margin: EdgeInsets.all(padding), child: this);

  addMarginX(double paddingX) => Container(margin: EdgeInsets.symmetric(horizontal: paddingX), child: this);

  addMarginY(double paddingY) => Container(margin: EdgeInsets.symmetric(vertical: paddingY), child: this);

  addMarginXY({required double paddingX, required double paddingY}) =>
      Container(margin: EdgeInsets.symmetric(vertical: paddingY, horizontal: paddingX), child: this);

  addMarginTop(double padding) => Container(margin: EdgeInsets.only(top: padding), child: this);

  addMarginLeft(double padding) => Container(margin: EdgeInsets.only(left: padding), child: this);

  addMarginBottom(double padding) => Container(margin: EdgeInsets.only(bottom: padding), child: this);

  addMarginRight(double padding) => Container(margin: EdgeInsets.only(right: padding), child: this);
}
