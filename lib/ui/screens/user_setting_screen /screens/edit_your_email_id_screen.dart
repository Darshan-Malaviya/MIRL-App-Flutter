import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class EditYourEmailIdScreen extends ConsumerStatefulWidget {
  const EditYourEmailIdScreen({super.key});

  @override
  ConsumerState<EditYourEmailIdScreen> createState() => _EditYourEmailIdScreenState();
}

class _EditYourEmailIdScreenState extends ConsumerState<EditYourEmailIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () => context.toPop(),
            ),
            trailingIcon: InkWell(
              // onTap: () => expertRead.updateExpertNameApi(),
              child: TitleMediumText(
                title: StringConstants.done,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleLargeText(
                title: LocaleKeys.emailId.tr(),
                titleColor: ColorConstants.bottomTextColor,
              ),
              30.0.spaceY,
              TextFormFieldWidget(
                height: 36,
               // hintText: StringConstants.officialNameHere,
                // controller: expertWatch.expertNameController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                onFieldSubmitted: (value){
                  context.unFocusKeyboard();
                },
                textInputAction: TextInputAction.done,
              ),
              20.0.spaceY,
            ],
          ).addAllPadding(20),
        ));
  }
}
