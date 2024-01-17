import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/providers/provider_registration.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';
import 'package:mirl/ui/common/text_widgets/textfield/textformfield_widget.dart';

class YourMirlIdScreen extends ConsumerStatefulWidget {
  const YourMirlIdScreen({super.key});

  @override
  ConsumerState<YourMirlIdScreen> createState() => _YourMirlIdScreenState();
}

class _YourMirlIdScreenState extends ConsumerState<YourMirlIdScreen> {
  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.watch(editExpertProvider);
    return Scaffold(
        appBar: AppBarWidget(
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            trailingIcon: InkWell(
              onTap: () {
                expertRead.UpdateUserDetailsApiCall();
              },
              child: TitleMediumText(
                title: StringConstants.done,
                fontFamily: FontWeightEnum.w700.toInter,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleLargeText(
                title: StringConstants.yourMirlId,
                titleColor: ColorConstants.bottomTextColor,
                fontFamily: FontWeightEnum.w700.toInter,
              ),
              30.0.spaceY,
              TextFormFieldWidget(
                height: 36,
                hintText: StringConstants.charactersLong,
                onFieldSubmitted: (value) {},
                controller: expertWatch.mirlIdController,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.uniqueId,
                titleTextAlign: TextAlign.center,
                maxLine: 4,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.timeOrAdvice,
                titleTextAlign: TextAlign.center,
                maxLine: 6,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.mirlQrCode,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.changeMirlId,
                titleTextAlign: TextAlign.center,
                maxLine: 2,
              ),
            ],
          ).addAllPadding(20),
        ));
  }
}
