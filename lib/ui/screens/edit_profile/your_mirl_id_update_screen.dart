import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class YourMirlIdScreen extends ConsumerStatefulWidget {
  const YourMirlIdScreen({super.key});

  @override
  ConsumerState<YourMirlIdScreen> createState() => _YourMirlIdScreenState();
}

class _YourMirlIdScreenState extends ConsumerState<YourMirlIdScreen> {
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
                expertRead.updateMirlIdApi();
              },
              child: TitleMediumText(
                title: StringConstants.done,
                fontFamily: FontWeightEnum.w700.toInter,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleLargeText(
                title: StringConstants.yourMirlId,
                titleColor: ColorConstants.bottomTextColor,
                fontFamily: FontWeightEnum.w700.toInter,
              ),
              30.0.spaceY,
              TextFormFieldWidget(
                height: 36,
                hintText: StringConstants.charactersLong,
                onFieldSubmitted: (value) {},
                controller: expertWatch.mirlIdController,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.uniqueId,
                titleTextAlign: TextAlign.center,
                maxLine: 4,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.timeOrAdvice,
                titleTextAlign: TextAlign.center,
                maxLine: 6,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.mirlQrCode,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.changeMirlId,
                titleTextAlign: TextAlign.center,
                maxLine: 2,
              ),
            ],
          ).addAllPadding(20),
        ));
  }
}
