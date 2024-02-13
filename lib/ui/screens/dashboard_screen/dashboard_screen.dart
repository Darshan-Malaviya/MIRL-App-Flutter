import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/providers/provider_registration.dart';
import 'package:mirl/infrastructure/services/socket_service.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
      body: dashboardProviderRead.buildPageView(),
      bottomNavigationBar: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.whiteColor,
          ),
          child: BottomNavigationBar(
            currentIndex: dashboardProviderWatch.selectedIndex,
            onTap: (index) {
              dashboardProviderRead.bottomTapped(index);
            },
            useLegacyColorScheme: false,
            backgroundColor: ColorConstants.transparentColor,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedFontSize: 7,
            unselectedFontSize: 7,
            selectedLabelStyle:
                TextStyle(color: ColorConstants.bottomTextColor, fontFamily: FontWeightEnum.w400.toInter),
            unselectedLabelStyle: TextStyle(color: ColorConstants.blackColor, fontFamily: FontWeightEnum.w400.toInter),
            selectedItemColor: ColorConstants.blackColor,
            items: List.generate(
              5,
              (index) => BottomNavigationBarItem(
                icon: dashboardProviderWatch.selectedIndex == index
                    ? Image.asset(
                        color: ColorConstants.bottomTextColor,
                        dashboardProviderRead.getImage(index),
                      )
                    : Image.asset(
                        dashboardProviderRead.getImage(index),
                      ),
                label: dashboardProviderRead.getText(index),
              ),
            ),
          ),
        ),
      ),
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
