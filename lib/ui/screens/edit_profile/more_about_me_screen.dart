import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class MoreAboutMeScreen extends ConsumerStatefulWidget {
  const MoreAboutMeScreen({super.key});

  @override
  ConsumerState<MoreAboutMeScreen> createState() => _MoreAboutMeScreenState();
}

class _MoreAboutMeScreenState extends ConsumerState<MoreAboutMeScreen> {
  FocusNode aboutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);

    return Scaffold(
        appBar: AppBarWidget(
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () => context.toPop(),
            ),
            trailingIcon: InkWell(
              onTap: () {
                aboutFocusNode.unfocus();
                expertRead.updateAboutApi();
              },
              child: TitleMediumText(
                title: StringConstants.done,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleLargeText(
                title: StringConstants.moreAboutMe,
                titleColor: ColorConstants.bottomTextColor,
              ),
              60.0.spaceY,
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TextFormFieldWidget(
                    onChanged: expertRead.changeAboutCounterValue,
                    maxLines: 10,
                    maxLength: 1500,
                    minLines: 8,
                    controller: expertWatch.aboutMeController,
                    focusNode: aboutFocusNode,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    setFormatter: false,
                    contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 30),
                    onFieldSubmitted: (value) {
                      aboutFocusNode.unfocus();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 12),
                    child: BodySmallText(
                      title: '${expertWatch.enteredText}/1500 ${LocaleKeys.characters.tr()}',
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ),
                ],
              ),
              30.0.spaceY,
              TitleSmallText(
                fontFamily: FontWeightEnum.w400.toInter,
                title: StringConstants.professionalSkills,
                titleTextAlign: TextAlign.center,
                maxLine: 10,
              ),
            ],
          ).addAllPadding(20),
        ));
  }
}

class _Utf8LengthLimitingTextInputFormatter extends TextInputFormatter {
  _Utf8LengthLimitingTextInputFormatter(this.maxLength) : assert(maxLength == -1 || maxLength > 0);

  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength > 0 && bytesLength(newValue.text) > maxLength) {
      // If already at the maximum and tried to enter even more, keep the old value.
      if (bytesLength(oldValue.text) == maxLength) {
        return oldValue;
      }
      return truncate(newValue, maxLength);
    }
    return newValue;
  }

  static TextEditingValue truncate(TextEditingValue value, int maxLength) {
    var newValue = '';
    if (bytesLength(value.text) > maxLength) {
      var length = 0;

      value.text.characters.takeWhile((char) {
        var nbBytes = bytesLength(char);
        if (length + nbBytes <= maxLength) {
          newValue += char;
          length += nbBytes;
          return true;
        }
        return false;
      });
    }
    return TextEditingValue(
      text: newValue,
      selection: value.selection.copyWith(
        baseOffset: min(value.selection.start, newValue.length),
        extentOffset: min(value.selection.end, newValue.length),
      ),
      composing: TextRange.empty,
    );
  }

  static int bytesLength(String value) {
    return utf8.encode(value).length;
  }
}
