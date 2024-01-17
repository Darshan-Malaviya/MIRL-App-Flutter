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
              onTap: () {
                Navigator.pop(context);
              },
            ),
            trailingIcon: InkWell(
              onTap: () {
                expertRead.UpdateUserDetailsApiCall();
              },
              child: TitleMediumText(
                title: StringConstants.done,
                fontFamily: FontWeightEnum.w700.toInter,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleLargeText(
                title: StringConstants.yourExpertProfileName,
                titleColor: ColorConstants.bottomTextColor,
                fontFamily: FontWeightEnum.w700.toInter,
              ),
              30.0.spaceY,
              TextFormFieldWidget(
                height: 36,
                hintText: StringConstants.officialNameHere,
                onFieldSubmitted: (value) {},
                controller: expertWatch.expertNameController,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.aroundTheWorld,
                titleTextAlign: TextAlign.center,
                maxLine: 4,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.twoWeeks,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
            ],
          ).addAllPadding(20),
        ));
  }
}
