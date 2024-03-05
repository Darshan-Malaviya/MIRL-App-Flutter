enum CallTimerEnum { call, request ,multiCall, multiRequest}

extension CallTimerEnumExtension on CallTimerEnum {
  String get callTimerToString {
    switch (this) {
      case CallTimerEnum.call:
        return 'call';
      case CallTimerEnum.request:
        return 'request';
      case CallTimerEnum.multiCall:
        return 'multiCall';
        case CallTimerEnum.multiRequest:
        return 'multiRequest';
      default:
        return '';
    }
  }
}
