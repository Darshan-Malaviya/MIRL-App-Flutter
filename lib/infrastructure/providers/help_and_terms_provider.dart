
import 'package:flutter/cupertino.dart';

class HelpAndTermsProvider extends ChangeNotifier{

  String enteredText = '0';
  TextEditingController expertSetupController = TextEditingController();

  void changeCounterValue(String value) {
    enteredText = value.length.toString();
    print("Enter ext ${enteredText}");
    notifyListeners();
  }

}