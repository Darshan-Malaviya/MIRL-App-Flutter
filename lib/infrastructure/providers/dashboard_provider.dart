import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_profile_screen/expert_profile_screen.dart';
import 'package:mirl/ui/screens/explore_screen%20/explore_screen.dart';
import 'package:mirl/ui/screens/home_screen/home_screen.dart';
import 'package:mirl/ui/screens/notifications_screen%20/notification_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/user_seeting_screen.dart';

class DashboardProvider extends ChangeNotifier {
  String _pageTitle = StringConstants.home;
  PageController pageController = PageController();

  String get pageTitle => _pageTitle;

  int get selectedIndex => _selectedIndex;
  int _selectedIndex = 0;

  Widget buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeScreen(),
        ExploreScreen(),
        NotificationScreen(),
        ExpertProfileScreen(),
        UserSettingScreen(),
        //BlockUserScreen(args: BlockUserArgs(reportName:  'vaidehi', userRole: 0))
      ],
    );
  }

  void pageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void bottomTapped(int index) {
    _selectedIndex = index;
    pageController.jumpToPage(index);
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
