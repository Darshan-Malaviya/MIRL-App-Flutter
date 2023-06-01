import 'package:flutter_boilerplate_may_2023/infrastructure/data_access_layer/api/api_response_provider.dart';

class AuthRepository {
  // final ApiResponseProvider _apiResponseProvider =
  // ApiResponseProvider(header: ApiConstants.headerWithAuthToken(SharedPrefHelper.getAuthToken));

  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  /// login
  // Future<ApiHttpResult> login(String requestModel) async {
  //   final uri = ApiConstants.endpointUri(path: ApiConstants.login);
  //
  //   APIResponse result = await _apiResponseProvider.post(uri, headers: ApiConstants.headerWithoutAccessToken(), body: requestModel);
  //
  //   switch (result.status) {
  //     case APIStatus.SUCCESS:
  //       var apiResponse = await compute(LoginResponseModel.parseInfo, result.response);
  //       return ApiHttpResult.success(apiResponse);
  //     case APIStatus.ERROR:
  //       return ApiHttpResult.error(result.error);
  //     default:
  //       ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
  //       return ApiHttpResult.error(applicationError);
  //   }
  // }

  /// logOut
  // Future<ApiHttpResult> logOut(String? id) async {
  //   final uri = ApiConstants.endpointUri(path: '${ApiConstants.logOut}/$id');
  //
  //   APIResponse result = await _apiResponseProvider.post(uri, put: true);
  //
  //   switch (result.status) {
  //     case APIStatus.SUCCESS:
  //       var apiResponse = await compute(BaseModel.parseInfo, result.response);
  //       return ApiHttpResult.success(apiResponse);
  //     case APIStatus.ERROR:
  //       return ApiHttpResult.error(result.error);
  //     default:
  //       ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
  //       return ApiHttpResult.error(applicationError);
  //   }
  // }

  /// change password
  // Future<ApiHttpResult> changePassword(String requestModel) async {
  //   String userId = SharedPrefHelper.getUserId;
  //   final uri = ApiConstants.endpointUri(path: '${ApiConstants.changePassword}/$userId');
  //
  //   APIResponse result = await _apiResponseProvider.post(uri, body: requestModel);
  //
  //   switch (result.status) {
  //     case APIStatus.SUCCESS:
  //       var apiResponse = await compute(ChangePasswordResponseModel.parseInfo, result.response);
  //       return ApiHttpResult.success(apiResponse);
  //     case APIStatus.ERROR:
  //       return ApiHttpResult.error(result.error);
  //     default:
  //       ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
  //       return ApiHttpResult.error(applicationError);
  //   }
  // }

  /// forgot password
  // Future<ApiHttpResult> forgotPassword(String requestModel) async {
  //   final uri = ApiConstants.endpointUri(path: ApiConstants.forgotPassword);
  //
  //   APIResponse result = await _apiResponseProvider.post(uri, headers: ApiConstants.headerWithoutAccessToken(), body: requestModel);
  //
  //   switch (result.status) {
  //     case APIStatus.SUCCESS:
  //       var forgotPassResponse = await compute(BaseModel.parseInfo, result.response);
  //       return ApiHttpResult.success(forgotPassResponse);
  //     case APIStatus.ERROR:
  //       return ApiHttpResult.error(result.error);
  //     default:
  //       ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
  //       return ApiHttpResult.error(applicationError);
  //   }
  // }

  ///get all brands
  // Future<ApiHttpResult> getAllBrand() async {
  //   final uri = ApiConstants.endpointUri(path: ApiConstants.brands, queryParameters: {
  //     'page': "1",
  //     'search': "",
  //     'limit': "50",
  //   });
  //
  //   APIResponse result = await _apiResponseProvider.post(uri, get: true);
  //
  //   switch (result.status) {
  //     case APIStatus.SUCCESS:
  //       var getAllBrands = await compute(GetAllBrandsResponseModel.parseInfo, result.response);
  //       return ApiHttpResult.success(getAllBrands);
  //     case APIStatus.ERROR:
  //       return ApiHttpResult.error(result.error);
  //     default:
  //       ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
  //       return ApiHttpResult.error(applicationError);
  //   }
  // }
}
