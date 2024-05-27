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
  ScrollController homeScrollController = ScrollController();
  ScrollController exploreScrollController = ScrollController();
  ScrollController notificationScrollController = ScrollController();
  ScrollController expertScrollController = ScrollController();
  ScrollController userScrollController = ScrollController();

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

  void controller(int index){
    if (index == 1) {
      exploreScrollController.animateTo(0.0, duration: Duration(seconds: 3), curve: Curves.ease);
      // ref.watch(filterProvider).scrollController.animateTo(0.0, duration: Duration(seconds: 3), curve: Curves.ease);
    }  else if(index == 2){
      notificationScrollController.animateTo(0.0, duration: Duration(seconds: 3), curve: Curves.ease);
    }else if(index == 3){
      expertScrollController.animateTo(0.0, duration: Duration(seconds: 3), curve: Curves.ease);
    }else if(index == 4){
      userScrollController.animateTo(0.0, duration: Duration(seconds: 3), curve: Curves.ease);
    }else{
      homeScrollController.animateTo(0.0, duration: Duration(seconds: 3), curve: Curves.ease);
    }
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
            print("index=========$index");
            dashboardProviderRead.pageChanged(index);
            pageController?.jumpToPage(index);
            //controller(index);
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
                height: 25,width: 25,
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
  // @override
  // void dispose() {
  //   homeScrollController.dispose(); // Dispose the ScrollController when it's no longer needed
  //   exploreScrollController.dispose(); // Dispose the ScrollController when it's no longer needed
  //   notificationScrollController.dispose(); // Dispose the ScrollController when it's no longer needed
  //   expertScrollController.dispose(); // Dispose the ScrollController when it's no longer needed
  //   userScrollController.dispose(); // Dispose the ScrollController when it's no longer needed
  //   super.dispose();
  // }
  Widget buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        // pageChanged(index);
      },
      children: <Widget>[
        HomeScreen(context: context,/*scrollController:homeScrollController*/),
        ExploreExpertScreen(/*scrollController: exploreScrollController*/isFromHomePage: true),
        NotificationScreen(),
        ExpertProfileScreen(/*scrollController:expertScrollController*/),
        UserSettingScreen(/*scrollController:userScrollController*/),
      ],
    );
  }
}

/// tab bar use

// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
// import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
// import 'package:mirl/infrastructure/providers/dashboard_provider.dart';
// import 'package:mirl/ui/common/common_bottom_bar_widget/common_bottom_bar.dart';
// import 'package:mirl/ui/common/common_bottom_bar_widget/tab_item.dart';
// import 'package:mirl/ui/screens/expert_profile_screen/expert_profile_screen.dart';
// import 'package:mirl/ui/screens/explore_expert_screen/explore_expert_screen.dart';
// import 'package:mirl/ui/screens/home_screen/home_screen.dart';
// import 'package:mirl/ui/screens/notifications_screen/notification_screen.dart';
// import 'package:mirl/ui/screens/user_setting_screen/user_seeting_screen.dart';
//
// class DashboardScreen extends ConsumerStatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends ConsumerState<DashboardScreen> with SingleTickerProviderStateMixin {
//   TabController? tabController;
//
//   late DashboardProvider dashboardScreenProviderRef;
//
//     ScrollController homeScrollController = ScrollController();
//   ScrollController exploreScrollController = ScrollController();
//   ScrollController notificationScrollController = ScrollController();
//   ScrollController expertScrollController = ScrollController();
//   ScrollController userScrollController = ScrollController();
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
//   //   ref.read(myAccountScreenProvider).getProfileDetail();
//   //   if (SharedPrefHelper.getAuthToken.isNotEmpty) {
//   //     if (ref.read(myAccountScreenProvider).aboutUsData == null) ref.read(myAccountScreenProvider).getCMSApi();
//   //     if (ref.read(flightScreenProvider).popularCitiesResponse == null) {
//   //       ref.read(flightScreenProvider).getPopularCallApi();
//   //     }
//   //     if (ref.read(hotelsScreenProvider).popularCitiesResponse == null) {
//   //       ref.read(hotelsScreenProvider).getPopularHotelsCallApi();
//   //     }
//   //   }
//   //   // ref.read(dashboardScreenProvider).changeSelectedIndex(0);
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     // ref.read(dashboardScreenProvider).onRefresh();
//   //   });
//   // }
//
//     @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.instance.onTokenRefresh.listen((String token) async {
//       //FlutterToast().showToast(msg: 'Refresh Token: $token', gravity: ToastGravity.TOP);
//       log('Refresh Token:===== $token');
//       await ref.read(loginScreenProvider).appStartUpAPI(fcmToken: token);
//     });
//     tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       instanceRequestTimerNotifier = ValueNotifier<int>(120);
//       instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
//      // ref.read(dashboardProvider).pageChanged(widget.index);
//       ref.read(socketProvider).listenerEvent();
//       SocketApi.singleTone.init(onListenMethod: (value) {
//         if (value) {
//           ref.read(socketProvider).listenAllMethods(context);
//         }
//       });
//     });
//   }
//
//   Future<bool> _onWillPop() async {
//     return false;
//   }
//
//   List<TabItem> tabs = [
//     TabItem(
//       key: GlobalKey<NavigatorState>(),
//       page: HomeScreen(/*context: context,scrollController: homeScrollController*/),
//     ),
//     TabItem(
//       key: GlobalKey<NavigatorState>(),
//       page: ExploreExpertScreen(/*scrollController:exploreScrollController*/isFromHomePage: true, ),
//     ),
//     TabItem(
//       key: GlobalKey<NavigatorState>(),
//       page: const NotificationScreen(),
//     ),
//     TabItem(
//       key: GlobalKey<NavigatorState>(),
//       page: ExpertProfileScreen(/*scrollController:expertScrollController*/),
//     ),
//     TabItem(
//       key: GlobalKey<NavigatorState>(),
//       page: UserSettingScreen(/*scrollController: userScrollController*/),
//     ),
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     dashboardScreenProviderRef = ref.watch(dashboardProvider);
//     // return  Scaffold(
//     //   body: Center(child: LineChartSample9()),
//     // );
//     //
//     return SafeArea(
//       bottom: true,
//       left: false,
//       top: false,
//       right: false,
//       child: WillPopScope(
//         onWillPop: _onWillPop,
//         child: Scaffold(
//           backgroundColor: ColorConstants.scaffoldColor,
//           body: IndexedStack(
//             index: dashboardScreenProviderRef.selectedIndex,
//             children: tabs.map((e) => e.page).toList(),
//           ),
//           bottomNavigationBar: BottomNavigationBarWidget(
//             dashboardScreenProviderRef: dashboardScreenProviderRef,
//             tabController: tabController,
//           ),
//         ),
//       ),
//     );
//   }
// }






/// bottomNavigationBar
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
