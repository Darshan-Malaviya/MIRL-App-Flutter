import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class MultiConnectCategoryWidget extends ConsumerWidget {
  const MultiConnectCategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final multiProviderWatch = ref.watch(multiConnectProvider);
    if (multiProviderWatch.categoryList?.isNotEmpty ?? false) {
      return GridView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: (multiProviderWatch.categoryList?.length ?? 0) + (multiProviderWatch.reachedCategoryLastPage ? 0 : 1),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.9,crossAxisSpacing: 10),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          if (index == multiProviderWatch.categoryList?.length && (multiProviderWatch.categoryList?.isNotEmpty ?? false)) {} else {
            return InkWell(
              onTap: () {
                context.toPushNamed(RoutesConstants.multiConnectSelectedCategoryScreen, args: FilterArgs(categoryId: multiProviderWatch.categoryList?[index].id.toString()));
              },
              child: ShadowContainer(
                shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                height: 110,
                offset: Offset(0, 2),
                spreadRadius: 0,
                blurRadius: 3,
                width: 100,
                isShadow: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: NetworkImageWidget(
                        boxFit: BoxFit.cover,
                        imageURL: multiProviderWatch.categoryList?[index].image ?? '',
                        isNetworkImage: true,
                        height: 60,
                        width: 50,
                      ),
                    ),
                    6.0.spaceY,
                    LabelSmallText(
                      fontSize: 9,
                      title: multiProviderWatch.categoryList?[index].name ?? '',
                      maxLine: 2,
                      titleTextAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        }
      );
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
