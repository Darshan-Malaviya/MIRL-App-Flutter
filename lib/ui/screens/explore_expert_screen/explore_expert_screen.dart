import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_args.dart';

class ExploreExpertScreen extends ConsumerStatefulWidget {
  const ExploreExpertScreen({super.key});

  @override
  ConsumerState<ExploreExpertScreen> createState() => _ExploreExpertScreenState();
}

class _ExploreExpertScreenState extends ConsumerState<ExploreExpertScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(filterProvider).exploreExpertUserAndCategoryApiCall();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterProviderWatch = ref.watch(filterProvider);
    final filterProviderRead = ref.read(filterProvider);
    return Scaffold(
        backgroundColor: ColorConstants.grayLightColor,
        appBar: AppBarWidget(
          preferSize: 0,
        ),
        body: Column(
          children: [
            Row(
              children: [
                InkWell(
                  child: Image.asset(ImageConstants.backIcon),
                  onTap: () => context.toPop(),
                ),
                15.0.spaceX,
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: ColorConstants.dropDownBorderColor)),
                    child: BodySmallText(
                      maxLine: 2,
                      title: LocaleKeys.searchCategory.tr(),
                      fontFamily: FontWeightEnum.w400.toInter,
                    ).addAllMargin(12),
                  ),
                ),
              ],
            ),
            20.0.spaceY,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShadowContainer(
                      shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: NetworkImageWidget(
                              boxFit: BoxFit.cover,
                              imageURL: ImageConstants.exploreImage,
                              isNetworkImage: true,
                              height: 60,
                              width: 50,
                            ),
                          ),
                          4.0.spaceY,
                          LabelSmallText(
                            fontSize: 9,
                            title: 'Vaidehii',
                            maxLine: 2,
                            titleTextAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      width: 90,
                      isShadow: true,
                    ),
                    20.0.spaceY,
                    InkWell(
                      onTap: () {
                        // context.toPushNamed(RoutesConstants.expertCategoryScreen);
                      },
                      child: LabelSmallText(
                        fontSize: 10,
                        title: LocaleKeys.seeAllExpertCategoryAndTopics.tr().toUpperCase(),
                      ),
                    ),
                    40.0.spaceY,
                    PrimaryButton(
                      title: LocaleKeys.FilterExperts.tr(),
                      onPressed: () {
                        context.toPushNamed(RoutesConstants.expertCategoryFilterScreen, args: FilterArgs(fromExploreExpert: true));
                      },
                      prefixIcon: ImageConstants.filter,
                      prefixIconPadding: 10,
                    ).addPaddingX(20),
                    40.0.spaceY,
                 //   ExpertDetailWidget()
                  ],
                ),
              ),
            ),
          ],
        ).addAllPadding(20));
  }
}
