import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class EditYourNameScreen extends ConsumerStatefulWidget {
  const EditYourNameScreen({super.key});

  @override
  ConsumerState<EditYourNameScreen> createState() => _EditYourNameScreenState();
}

class _EditYourNameScreenState extends ConsumerState<EditYourNameScreen> {
  @override
  Widget build(BuildContext context) {
    final userSettingWatch = ref.watch(userSettingProvider);
    final userSettingRead = ref.read(userSettingProvider);
    return Scaffold(
        appBar: AppBarWidget(
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () => context.toPop(),
            ),
            trailingIcon: InkWell(
              onTap: () {
                context.unFocusKeyboard();
                userSettingRead.updateUserNameApi();
              },
              child: TitleMediumText(
                title: StringConstants.done,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleLargeText(
                title: LocaleKeys.yourName.tr(),
                titleColor: ColorConstants.bottomTextColor,
              ),
              30.0.spaceY,
              TextFormFieldWidget(
                height: 36,
                //hintText: StringConstants.officialNameHere,
                controller: userSettingWatch.userNameController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                onFieldSubmitted: (value) {
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
