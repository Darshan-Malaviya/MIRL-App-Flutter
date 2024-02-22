import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/ui/common/container_widgets/category_common_view.dart';
import 'package:mirl/ui/screens/expert_category_screen/arguments/selected_category_arguments.dart';

class CategoryAndTopicListView extends ConsumerStatefulWidget {
  const CategoryAndTopicListView({super.key});

  @override
  ConsumerState<CategoryAndTopicListView> createState() => _CategoryAndTopicListViewState();
}

class _CategoryAndTopicListViewState extends ConsumerState<CategoryAndTopicListView> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    return Column(children: [
      if ((homeProviderWatch.homeData?.categories?.isNotEmpty ?? false) && homeProviderWatch.homeData?.categories != null) ...[
        SizedBox(
          height: ((homeProviderWatch.homeData?.categories?.length ?? 0) <= 3) ? 100 : 235,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: homeProviderWatch.homeData?.categories?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index) {
              return CategoryCommonView(
                onTap: (){
                  context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen,
                      args: SelectedCategoryArgument(
                          categoryId: homeProviderWatch.homeData?.categories?[index].id.toString() ?? '',
                          isFromExploreExpert: false));
                },
                categoryName: homeProviderWatch.homeData?.categories?[index].name?.toUpperCase() ?? '',
                imageUrl: homeProviderWatch.homeData?.categories?[index].image ?? '',
              );
            },
          ),
        ),
        InkWell(
          onTap: () {
            context.toPushNamed(RoutesConstants.expertCategoryScreen);
          },
          child: LabelSmallText(
            fontSize: 10,
            title: LocaleKeys.seeAllExpertCategoryAndTopics.tr().toUpperCase(),
          ).addMarginY(20),
        ).addVisibility(homeProviderWatch.homeData?.categories?.isNotEmpty ?? false),
      ] else ...[
        BodySmallText(
          titleColor: ColorConstants.emptyTextColor,
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 4,
          title: LocaleKeys.noCategoryFound.tr(),
        ),
      ]
    ]);
  }
}
