import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class YourExpertProfileNameScreen extends ConsumerStatefulWidget {
  const YourExpertProfileNameScreen({super.key});

  @override
  ConsumerState<YourExpertProfileNameScreen> createState() => _YourExpertProfileNameScreenState();
}

class _YourExpertProfileNameScreenState extends ConsumerState<YourExpertProfileNameScreen> {
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
                expertRead.updateExpertNameApi();
              },
              child: TitleMediumText(
                title: StringConstants.done,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleLargeText(
                title: StringConstants.yourExpertProfileName,
                titleColor: ColorConstants.bottomTextColor,
              ),
              30.0.spaceY,
              TextFormFieldWidget(
                height: 36,
                hintText: StringConstants.officialNameHere,
                controller: expertWatch.expertNameController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                onFieldSubmitted: (value){
                  context.unFocusKeyboard();
                },
                textInputAction: TextInputAction.done,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.aroundTheWorld,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                maxLine: 4,
              ),
              20.0.spaceY,
              TitleSmallText(
                fontFamily: FontWeightEnum.w400.toInter,
                title: StringConstants.twoWeeks,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
            ],
          ).addAllPadding(20),
        ));
  }
}
