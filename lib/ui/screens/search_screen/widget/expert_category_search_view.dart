import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/container_widgets/category_common_view.dart';
import 'package:mirl/ui/screens/expert_category_screen/arguments/selected_category_arguments.dart';

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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.0.spaceY,
        BodySmallText(
          title: LocaleKeys.expertCategories.tr(),
          titleTextAlign: TextAlign.start,
        ),
        if (homeProviderWatch.homeSearchData?.categories?.isNotEmpty ?? false) ...[
          20.0.spaceY,
          GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: List.generate(
              homeProviderWatch.homeSearchData?.categories?.length ?? 0,
              (index) => CategoryCommonView(
                  onTap: () {
                    context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen,
                        args: SelectedCategoryArgument(
                            categoryId: homeProviderWatch.homeSearchData?.categories?[index].id.toString() ?? '',
                            isFromExploreExpert: false,
                            categoryName: homeProviderWatch.homeSearchData?.categories?[index].name.toString() ?? ''));
                  },
                  categoryName: homeProviderWatch.homeSearchData?.categories?[index].name ?? '',
                  imageUrl: homeProviderWatch.homeSearchData?.categories?[index].image ?? ''),
            ),
          ),
        ] else ...[
          10.0.spaceY,
          BodySmallText(
            titleTextAlign: TextAlign.start,
            fontFamily: FontWeightEnum.w400.toInter,
            maxLine: 4,
            title: LocaleKeys.noResultsFoundTypeSomethingElse.tr(),
          ),
        ]
      ],
    );
  }
}
