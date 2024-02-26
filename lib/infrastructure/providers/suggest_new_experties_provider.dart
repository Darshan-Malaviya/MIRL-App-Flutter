import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/suggested_category_request_model.dart';
import 'package:mirl/infrastructure/models/response/un_block_user_response_model.dart';
import 'package:mirl/infrastructure/repository/common_repo.dart';

class SuggestNewExpertiseProvider extends ChangeNotifier {
  TextEditingController expertCategoryController = TextEditingController();
  TextEditingController newTopicController = TextEditingController();
  TextEditingController existingCategoryController = TextEditingController();
  final _commonRepository = CommonRepository();

  String _enteredText = '0';

  String get enteredText => _enteredText;

  void newTopicCounterValue(String value) {
    _enteredText = value.length.toString();
    notifyListeners();
  }

  Future<void> suggestedCategoryApiCall() async {
    SuggestedCategoryRequestModel model = SuggestedCategoryRequestModel(
        categoryName: newTopicController.text,
        userId: SharedPrefHelper.getUserId,
        categoryId: existingCategoryController.text.trim(),
        topicName: newTopicController.text.trim());

    ApiHttpResult response = await _commonRepository.suggestedCategoryAPI(requestModel: model.toNullFreeJson());
    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is UnBlockUserResponseModel) {
          UnBlockUserResponseModel categoryResponseModel = response.data;
          Logger().d("Successfully call suggested category api");
          FlutterToast().showToast(msg: categoryResponseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on suggested category Api ${response.data}");
        break;
    }
    notifyListeners();
  }
}
