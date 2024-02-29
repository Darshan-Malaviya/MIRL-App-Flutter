import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/button_widget/fees_action_button.dart';

class SetYourFreeScreen extends ConsumerStatefulWidget {
  const SetYourFreeScreen({super.key});

  @override
  ConsumerState<SetYourFreeScreen> createState() => _SetYourFreeScreenState();
}

class _SetYourFreeScreenState extends ConsumerState<SetYourFreeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).getUserData();
    });
    super.initState();
  }

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
          onTap: () => expertRead.updateFeesApi(),
          child: TitleMediumText(
            title: StringConstants.done,
          ).addPaddingRight(14),
        ),
      ),
      body: Column(
        children: [
          TitleLargeText(
            title: StringConstants.setYourFee,
            titleColor: ColorConstants.bottomTextColor,
          ),
          30.0.spaceY,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FeesActionButtonWidget(
                icons: ImageConstants.minus,
                isDisable: expertWatch.countController.text.isNotEmpty ? double.parse(expertWatch.countController.text) <= 0.99 : false,
                onTap: () {
                  expertRead.decreaseFees();
                },
              ),
              TextFormFieldWidget(
                controller: expertWatch.countController,
                width: 150,
                textInputType: TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                onChanged: (value) {
                  expertRead.changeFeesValue(value);
                },
                onFieldSubmitted: (value) {
                  context.unFocusKeyboard();
                },
              ).addAllPadding(16),
              FeesActionButtonWidget(
                  icons: ImageConstants.plus,
                  onTap: () {
                    expertRead.increaseFees();
                  }),
            ],
          ),
          TitleSmallText(
            fontFamily: FontWeightEnum.w400.toInter,
            title: StringConstants.currency,
          ),
          10.0.spaceY,
          TitleSmallText(
            fontFamily: FontWeightEnum.w400.toInter,
            title: StringConstants.appFees,
          ),
          4.0.spaceY,
          TitleSmallText(
            title: StringConstants.ourAppFees,
            titleColor: ColorConstants.bottomTextColor,
            fontFamily: FontWeightEnum.w400.toInter,
          ),
          50.0.spaceY,
          Container(
            width: MediaQuery.sizeOf(context).width * 0.8,
            padding: EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: ColorConstants.primaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BodyMediumText(
                  title: StringConstants.userFees,
                  titleColor: ColorConstants.buttonTextColor,
                ),
                BodyMediumText(
                  title: expertWatch.countController.text.isNotEmpty ? '\$${(double.parse(expertWatch.countController.text) * 0.20).toStringAsFixed(2)}' : '0.0',
                  titleColor: ColorConstants.buttonTextColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
