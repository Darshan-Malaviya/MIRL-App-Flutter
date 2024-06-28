import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/providers/dashboard_provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    Key? key,
    required this.dashboardScreenProviderRef,
    this.tabController,
  }) : super(key: key);
  final TabController? tabController;
  final DashboardProvider dashboardScreenProviderRef;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConstants.whiteColor, boxShadow: [
        BoxShadow(
          color: ColorConstants.blackColor.withOpacity(0.1),
          blurRadius: 10,
          offset: Offset(0, -5),
          spreadRadius: 1,
        )
      ]),
      child: TabBar(
        controller: tabController,
        labelPadding: EdgeInsets.zero,
        onTap: dashboardScreenProviderRef.changeSelectedIndex,
        dividerColor: ColorConstants.blackColor,
        indicatorColor: ColorConstants.transparentColor,
        indicatorPadding: EdgeInsets.zero,labelColor:ColorConstants.bottomTextColor ,
        labelStyle: TextStyle(fontSize: 8),
        unselectedLabelColor: ColorConstants.blackColor,
        unselectedLabelStyle: TextStyle(color: ColorConstants.blackColor, fontFamily: FontWeightEnum.w400.toInter,fontSize: 8),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: List.generate(
          5,
          (index) => Tab(
            icon: Image.asset(
              height: 25,width: 25,
              color: dashboardScreenProviderRef.selectedIndex == index ? ColorConstants.bottomTextColor : null,
              dashboardScreenProviderRef.getImage(index),
            ),
            text: dashboardScreenProviderRef.getText(index),
          ),
        ),
      ),
    );
  }

  Color? color(index) {
    return dashboardScreenProviderRef.selectedIndex != index ? ColorConstants.blackColor : ColorConstants.bottomTextColor;
  }

  FontWeight? fontWeight(index) {
    return dashboardScreenProviderRef.selectedIndex != index ? FontWeight.w400 : FontWeight.w400;
  }
}
