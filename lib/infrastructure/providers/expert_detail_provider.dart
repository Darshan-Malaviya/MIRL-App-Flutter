import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/models/request/favroite_request_model.dart';
import 'package:mirl/infrastructure/models/response/expert_detail_response_model.dart';
import 'package:mirl/infrastructure/models/response/favorite_response.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/repository/expert_profile_repo.dart';
import 'package:mirl/ui/common/alert_widgets/loader_widget.dart';
import 'package:mirl/ui/common/alert_widgets/toast_message.dart';

class ExpertDetailProvider extends ChangeNotifier {
  final _expertProfileRepo = ExpertProfileRepo();

  UserData? _userData;

  UserData? get userData => _userData;

  AreasOfExpertise? _areasOfExpertise;

  AreasOfExpertise? get areasOfExpertise => _areasOfExpertise;

  String? userGender() {
    if (_userData?.gender == 1) {
      return 'Male';
    } else if (userData?.gender == 2) {
      return 'Female';
    } else if (userData?.gender == 3) {
      return 'Non-Binary';
    }
    return null;
  }

  Future<void> getExpertDetailApiCall({required String userId}) async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _expertProfileRepo.expertDetailApi(userId: userId);

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is ExpertDetailResponseModel) {
          ExpertDetailResponseModel expertDetailResponseModel = response.data;
          _userData = expertDetailResponseModel.data;
          notifyListeners();
          Logger().d("Successfully expert detail");
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on expert detail call Api ${response.data}");
        break;
    }
  }

  Future<void> favoriteRequestCall(int expertId) async {
    FavoriteRequestModel favoriteRequestModel = FavoriteRequestModel(userFavoriteId: expertId);
    await favoriteApiCall(requestModel: favoriteRequestModel.prepareRequest());
  }

  Future<void> favoriteApiCall({required Object requestModel}) async {
    CustomLoading.progressDialog(isLoading: true);

    ApiHttpResult response = await _expertProfileRepo.favoriteApi(requestModel: requestModel);

    CustomLoading.progressDialog(isLoading: false);

    switch (response.status) {
      case APIStatus.success:
        if (response.data != null && response.data is FavoriteResponseModel) {
          FavoriteResponseModel favoriteResponseModel = response.data;
          _userData?.isFavorite = !(_userData?.isFavorite ?? false);
          notifyListeners();
          FlutterToast().showToast(msg: favoriteResponseModel.message ?? '');
        }
        break;
      case APIStatus.failure:
        FlutterToast().showToast(msg: response.failure?.message ?? '');
        Logger().d("API fail on User favorite call Api ${response.data}");
        break;
    }
  }
}
