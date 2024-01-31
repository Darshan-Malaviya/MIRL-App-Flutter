import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ExpertCategorySearchView extends ConsumerStatefulWidget {
  const ExpertCategorySearchView({super.key});

  @override
  ConsumerState<ExpertCategorySearchView> createState() => _ExpertCategorySearchViewState();
}

class _ExpertCategorySearchViewState extends ConsumerState<ExpertCategorySearchView> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.0.spaceY,
        BodySmallText(
          title: LocaleKeys.expertCategories.tr(),
          titleTextAlign: TextAlign.start,
          fontFamily: FontWeightEnum.w700.toInter,
        ),
        20.0.spaceY,
        if (homeProviderWatch.homeSearchData?.categories?.isNotEmpty ?? false) ...[
          SizedBox(
            height: ((homeProviderWatch.homeSearchData?.categories?.length ?? 0) <= 4) ? 120 : 240,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: homeProviderWatch.homeSearchData?.categories?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    4.0.spaceY,
                    InkWell(
                      onTap: () {},
                      child: ShadowContainer(
                        shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: NetworkImageWidget(
                                boxFit: BoxFit.cover,
                                imageURL: homeProviderWatch.homeSearchData?.categories?[index].image ?? '',
                                isNetworkImage: true,
                                height: 60,
                                width: 50,
                              ),
                            ),
                            4.0.spaceY,
                            LabelSmallText(
                              fontSize: 9,
                              title: homeProviderWatch.homeSearchData?.categories?[index].name?.toUpperCase() ?? '',
                              maxLine: 2,
                              titleColor: ColorConstants.blackColor,
                              fontFamily: FontWeightEnum.w700.toInter,
                              titleTextAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        width: 90,
                        isShadow: true,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ] else ...[
          BodySmallText(
            fontWeight: FontWeight.w400,
            titleTextAlign: TextAlign.start,
            fontFamily: AppConstants.fontFamily,
            maxLine: 4,
            fontSize: 12,
            title: LocaleKeys.noResultsFoundTypeSomethingElse.tr(),
          ),
        ]
      ],
    );
  }
}
