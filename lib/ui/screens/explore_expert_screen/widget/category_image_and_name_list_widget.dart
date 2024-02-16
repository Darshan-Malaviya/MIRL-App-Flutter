import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/providers/filter_provider.dart';
import 'package:mirl/ui/screens/expert_category_screen/arguments/selected_category_arguments.dart';

class CategoryNameAndImageListView extends ConsumerStatefulWidget {
  const CategoryNameAndImageListView({super.key});

  @override
  ConsumerState<CategoryNameAndImageListView> createState() => _CategoryNameAndImageListViewState();
}

class _CategoryNameAndImageListViewState extends ConsumerState<CategoryNameAndImageListView> {
  @override
  Widget build(BuildContext context) {
    final filterProviderWatch = ref.watch(filterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 120,
          child: buildListWidget(filterProviderWatch),
        ),
        5.0.spaceY,
        Visibility(
          visible: filterProviderWatch.categoryList?.category?.isNotEmpty ?? false,
          replacement: SizedBox.shrink(),
          child: InkWell(
            onTap: () {
              context.toPushNamed(RoutesConstants.expertCategoryScreen);
            },
            child: LabelSmallText(
              fontSize: 10,
              title: LocaleKeys.seeAllExpertCategoryAndTopics.tr().toUpperCase(),
            ).addMarginBottom(20),
          ),
        ),
      ],
    );
  }

  Widget buildListWidget(FilterProvider filterProviderWatch) {
    if (filterProviderWatch.categoryList?.category?.isNotEmpty ?? false) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: filterProviderWatch.categoryList?.category?.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen,
                    args: SelectedCategoryArgument(categoryId: filterProviderWatch.categoryList?.category?[index].id.toString() ?? '', isFromExploreExpert: true));
              },
              child: ShadowContainer(
                shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                height: 110,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: NetworkImageWidget(
                        boxFit: BoxFit.cover,
                        imageURL: filterProviderWatch.categoryList?.category?[index].image ?? '',
                        isNetworkImage: true,
                        height: 60,
                        width: 50,
                      ),
                    ),
                    4.0.spaceY,
                    LabelSmallText(
                      fontSize: 9,
                      title: filterProviderWatch.categoryList?.category?[index].name ?? '',
                      maxLine: 2,
                      titleTextAlign: TextAlign.center,
                    ),
                  ],
                ),
                width: 90,
                isShadow: true,
              ).addMarginX(6),
            );
          });
    } else {
      return Center(
        child: BodySmallText(
          titleColor: ColorConstants.blackColor,
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 4,
          title: LocaleKeys.noCategoryFound.tr(),
        ),
      );
    }
  }
}
