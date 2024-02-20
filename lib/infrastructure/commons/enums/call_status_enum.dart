///2 : acceptCall
/// 3 : declineCall
/// 4 : time outCall
/// 5 : cancelCall
/// 6 : completedCall

enum CallStatusEnum { acceptCall, declineCall, timeoutCall, cancelCall, completedCall }

extension CallStatusEnumExtension on CallStatusEnum {
  int get callRequestStatusToNumber {
    switch (this) {
      case CallStatusEnum.acceptCall:
        return 2;
      case CallStatusEnum.declineCall:
        return 3;
      case CallStatusEnum.timeoutCall:
        return 4;
      case CallStatusEnum.cancelCall:
        return 5;
      case CallStatusEnum.completedCall:
        return 6;
      default:
        return 0;
    }
  }
}
