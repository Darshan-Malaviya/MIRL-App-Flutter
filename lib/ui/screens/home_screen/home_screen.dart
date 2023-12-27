import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/route_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/navigator_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/services/shared_pref_helper.dart';
import 'package:mirl/ui/common/button_widget/primary_button.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: BodyLargeText(
            title: "Welcome to home screen",
            fontFamily: FontWeightEnum.w600.toInter,
            fontSize: 20,
          ),
        ),
        30.0.spaceY,
        PrimaryButton(
          title: StringConstants.logOut,
          onPressed: () async {
            SharedPrefHelper.clearPrefs();
            // ignore: use_build_context_synchronously
            context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
          },
        ),
      ],
    ).addAllPadding(20));
  }
}
