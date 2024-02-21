import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/string_extention.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';

class FavoriteExpertsView extends ConsumerWidget {
  const FavoriteExpertsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProviderWatch = ref.watch(homeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodySmallText(
          title: LocaleKeys.yourFavoriteExperts.tr(),
        ),

        if ((homeProviderWatch.homeData?.userFavorites?.isNotEmpty ?? false) && homeProviderWatch.homeData?.userFavorites != null) ...[
          20.0.spaceY,
          SizedBox(
            height: 120,
            child: ListView.builder(
                itemCount: homeProviderWatch.homeData?.userFavorites?.length ?? 0,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.toPushNamed(RoutesConstants.expertDetailScreen, args: homeProviderWatch.homeData?.userFavorites?[index].id.toString());
                    },
                    child: ShadowContainer(
                      padding: EdgeInsets.only(bottom: 8, top: 1, left: 8, right: 8),
                      shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                      width: 96,
                      height: 120,
                      isShadow: true,
                      offset: Offset(0,2),
                      spreadRadius: 0,
                      blurRadius: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 75,
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 2,
                                    child: CircleAvatar(radius: 37.5,backgroundColor: ColorConstants.blackColor.withOpacity(0.1),)),
                                CircleNetworkImageWidget(imageURL: homeProviderWatch.homeData?.userFavorites?[index].expertProfile ?? '', isNetworkImage: true, key: UniqueKey()),

                              ],
                            ),
                          ),
                          6.0.spaceY,
                          Flexible(
                            child: LabelSmallText(
                              fontSize: 9,
                              title: (homeProviderWatch.homeData?.userFavorites?[index].expertName ?? '').toString().toCapitalizeAllWord(),
                              maxLine: 10,
                              titleTextAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                    ).addPaddingLeft(10),
                  );
                }),
          ),
          20.0.spaceY,
          Center(
            child: LabelSmallText(
              fontSize: 10,
              titleTextAlign: TextAlign.center,
              title: LocaleKeys.seeAllFavoriteExperts.tr().toUpperCase(),
            ),
          ),
        ] else ...[
          10.0.spaceY,
          BodySmallText(
            titleColor: ColorConstants.emptyTextColor,
            fontFamily: FontWeightEnum.w400.toInter,
            maxLine: 4,
            title: LocaleKeys.darnNoFavoriteExperts.tr(),
          ),
        ]
      ],
    );
  }
}
