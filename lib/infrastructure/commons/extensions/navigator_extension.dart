import 'package:flutter/cupertino.dart';

extension RouterContext on BuildContext {
  toPushNamed(String routeName, {Object? args}) => Navigator.of(this).pushNamed(routeName, arguments: args);

  toPushNamedAndRemoveUntil(String routeName, {Object? args}) =>
      Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false, arguments: args);

  toPushReplacementNamed(String routeName, {Object? args}) => Navigator.of(this).pushReplacementNamed(routeName, arguments: args);

  toPop() => Navigator.pop(this);
}
