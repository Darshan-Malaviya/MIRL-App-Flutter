enum CallTypeEnum {
  instanceCall,
  multiConnectCall,
  scheduledCall,
}

extension CallTypeEnumExtension on CallTypeEnum {
  int get callTypeEnumToNumber {
    switch (this) {
      case CallTypeEnum.instanceCall:
        return 1;
      case CallTypeEnum.multiConnectCall:
        return 2;
      case CallTypeEnum.scheduledCall:
        return 3;
      default:
        return 0;
    }
  }
}

extension CallTypeEnumExtensionFromString on String {
  CallTypeEnum get getCallTypeFromString {
    switch (this) {
      case '1':
        return CallTypeEnum.instanceCall;
      case '2':
        return CallTypeEnum.multiConnectCall;
      case '3':
        return CallTypeEnum.scheduledCall;
      default:
        return CallTypeEnum.instanceCall;
    }
  }
}
