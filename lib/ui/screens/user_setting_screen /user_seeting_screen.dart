import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/instant_call_screen/instant_call_screen.dart';

class UserSettingScreen extends ConsumerStatefulWidget {
  const UserSettingScreen({super.key});

  @override
  ConsumerState<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends ConsumerState<UserSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrimaryButton(
          title: 'On Tap',
          onPressed: () {
            CommonAlertDialog.callDialog(
              context: context,
              child: InstantCallRequestDialog(
                title: LocaleKeys.instantCallRequest.tr(),
                desc: LocaleKeys.requestCallDesc.tr(),
                callTypeEnum: CallType.requestDeclined.name,
                name: 'Preeti\nTewari Serai',
                image:
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                firstBTnTitle: LocaleKeys.requestCall.tr(),
                bgColor: ColorConstants.yellowButtonColor,
                secondBtnTile: LocaleKeys.goBack.tr(),
                onFirstBtnTap: () {},
                onSecondBtnTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
