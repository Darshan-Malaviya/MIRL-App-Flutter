import 'package:flutter/cupertino.dart';

extension CustomVisibility on Widget {
  addVisibility(bool isVisible) => Visibility(visible: isVisible, child: this);
}
