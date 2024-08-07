
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/providers/edit_expert_provider.dart';

import '../models/request/update_expert_Profile_request_model.dart';
import 'provider_registration.dart';

class HelpAndTermsProvider extends ChangeNotifier{
  late EditExpertProvider editExpertProvider;

  HelpAndTermsProvider(this.editExpertProvider);

  String enteredText = '0';
  TextEditingController expertSetupController = TextEditingController();

  void changeCounterValue(String value) {
    enteredText = value.length.toString();
    print("Enter ext ${enteredText}");
    notifyListeners();
  }


  void deleteUserApi(){
    UpdateExpertProfileRequestModel updateExpertProfileRequestModel = UpdateExpertProfileRequestModel(isDeleted: true);
    editExpertProvider.UpdateUserDetailsApiCall(requestModel:updateExpertProfileRequestModel.toIsDeleted(), isDeleted: true);
  }

}