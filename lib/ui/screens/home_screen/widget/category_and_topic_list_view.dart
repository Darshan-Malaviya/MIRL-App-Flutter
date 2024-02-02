import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CategoryAndTopicListView extends ConsumerStatefulWidget {
  const CategoryAndTopicListView({super.key});

  @override
  ConsumerState<CategoryAndTopicListView> createState() => _CategoryAndTopicListViewState();
}

class _CategoryAndTopicListViewState extends ConsumerState<CategoryAndTopicListView> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    return Column(
      children: [
        SizedBox(
          height: ((homeProviderWatch.homeData?.categories?.length ?? 0) <= 4) ? 120 : 240,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: homeProviderWatch.homeData?.categories?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  4.0.spaceY,
                  InkWell(
                    onTap: () {
                      context.toPushNamed(RoutesConstants.selectedExpertCategoryScreen,
                          args: homeProviderWatch.homeData?.categories?[index].id.toString());
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
                      width: 90,
                      isShadow: true,
                    ),
                  ),
                ],
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
        ),
      ],
    );
  }
}
