import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

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
          child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: filterProviderWatch.categoryList?.category?.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    4.0.spaceY,
                    InkWell(
                      onTap: () {
                        context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen,
                            args: filterProviderWatch.categoryList?.category?[index].id.toString());
                      },
                      child: ShadowContainer(
                        shadowColor: ColorConstants.blackColor.withOpacity(0.1),
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
                    )
                  ],
                );
              }),
        ),
        InkWell(
          onTap: () {
            context.toPushNamed(RoutesConstants.expertCategoryScreen);
          },
          child: LabelSmallText(
            fontSize: 10,
            title: LocaleKeys.seeAllExpertCategoryAndTopics.tr().toUpperCase(),
          ).addMarginY(20),
        ),
      ],
    );
  }
}
