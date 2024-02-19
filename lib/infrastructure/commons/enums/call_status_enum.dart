///2 : accept
/// 3 : decline
/// 4 : time out
/// 5 : cancel

enum CallStatusEnum {
  accept,
  decline,
  timeout,
  cancel,
}

extension CallStatusEnumExtension on CallStatusEnum {
  int get callStatusToNumber {
    switch (this) {
      case CallStatusEnum.accept:
        return 2;
      case CallStatusEnum.decline:
        return 3;
      case CallStatusEnum.timeout:
        return 4;
      case CallStatusEnum.cancel:
        return 5;
      default:
        return 0;
    }
  }
}
