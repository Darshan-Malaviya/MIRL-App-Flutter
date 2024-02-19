///1 : user
/// 2 : expert

enum CallRoleEnum { user, expert }

extension CallRoleEnumExtension on CallRoleEnum {
  int get roleToNumber {
    switch (this) {
      case CallRoleEnum.user:
        return 1;
      case CallRoleEnum.expert:
        return 2;
      default:
        return 0;
    }
  }
}
