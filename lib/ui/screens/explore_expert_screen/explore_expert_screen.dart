import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/shimmer_widgets/home_page_shimmer.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details.dart';
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
      ref.read(homeProvider).clearSearchData();
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
                8.0.spaceX,
                Flexible(
                  child: TextFormFieldWidget(
                    // maxLines: 2,
                    textAlign: TextAlign.start,
                    suffixIcon: filterProviderWatch.exploreExpertController.text.isNotEmpty
                        ? InkWell(
                            onTap: () => filterProviderRead.clearSearchData(),
                            child: Icon(Icons.close),
                          )
                        : SizedBox.shrink(),
                    hintText: LocaleKeys.searchCategory.tr(),
                    fontFamily: FontWeightEnum.w400.toInter,
                    controller: filterProviderWatch.exploreExpertController,
                    onChanged: (value) {
                      if (filterProviderWatch.exploreExpertController.text.isNotEmpty) {
                        filterProviderRead.exploreExpertUserAndCategoryApiCall();
                      }
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      context.unFocusKeyboard();
                    },
                  ),
                ),
              ],
            ),
            20.0.spaceY,
            if (filterProviderWatch.isLoading) ...[
              Center(
                  child: CupertinoActivityIndicator(
                animating: true,
                color: ColorConstants.primaryColor,
                radius: 16,
              ).addPaddingY(20)),
            ] else ...[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (filterProviderWatch.isLoading) ...[
                        CategoryListShimmerWidget()
                      ] else ...[
                        CategoryNameAndImageListView(),
                      ],
                      PrimaryButton(
                        title: LocaleKeys.filterExperts.tr(),
                        onPressed: () {
                          context.toPushNamed(RoutesConstants.expertCategoryFilterScreen,
                              args: FilterArgs(fromExploreExpert: true));
                        },
                        prefixIcon: ImageConstants.filter,
                        prefixIconPadding: 10,
                      ),
                      40.0.spaceY,
                      if (filterProviderWatch.categoryList?.expertData?.isNotEmpty ?? false) ...[
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            //  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            itemBuilder: (context, i) {
                              return ExpertDetailWidget(
                                expertData: filterProviderWatch.categoryList?.expertData?[i],
                              );
                            },
                            separatorBuilder: (context, index) => 20.0.spaceY,
                            itemCount: filterProviderWatch.categoryList?.expertData?.length ?? 0),
                      ]
                    ],
                  ),
                ),
              ),
            ]
          ],
        ).addAllPadding(20));
  }
}
