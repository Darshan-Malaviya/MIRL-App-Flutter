import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class DashboardProvider extends ChangeNotifier {
  // ChangeNotifierProviderRef<DashboardProvider> ref;
  // DashboardProvider(this.ref);
  int get selectedIndex => _selectedIndex;
  int _selectedIndex = 0;

  void pageChanged(int index) {
    _selectedIndex = index;
    // if(_selectedIndex == 3){
    //   ref.read(expertDetailProvider).getExpertDetailApiCall(userId: SharedPrefHelper.getUserId);
    // }
    notifyListeners();
  }

  String getText(int index) {
    if (index == 1) {
      return StringConstants.explore;
    } else if (index == 2) {
      return StringConstants.notification;
    } else if (index == 3) {
      return StringConstants.expertProfile;
    } else if (index == 4) {
      return StringConstants.userSetting;
    } else {
      return StringConstants.home;
    }
  }

  String getImage(int index) {
    if (index == 1) {
      return ImageConstants.explore;
    } else if (index == 2) {
      return ImageConstants.notification;
    } else if (index == 3) {
      return ImageConstants.expertProfile;
    } else if (index == 4) {
      return ImageConstants.userSetting;
    } else {
      return ImageConstants.home;
    }
  }
}
