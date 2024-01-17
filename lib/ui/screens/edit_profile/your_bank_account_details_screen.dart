import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class YourBankAccountDetailsScreen extends ConsumerStatefulWidget {
  const YourBankAccountDetailsScreen({super.key});

  @override
  ConsumerState<YourBankAccountDetailsScreen> createState() => _YourBankAccountDetailsScreenState();
}

class _YourBankAccountDetailsScreenState extends ConsumerState<YourBankAccountDetailsScreen> {
  FocusNode bankNameFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode accountFocus = FocusNode();

  final _loginPassKey = GlobalKey<FormState>();

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
          trailingIcon: OnScaleTap(
            onPress: () {
              if (_loginPassKey.currentState?.validate() ?? false) {
                expertRead.UpdateUserDetailsApiCall();
              }
            },
            child: TitleMediumText(
              title: StringConstants.done,
              fontFamily: FontWeightEnum.w700.toInter,
            ).addPaddingRight(14),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _loginPassKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleLargeText(
                  title: StringConstants.bankAccountDetails,
                  titleColor: ColorConstants.bottomTextColor,
                  fontFamily: FontWeightEnum.w700.toInter,
                  maxLine: 2,
                  titleTextAlign: TextAlign.center,
                ),
                20.0.spaceY,
                TitleSmallText(
                  title: StringConstants.shareBankAccountDetails,
                  titleTextAlign: TextAlign.center,
                  maxLine: 3,
                ),
                20.0.spaceY,
                TitleSmallText(
                  title: StringConstants.updateBankAccountDetails,
                  titleTextAlign: TextAlign.center,
                  maxLine: 2,
                ),
                20.0.spaceY,
                TitleSmallText(
                  title: StringConstants.informationRequired,
                  titleTextAlign: TextAlign.center,
                  maxLine: 2,
                ),
                12.0.spaceY,
                TextFormFieldWidget(
                  focusNode: nameFocus,
                  hintText: StringConstants.nameBankAccount,
                  controller: expertWatch.bankHolderNameController,
                  onFieldSubmitted: (value) {
                    nameFocus.toChangeFocus(currentFocusNode: nameFocus, nexFocusNode: bankNameFocus);
                  },
                ),
                20.0.spaceY,
                TextFormFieldWidget(
                  focusNode: bankNameFocus,
                  hintText: StringConstants.bankName,
                  controller: expertWatch.bankNameController,
                  onFieldSubmitted: (value) {
                    bankNameFocus.toChangeFocus(currentFocusNode: bankNameFocus, nexFocusNode: accountFocus);
                  },
                ),
                20.0.spaceY,
                TextFormFieldWidget(
                  focusNode: accountFocus,
                  hintText: StringConstants.accountNumber,
                  textInputAction: TextInputAction.done,
                  controller: expertWatch.accountNumberController,
                  onFieldSubmitted: (value) {
                    accountFocus.unfocus();
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(18),
                  ],
                  validator: (value) => value?.toEmptyStringValidation(msg: StringConstants.requiredAccountNumber),
                ),
              ],
            ).addAllPadding(24),
          ),
        ));
  }
}
