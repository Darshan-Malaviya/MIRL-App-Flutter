import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/widget/activate_your_mirl_connect_code_widget.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/widget/get_your_own_mirl_connect_code_widget.dart';
import 'package:mirl/ui/screens/user_setting_screen%20/widget/your_mirl_connect_code_widget.dart';

class MirlConnectScreen extends ConsumerStatefulWidget {
  const MirlConnectScreen({super.key});

  @override
  ConsumerState<MirlConnectScreen> createState() => _MirlConnectScreenState();
}

class _MirlConnectScreenState extends ConsumerState<MirlConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purpleDarkColor,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Image.asset(ImageConstants.exploreImage, fit: BoxFit.fitWidth, width: double.infinity),
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: HeadlineMediumText(
                      title: 'MIRL Connect',
                      fontSize: 30,
                      titleColor: ColorConstants.bottomTextColor,
                    ),
                  ),
                  20.0.spaceY,
                  TitleSmallText(
                    title: LocaleKeys.unlimitedInvites.tr(),
                    titleColor: ColorConstants.blackColor,
                    fontFamily: FontWeightEnum.w600.toInter,
                  ),
                  //ActivateYourMirlConnectCodeWidget(),
              //    GetYourOwnMirlConnectCodeWidget(),
                  YourMirlConnectCodeWidget(),
                  20.0.spaceY,
                ],
              ).addAllPadding(32),
            ),
          ],
        ),
      ),
    );
  }
}
