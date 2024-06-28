import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class EditYourPhoneNumberScreen extends ConsumerStatefulWidget {
  const EditYourPhoneNumberScreen({super.key});

  @override
  ConsumerState<EditYourPhoneNumberScreen> createState() => _EditYourPhoneNumberScreenState();
}

class _EditYourPhoneNumberScreenState extends ConsumerState<EditYourPhoneNumberScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userSettingProvider).getDefaultCountryCode(context);
    });
  }
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
                userSettingRead.updatePhoneNumberApi();
              },
              child: TitleMediumText(
                title: StringConstants.done,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleLargeText(
                title: LocaleKeys.phoneNumber.tr(),
                titleColor: ColorConstants.bottomTextColor,
              ),
              // 30.0.spaceY,
              // TextFormFieldWidget(
              //   hintText: 'Phone Number',
              //   onFieldSubmitted: (value) {
              //     context.unFocusKeyboard();
              //   },
              //   prefixIconWidget:  IntrinsicHeight(
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         CountryCodePicker(
              //           initialSelection: userSettingWatch.countryName,
              //           onInit: (value) {
              //             userSettingRead
              //                 .setCountryCode(value?.dialCode.toString() ?? '+91');
              //             userSettingRead
              //                 .setCountryName(value?.code.toString() ?? "IN");
              //           },
              //           onChanged: (value) {
              //             userSettingRead
              //                 .setCountryCode(value.dialCode.toString());
              //           },
              //         ),
              //         VerticalDivider(
              //           width: 1,
              //           indent: 15,
              //           endIndent: 15,
              //           thickness: 1,
              //           color: ColorConstants.blackColor,
              //         ),
              //         const SizedBox(width: 10),
              //       ],
              //     ),
              //   ),
              //   textInputType:TextInputType.number,
              //   controller: userSettingWatch.phoneNumberController,
              //   textInputAction: TextInputAction.done,
              //   inputFormatters: [
              //     LengthLimitingTextInputFormatter(50),
              //   ],
              // ),
               30.0.spaceY,
              TextFormFieldWidget(
                hintText: LocaleKeys.phoneNumber.tr(),
                //textColor: ColorConstants.whiteColor,
                prefixIconWidget: InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    userSettingRead.getCountryData(context, this);
                    //CommonMethods.changeFocus(nexFocusNode: phoneNode);
                  },
                  child: Container(
                    height: 47,
                    width: 160,
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        // Image.asset(ImageConstants.plus),
                        // 6.0.spaceX,
                        BodyMediumText(title: "${userSettingWatch.country?.callingCode}"),
                        4.0.spaceX,
                        if (userSettingWatch.country?.flag != null) ...{
                          Image.asset(
                            "$countryCodePackageName${userSettingWatch.country?.flag}",
                            width: 34,
                          ),
                        },
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: ColorConstants.blackColor,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: VerticalDivider(
                            color: ColorConstants.blackColor,
                            width: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                controller: userSettingWatch.phoneNumberController,
                // focusNode: phoneNode,

                //hintText: LocaleKeys.enterYourPhone.tr(),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                  LengthLimitingTextInputFormatter(15),
                ],
                // onFieldSubmitted: (data) {
                //   CommonMethods.changeFocus(currentFocusNode: phoneNode, nexFocusNode: passwordNode);
                // },
                validator: (value) {
                  return value?.mobileNumberValidation(value: value);
                },
              ),
              // TextFormFieldWidget(
              //   height: 36,
              //   //  hintText: StringConstants.officialNameHere,
              //   controller: userSettingWatch.phoneNumberController,
              //   inputFormatters: [
              //     LengthLimitingTextInputFormatter(50),
              //   ],
              //   onFieldSubmitted: (value) {
              //     context.unFocusKeyboard();
              //   },textInputType: TextInputType.number,
              //   textInputAction: TextInputAction.done,
              // ),
              20.0.spaceY,
            ],
          ).addAllPadding(20),
        ));
  }
}
