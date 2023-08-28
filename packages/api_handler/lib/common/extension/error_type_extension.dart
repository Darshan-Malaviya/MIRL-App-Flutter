


import 'package:api_handler/common/exports.dart';

extension ErrorTypeExtension on ErrorType {
  String get messageString {
    return switch (this) {
      ErrorType.networkError => 'Network Error',
      ErrorType.serverError => 'Server Error',
      ErrorType.appError => 'Application Error',
      ErrorType.serializationError => 'Serialization Error',
      ErrorType.genericError => 'Generic Error',
      ErrorType.networkForbiddenError => 'Network Forbidden Error',
      ErrorType.networkUnAuthorizedError => 'Network UnAuthorized Error',
      ErrorType.decodingError => 'Decoding Error',
      ErrorType.encodingError => 'Encoding Error',
      ErrorType.noResponse => 'No Response',
      ErrorType.dataError => 'Data Error',
      ErrorType.databaseError => 'Database Error',
      ErrorType.userError => 'User Error',
      ErrorType.unAuthorize => 'Your account is logged in with another device.',
    };
  }
}


