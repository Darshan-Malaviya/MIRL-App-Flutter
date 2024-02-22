///2 : accept
/// 3 : decline
/// 4 : time out
/// 5 : cancel

enum CallRequestStatusEnum {
  accept,
  decline,
  timeout,
  cancel,
}

extension CallRequestStatusEnumExtension on CallRequestStatusEnum {
  int get callRequestStatusToNumber {
    switch (this) {
      case CallRequestStatusEnum.accept:
        return 2;
      case CallRequestStatusEnum.decline:
        return 3;
      case CallRequestStatusEnum.timeout:
        return 4;
      case CallRequestStatusEnum.cancel:
        return 5;
      default:
        return 0;
    }
  }
}
