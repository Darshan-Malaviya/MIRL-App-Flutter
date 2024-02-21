import 'dart:async';
import 'package:mirl/infrastructure/commons/constants/api_constants.dart';
import 'package:mirl/infrastructure/commons/enums/enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response.dart';
import 'package:mirl/infrastructure/data_access_layer/api/api_response_provider.dart';
import 'package:mirl/infrastructure/handler/api_response_handler/api_response_handler.dart';
import 'package:mirl/infrastructure/models/response/cms_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/models/response/un_block_user_response_model.dart';
import 'package:mirl/infrastructure/models/response/user_block_response_model.dart';

class AuthRepository extends ApiResponseHandler {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  /// login
  Future<ApiHttpResult> loginCallApi({required Object requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.login);

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithOutToken(), body: requestModel);

    return responseHandler(result: result, json: LoginResponseModel.parseInfo);
  }

  /// otp verify

  Future<ApiHttpResult> otpVerifyCallApi({required Object requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.otpVerify);

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithOutToken(), body: requestModel);

    return responseHandler(result: result, json: LoginResponseModel.parseInfo);
  }

  /// user block

  Future<ApiHttpResult> userBlockApi({required Object requestModel}) async {
    final uri = ApiConstants.endpointUri(path: ApiConstants.userBlock);

    APIResponse result = await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), body: requestModel);

    return responseHandler(result: result, json: UserBlockResponseModel.parseInfo);
  }

  ///  un block user

  Future<ApiHttpResult> unBlockUserApi({required int userBlockId}) async {
    final uri = ApiConstants.endpointUri(path: '${ApiConstants.unBlockUser}/$userBlockId');

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), apiType: APIType.put);

    return responseHandler(result: result, json: UnBlockUserResponseModel.parseInfo);
  }

  ///   get all block list

  Future<ApiHttpResult> getAllBlockListApi({required int page, required int limit}) async {
    final uri = ApiConstants.endpointUri(
        path: ApiConstants.userBlockList, queryParameters: {"page": page.toString(), "limit": limit.toString()});

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithToken(), apiType: APIType.get);

    return responseHandler(result: result, json: UserBlockResponseModel.parseInfo);
  }

  /// cms API

  Future<ApiHttpResult> cmsApi({required String cmsKey}) async {
    final uri = ApiConstants.endpointUri(path: '${ApiConstants.cms}/$cmsKey');

    APIResponse result =
        await _apiResponseProvider.requestAPI(uri, headers: ApiConstants.headerWithOutToken(), apiType: APIType.get);

    return responseHandler(result: result, json: CMSResponseModel.parseInfo);
  }
}
