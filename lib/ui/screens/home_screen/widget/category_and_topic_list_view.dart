import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
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
          height: ((homeProviderWatch.homeData?.categories?.length ?? 0) <= 4) ? 120 : 255,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: homeProviderWatch.homeData?.categories?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen,
                      args: SelectedCategoryArgument(
                          categoryId: homeProviderWatch.homeData?.categories?[index].id.toString() ?? '',
                          isFromExploreExpert: false));
                },
                child: ShadowContainer(
                  shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                  height: 110,
                  offset: Offset(0,2),
                  spreadRadius: 0,
                  blurRadius: 3,
                  width: 90,
                  isShadow: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: NetworkImageWidget(
                          boxFit: BoxFit.cover,
                          imageURL: homeProviderWatch.homeData?.categories?[index].image ?? '',
                          isNetworkImage: true,
                          height: 60,
                          width: 50,
                        ),
                      ),
                      4.0.spaceY,
                      LabelSmallText(
                        fontSize: 9,
                        title: homeProviderWatch.homeData?.categories?[index].name ?? '',
                        maxLine: 2,
                        titleTextAlign: TextAlign.center,
                      ),
                    ],
                  ),

                ),
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
          title: 'No category found',
        ),
      ]
    ]);
  }
}
