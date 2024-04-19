import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
  import 'package:mirl/ui/screens/expert_profile_screen/expert_profile_screen.dart';
import 'package:mirl/ui/screens/explore_expert_screen/explore_expert_screen.dart';
import 'package:mirl/ui/screens/home_screen/home_screen.dart';
import 'package:mirl/ui/screens/notifications_screen/notification_screen.dart';
import 'package:mirl/ui/screens/user_setting_screen/user_seeting_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  final int index;

  const DashboardScreen({super.key, required this.index});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.onTokenRefresh.listen((String token) async {
      //FlutterToast().showToast(msg: 'Refresh Token: $token', gravity: ToastGravity.TOP);
      log('Refresh Token:===== $token');
      await ref.read(loginScreenProvider).appStartUpAPI(fcmToken: token);
    });
    pageController = PageController(initialPage: widget.index);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      instanceRequestTimerNotifier = ValueNotifier<int>(120);
      instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
      ref.read(dashboardProvider).pageChanged(widget.index);
      ref.read(socketProvider).listenerEvent();
      SocketApi.singleTone.init(onListenMethod: (value) {
        if (value) {
          ref.read(socketProvider).listenAllMethods(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProviderWatch = ref.watch(dashboardProvider);
    final dashboardProviderRead = ref.read(dashboardProvider);
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: buildPageView(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: ColorConstants.whiteColor, boxShadow: [
          BoxShadow(
            color: ColorConstants.blackColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
            spreadRadius: 1,
          )
        ]),
        child: BottomNavigationBar(
          currentIndex: dashboardProviderWatch.selectedIndex,
          onTap: (index) {
            dashboardProviderRead.pageChanged(index);
            pageController?.jumpToPage(index);
          },
          useLegacyColorScheme: false,
          backgroundColor: ColorConstants.transparentColor,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 7,
          unselectedFontSize: 7,
          selectedLabelStyle: TextStyle(color: ColorConstants.bottomTextColor, fontFamily: FontWeightEnum.w400.toInter),
          unselectedLabelStyle: TextStyle(color: ColorConstants.blackColor, fontFamily: FontWeightEnum.w400.toInter),
          selectedItemColor: ColorConstants.blackColor,
          items: List.generate(
            5,
            (index) => BottomNavigationBarItem(
              icon: Image.asset(
                color: dashboardProviderWatch.selectedIndex == index ? ColorConstants.bottomTextColor : null,
                dashboardProviderRead.getImage(index),
              ),
              label: dashboardProviderRead.getText(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        // pageChanged(index);
      },
      children: <Widget>[
        HomeScreen(),
        ExploreExpertScreen(isFromHomePage: true),
        NotificationScreen(),
        ExpertProfileScreen(),
        UserSettingScreen(),
      ],
    );
  }
}

// Widget bottomNavigationBar(int selectedIndex, Function(int) onTap) {
//   return Container(
//
//     margin: EdgeInsets.only(top: 30, bottom: 0),
//     decoration: BoxDecoration(
//       color: ColorConstants.whiteColor,
//       //borderRadius: const BorderRadius.all(Radius.circular(10)),
//       // boxShadow: [
//       //   BoxShadow(
//       //     color: ColorConstants.borderColor,
//       //     spreadRadius: 2 ,
//       //     blurRadius: 3,
//       //     offset: Offset(0, 2),
//       //   )
//       // ]
//     ),
//     child: Column(
//       children: [
//         BottomNavigationBar(
//           useLegacyColorScheme: false,
//           backgroundColor: ColorConstants.transparentColor,
//           showUnselectedLabels: true,
//           type: BottomNavigationBarType.fixed,
//           elevation: 0,
//           selectedFontSize: 7,
//           unselectedFontSize: 7,
//           selectedLabelStyle: TextStyle(color: ColorConstants.bottomTextColor, fontFamily: FontWeightEnum.w400.toInter),
//           unselectedLabelStyle: TextStyle(color: ColorConstants.blackColor, fontFamily: FontWeightEnum.w400.toInter),
//           currentIndex: selectedIndex,
//           onTap: onTap,
//           selectedItemColor: ColorConstants.blackColor,
//           items: [
//             BottomNavigationBarItem(icon: Image.asset(ImageConstants.home).addPaddingY(6), label: StringConstants.home,),
//             BottomNavigationBarItem(icon: Image.asset(ImageConstants.explore).addPaddingY(6), label: StringConstants.explore),
//             BottomNavigationBarItem(
//                 icon: Image.asset(ImageConstants.notification).addPaddingY(6), label: StringConstants.notification),
//             BottomNavigationBarItem(
//                 icon: Image.asset(ImageConstants.expertProfile).addPaddingY(3), label: StringConstants.expertProfile),
//             BottomNavigationBarItem(
//                 icon: Image.asset(ImageConstants.userSetting).addPaddingY(6), label: StringConstants.userSetting),
//           ],
//         ).addAllPadding(10),
//       ],
//     ),
//   );
// }
