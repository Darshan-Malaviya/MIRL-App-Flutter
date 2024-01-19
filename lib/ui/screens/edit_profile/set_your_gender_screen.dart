import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/models/response/gender_model.dart';
import 'package:mirl/infrastructure/providers/provider_registration.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class SetYourGenderScreen extends ConsumerStatefulWidget {
  const SetYourGenderScreen({super.key});

  @override
  ConsumerState<SetYourGenderScreen> createState() => _SetYourGenderScreenState();
}

class _SetYourGenderScreenState extends ConsumerState<SetYourGenderScreen> {
  int? index;

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);
    return Scaffold(
      appBar: AppBarWidget(
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          trailingIcon: InkWell(
            onTap: () => expertRead.updateGenderApi(),
            child: TitleMediumText(
              title: StringConstants.done,
              fontFamily: FontWeightEnum.w700.toInter,
            ).addPaddingRight(14),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TitleLargeText(
                title: StringConstants.setYourGender,
                titleColor: ColorConstants.bottomTextColor,
                fontFamily: FontWeightEnum.w700.toInter,
              ),
              120.0.spaceY,
              DropdownMenuWidget(
                controller: expertWatch.genderController,
                hintText: StringConstants.theDropDown,
                dropdownList: expertWatch.genderList.map((GenderModel item) => dropdownMenuEntry(context: context, value: item.title ?? '', label: item.title ?? '')).toList(),
                onSelect: (String value) {
                  expertRead.setGender(value);
                },
              )
            ],
          ),
        ).addAllPadding(20),
      ),
    );
  }
}
