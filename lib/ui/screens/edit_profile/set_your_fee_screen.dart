import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/button_widget/minus_button.dart';
import 'package:mirl/ui/common/button_widget/plus_button.dart';

class SetYourFreeScreen extends ConsumerStatefulWidget {
  const SetYourFreeScreen({super.key});

  @override
  ConsumerState<SetYourFreeScreen> createState() => _SetYourFreeScreenState();
}

class _SetYourFreeScreenState extends ConsumerState<SetYourFreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading:  InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        trailingIcon: TitleMediumText(
          title: StringConstants.done,
          fontFamily: FontWeightEnum.w700.toInter,
        ).addPaddingRight(14),
      ),
      body: Column(
        children: [
          TitleLargeText(
            title: StringConstants.setYourFee,
            titleColor: ColorConstants.bottomTextColor,
            fontFamily: FontWeightEnum.w700.toInter,
          ),
          30.0.spaceY,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlusButtonWidget(),
              TextFormFieldWidget(
                width: 150,
                textInputType: TextInputType.number,
              ).addAllPadding(16),
              MinusButtonWidget(),
            ],
          ),
          TitleSmallText(
            title: StringConstants.currency,
          ),
          10.0.spaceY,
          TitleSmallText(
            title: StringConstants.appFees,
          ),
          4.0.spaceY,
          TitleSmallText(
              title: StringConstants.ourAppFees,
              titleColor: ColorConstants.bottomTextColor),
          PrimaryButton(title: StringConstants.userFees, onPressed: () {}).addAllPadding(50),
        ],
      ),
    );
  }
}