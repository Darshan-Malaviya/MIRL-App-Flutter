import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/explore_expert_screen/widget/category_image_and_name_list_widget.dart';
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0), border: Border.all(color: ColorConstants.dropDownBorderColor)),
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
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  CategoryNameAndImageListView(),
                  PrimaryButton(
                    title: LocaleKeys.filterExperts.tr(),
                    onPressed: () {
                      context.toPushNamed(RoutesConstants.expertCategoryFilterScreen, args: FilterArgs(fromExploreExpert: true));
                    },
                    prefixIcon: ImageConstants.filter,
                    prefixIconPadding: 10,
                  ).addPaddingX(20),
                ]),
              ),
            ),
          ],
        ).addAllPadding(20));
  }
}
