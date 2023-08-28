import 'package:api_handler/common/exports.dart';

class ApplicationError {
  List<ApiError> errors;
  String? errorType;

  ApplicationError({this.errorType, this.errors = const []});

  ApiError apiError() {
    return (errors.isEmpty)
        ? ApplicationError(errorType: ErrorType.genericError.messageString, errors: [ApiError(code: 0, message: '')]).errors.first
        : errors.first;
  }

  String get firstBodyText => errors.isNotEmpty ? errors.first.body : '';

  String get firstShortBodyText => errors.isNotEmpty ? errors.first.bodyShort : '';

  String get firstTitleText => errors.isNotEmpty ? errors.first.title : '';

  String get firstFieldText => errors.isNotEmpty ? errors.first.field : '';
}

//TODO: Use Error Response temporarily and will be replaced by HTTPError when all api network layer are change.
abstract class ErrorResponse {
  static ApplicationError getAppError(int statusCode) {
    ErrorHandlerModel errorData;
    errorData = switch (statusCode) {
      403 => ErrorHandlerModel(
          errorType: ErrorType.networkForbiddenError.messageString,
          code: NetworkErrorType.netUnreachable,
          message: "Please check your internet connection."),
      401 => ErrorHandlerModel(
          errorType: ErrorType.unAuthorize.messageString,
          code: NetworkErrorType.unAuthorized,
          message: "Your account is logged in with another device.",
        ),
      >= 400 && <= 499 => ErrorHandlerModel(
          errorType: ErrorType.userError.messageString,
          code: NetworkErrorType.netUnreachable,
          message: "Please check your internet connection.",
        ),
      >= 500 && <= 599 => ErrorHandlerModel(
          errorType: ErrorType.serverError.messageString,
          code: NetworkErrorType.hostUnreachable,
          message: "Service temporarily unavailable. Please check back soon.",
        ),
      -1 => ErrorHandlerModel(
          errorType: ErrorType.noResponse.messageString,
          code: NetworkErrorType.netUnreachable,
          message: "Please check your internet connection.",
        ),
      _ => ErrorHandlerModel(
          errorType: ErrorType.appError.messageString,
          code: statusCode,
        )
    };

    return ApplicationError(
        errorType: errorData.errorType, errors: [ApiError(code: errorData.code, message: errorData.message, key: '${errorData.code}')]);
  }
}

abstract class NetworkError {
  static ApplicationError getAppError(int statusCode) {
    ErrorHandlerModel errorData;

    errorData = switch (statusCode) {
      NetworkErrorType.netUnreachable => ErrorHandlerModel(
          errorType: ErrorType.networkError.messageString,
          code: statusCode,
          message: "Please check your internet connection.",
        ),
      NetworkErrorType.outOfMem => ErrorHandlerModel(
          errorType: ErrorType.networkError.messageString,
          code: statusCode,
          message: 'Service temporarily unavailable. Please check back soon.',
        ),
      _ => ErrorHandlerModel(
          errorType: '',
          code: 0,
          message: '',
        ),
    };

    return ApplicationError(
        errorType: errorData.errorType, errors: [ApiError(code: errorData.code, message: errorData.message, key: '${errorData.code}')]);
  }
}

abstract class UserError {
  static ApplicationError getAppError(Reason reason) {
    ErrorHandlerModel errorData;
    errorData = switch (reason) {
      Reason.unknown => ErrorHandlerModel(
          code: 0,
          message: "Oops! Something went wrong.\nPlease try again.",
        ),
      Reason.invalidCreditCard => ErrorHandlerModel(
          code: UserErrorType.invalidCreditCard,
          message: 'Incorrect credit card info.\nPlease check and try again.',
        ),
      Reason.invalidPaypal => ErrorHandlerModel(
          code: 0,
          message: 'Sorry we cannot place your paypal order for now. Please try again later',
        ),
      Reason.emptyKeywordSearch => ErrorHandlerModel(
          code: 0,
          message: 'Sorry! There are no products matching your search.',
        ),
      Reason.invalidData => ErrorHandlerModel(
          code: UserErrorType.invalidData,
          message: 'Invalid data.',
        ),
      Reason.productSignedUpNotified => ErrorHandlerModel(
          code: UserErrorType.productSignedUpNotified,
          message: 'You\'re already signed up to be notified as soon as this item is back in stock.',
        ),
      Reason.addProductToCartFailed => ErrorHandlerModel(
          code: UserErrorType.addProductToCartFailed,
          message: 'Sorry, we are unable to add the item into your cart.',
        ),
      Reason.emptyCmsPage => ErrorHandlerModel(
          code: UserErrorType.emptyCmsPage,
          message: 'Please try again.',
        ),
      Reason.applicationSchemaError => ErrorHandlerModel(
          code: UserErrorType.applicationSchemaError,
          message: 'Oops! Something went wrong.',
        ),
      Reason.applicationSchemaError => ErrorHandlerModel(
          code: UserErrorType.captchaChallenge,
          message: 'Our systems have detected unusual traffic from your network. Please try again later.',
        ),
      Reason.noLoginCredentials => ErrorHandlerModel(
          code: UserErrorType.captchaChallenge,
          message: 'Our systems have detected unusual traffic from your network. Please try again later.',
        ),
      _ => ErrorHandlerModel(
          code: 0,
          message: 'User has no sign-in credentials',
        ),
    };
    return ApplicationError(
        errorType: ErrorType.userError.messageString,
        errors: [ApiError(code: errorData.code, message: errorData.message, key: '${errorData.code}')]);
  }
}

class ErrorHandlerModel {
  String? errorType;
  String? message;
  int? code;

  ErrorHandlerModel({this.errorType, this.message, this.code});
}
