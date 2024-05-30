import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/user_setting_screen/widget/activate_your_mirl_connect_code_widget.dart';
import 'package:mirl/ui/screens/user_setting_screen/widget/get_your_own_mirl_connect_code_widget.dart';
import 'package:mirl/ui/screens/user_setting_screen/widget/your_mirl_connect_code_widget.dart';

class MirlConnectScreen extends ConsumerStatefulWidget {
  const MirlConnectScreen({super.key});

  @override
  ConsumerState<MirlConnectScreen> createState() => _MirlConnectScreenState();
}

class _MirlConnectScreenState extends ConsumerState<MirlConnectScreen> {
  @override
  void initState() {
    super.initState();
    mirlConnectView.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final userSettingWatch = ref.watch(userSettingProvider);
    final userSettingRead = ref.read(userSettingProvider);
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBarWidget(
        preferSize: 0,
        appBarColor: ColorConstants.greyLightColor,
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon, color: ColorConstants.whiteColor),
              onTap: () => context.toPop(),
            ),
            backgroundColor: ColorConstants.transparentColor,
            pinned: true,
            centerTitle: true,
            expandedHeight: 360.0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: ColorConstants.whiteColor,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HeadlineMediumText(
                        title: LocaleKeys.connect.tr(),
                        fontSize: 30,
                        titleColor: ColorConstants.bottomTextColor,
                        shadow: [
                          Shadow(
                              offset: Offset(0, 1), blurRadius: 4, color: ColorConstants.mirlConnectShadowColor.withOpacity(0.50))
                        ],
                      ),
                      10.0.spaceY,
                      TitleSmallText(
                        title: LocaleKeys.unlimitedInvites.tr(),
                        titleColor: ColorConstants.blackColor,
                        fontFamily: FontWeightEnum.w600.toInter,
                      ),
                    ],
                  ),
                ).addAllPadding(10),
              ),
            ),
            flexibleSpace: NetworkImageWidget(
              imageURL: userSettingWatch.pickedImage,
              isNetworkImage: userSettingWatch.pickedImage.isNotEmpty,
              emptyImageWidget: Image.asset(ImageConstants.mirlConnect, fit: BoxFit.fitWidth, width: double.infinity),
              boxFit: BoxFit.cover,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              //controller:scrollController ,
              child: ValueListenableBuilder(
                valueListenable: mirlConnectView,
                builder: (context, value, child) {
                  if (mirlConnectView.value == 0) {
                    return ActivateYourMirlConnectCodeWidget();
                  } else if (mirlConnectView.value == 1) {
                    return GetYourOwnMirlConnectCodeWidget();
                  }
                  return YourMirlConnectCodeWidget();
                },
              ).addMarginX(32),
            ),
          ),
        ],
      ),
    );
  }
}
