///1 : waiting (requested)
///2 : accept
/// 3 : decline
/// 4 : time out ( No response)
/// 5 : cancel
/// 6 : choose
/// 7 : not choose

enum CallRequestStatusEnum {
  waiting,
  accept,
  decline,
  timeout,
  cancel,
  choose,
  notChoose,
}

extension CallRequestStatusEnumExtension on CallRequestStatusEnum {
  int get callRequestStatusToNumber {
    switch (this) {
      case CallRequestStatusEnum.waiting:
        return 1;
      case CallRequestStatusEnum.accept:
        return 2;
      case CallRequestStatusEnum.decline:
        return 3;
      case CallRequestStatusEnum.timeout:
        return 4;
      case CallRequestStatusEnum.cancel:
        return 5;
      case CallRequestStatusEnum.choose:
        return 6;
      case CallRequestStatusEnum.notChoose:
        return 7;
      default:
        return 0;
    }
  }

}
