import 'package:flutter/cupertino.dart';

extension CustomMargin on Widget {
  addAllMargin(double margin) => Container(margin: EdgeInsets.all(margin), child: this);

  addMarginX(double marginX) => Container(margin: EdgeInsets.symmetric(horizontal: marginX), child: this);

  addMarginY(double marginY) => Container(margin: EdgeInsets.symmetric(vertical: marginY), child: this);

  addMarginXY({required double marginX, required double marginY}) =>
      Container(margin: EdgeInsets.symmetric(vertical: marginY, horizontal: marginX), child: this);

  addMarginTop(double margin) => Container(margin: EdgeInsets.only(top: margin), child: this);

  addMarginLeft(double margin) => Container(margin: EdgeInsets.only(left: margin), child: this);

  addMarginBottom(double margin) => Container(margin: EdgeInsets.only(bottom: margin), child: this);

  addMarginRight(double margin) => Container(margin: EdgeInsets.only(right: margin), child: this);
}
