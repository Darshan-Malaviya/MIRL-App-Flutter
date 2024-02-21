import 'package:flutter/cupertino.dart';

class SuggestNewExpertiseProvider extends ChangeNotifier{
  TextEditingController expertCategoryController = TextEditingController();
  TextEditingController newTopicController = TextEditingController();

  String _enteredText = '0';

  String get enteredText => _enteredText;

  void newTopicCounterValue(String value) {
    _enteredText = value.length.toString();
    notifyListeners();
  }
}