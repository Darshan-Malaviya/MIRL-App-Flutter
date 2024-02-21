enum CallTimerEnum { call, request }

extension CallTimerEnumExtension on CallTimerEnum {
  String get callTimerToString {
    switch (this) {
      case CallTimerEnum.call:
        return 'call';
      case CallTimerEnum.request:
        return 'request';
      default:
        return '';
    }
  }
}
