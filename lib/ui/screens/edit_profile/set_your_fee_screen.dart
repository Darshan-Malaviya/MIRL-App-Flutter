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
  void initState() {
    super.initState();
    // ref.watch(editExpertProvider).countController.text = "0"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
   // final expertRead = ref.read(editExpertProvider);
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
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
              PlusButtonWidget(onTap: () {
                double currentValue = double.parse(expertWatch.countController.text);
                setState(() {
                  currentValue++;
                  expertWatch.countController.text = (currentValue).toString(); // incrementing value
                });
                // setState(() {
                //   int.parse(countController.text);
                //   counter++;
                // });
                //expertRead.counterController();
              }),
              // TitleSmallText(
              //   title: '${expertWatch.controller.count}',
              // ),
              TextFormFieldWidget(
                controller: expertWatch.countController,
                width: 150,
                textInputType: TextInputType.number,
                textAlign: TextAlign.center,
              ).addAllPadding(16),
              MinusButtonWidget(
                onTap: () {
                  double currentValue = double.parse(expertWatch.countController.text);
                  setState(() {
                    print("Setting state");
                    currentValue--;
                    expertWatch.countController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                  });
                  // setState(() {
                  //   int.parse(countController.text);
                  //   counter--;
                  // });
                  //expertRead.removeCounterController();
                },
              ),
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
          TitleSmallText(title: StringConstants.ourAppFees, titleColor: ColorConstants.bottomTextColor),
          PrimaryButton(title: StringConstants.userFees, onPressed: () {}).addAllPadding(50),
        ],
      ),
    );
  }
}
