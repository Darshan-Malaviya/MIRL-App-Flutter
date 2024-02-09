import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context, int a) {
  switch (a) {
    case 1:
      return MediaQuery.of(context).size.width * 0.14;
    case 2:
      return MediaQuery.of(context).size.width * 0.3;
    case 3:
      return MediaQuery.of(context).size.width * 0.46;
    case 4:
      return MediaQuery.of(context).size.width * 0.62;
    case 5:
      return MediaQuery.of(context).size.width * 0.8;
/*    case 6:
      return MediaQuery.of(context).size.width * 0.14;
    case 7:
      return MediaQuery.of(context).size.width * 0.3;
    case 8:
      return MediaQuery.of(context).size.width * 0.46;
    case 9:
      return MediaQuery.of(context).size.width * 0.62;
    case 10:
      return MediaQuery.of(context).size.width * 0.8;*/
  }
  return 70.0;
}

String getMessage(int a) {
  switch (a) {
    case 1:
      return "Worst";
    case 2:
      return "Not Good";
    case 3:
      return "Good";
    case 4:
      return "Excellent";
    case 5:
      return "Out Standing";
  }
  return "Excellent";
}
