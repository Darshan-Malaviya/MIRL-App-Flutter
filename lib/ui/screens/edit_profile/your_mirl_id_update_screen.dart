import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class YourMirlIdScreen extends ConsumerStatefulWidget {
  const YourMirlIdScreen({super.key});

  @override
  ConsumerState<YourMirlIdScreen> createState() => _YourMirlIdScreenState();
}

class _YourMirlIdScreenState extends ConsumerState<YourMirlIdScreen> {
  final _loginPassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.watch(editExpertProvider);
    return Scaffold(
        appBar: AppBarWidget(
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () => context.toPop(),
            ),
            trailingIcon: InkWell(
              onTap: () {
                context.unFocusKeyboard();
                if (_loginPassKey.currentState?.validate() ?? false) {
                  expertRead.updateMirlIdApi();
                }
              },
              child: TitleMediumText(
                title: StringConstants.done,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Form(
            key: _loginPassKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleLargeText(
                  title: StringConstants.yourMirlId,
                  titleColor: ColorConstants.bottomTextColor,
                ),
                30.0.spaceY,
                TextFormFieldWidget(
                  hintText: StringConstants.charactersLong,
                  controller: expertWatch.mirlIdController,
                  validator: (value) {
                    return value?.toMirlIdValidation(LocaleKeys.pleaseEnterMirlID.tr(),LocaleKeys.idContainsOnlyCharacter.tr());
                  },
                  onFieldSubmitted: (value) {
                    context.unFocusKeyboard();
                  },
                  textInputAction: TextInputAction.done,
                ),
                20.0.spaceY,
                TitleSmallText(
                  fontFamily: FontWeightEnum.w400.toInter,
                  title: StringConstants.uniqueId,
                  titleTextAlign: TextAlign.center,
                  maxLine: 4,
                ),
                20.0.spaceY,
                TitleSmallText(
                  fontFamily: FontWeightEnum.w400.toInter,
                  title: StringConstants.timeOrAdvice,
                  titleTextAlign: TextAlign.center,
                  maxLine: 6,
                ),
                20.0.spaceY,
                TitleSmallText(
                  fontFamily: FontWeightEnum.w400.toInter,
                  title: StringConstants.mirlQrCode,
                  titleTextAlign: TextAlign.center,
                  maxLine: 3,
                ),
                20.0.spaceY,
                TitleSmallText(
                  fontFamily: FontWeightEnum.w400.toInter,
                  title: StringConstants.changeMirlId,
                  titleTextAlign: TextAlign.center,
                  maxLine: 2,
                ),
              ],
            ).addAllPadding(20),
          ),
        ));
  }
}
