import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/string_extention.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';

class FavoriteExpertsView extends ConsumerStatefulWidget {
  const FavoriteExpertsView({super.key});

  @override
  ConsumerState<FavoriteExpertsView> createState() => _FavoriteExpertsViewState();
}

class _FavoriteExpertsViewState extends ConsumerState<FavoriteExpertsView> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodySmallText(
          title: LocaleKeys.yourFavoriteExperts.tr(),
          titleColor: ColorConstants.blackColor,
          fontFamily: FontWeightEnum.w700.toInter,
          titleTextAlign: TextAlign.center,
        ),
        20.0.spaceY,
        if ((homeProviderWatch.homeData?.userFavorites?.isNotEmpty ?? false) &&
            homeProviderWatch.homeData?.userFavorites != null) ...[
          SizedBox(
            height: 120,
            child: ListView.builder(
                itemCount: homeProviderWatch.homeData?.userFavorites?.length ?? 0,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ShadowContainer(
                      padding: EdgeInsets.only(bottom: 8, top: 4, left: 8, right: 8),
                      shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleNetworkImageWidget(imageURL : homeProviderWatch.homeData?.userFavorites?[index].expertProfile ?? '',
                            isNetworkImage: true,
                            key: UniqueKey()),
                          10.0.spaceY,
                          LabelSmallText(
                            fontSize: 9,
                            title:(homeProviderWatch.homeData?.userFavorites?[index].expertName ?? 'name').toString().toCapitalizeAllWord(),
                            maxLine: 2,
                            titleColor: ColorConstants.blackColor,
                            fontFamily: FontWeightEnum.w700.toInter,
                            titleTextAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      width: 96,
                      height: 116,
                      isShadow: true,
                    ).addPaddingLeft(10),
                  );
                }),
          ),
          10.0.spaceY,
          Center(
            child: TitleMediumText(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              titleTextAlign: TextAlign.center,
              title: LocaleKeys.seeAllFavoriteExperts.tr().toUpperCase(),
            ),
          ),
        ] else ...[
          Center(
            child: BodySmallText(
              fontWeight: FontWeight.w400,
              titleTextAlign: TextAlign.start,
              maxLine: 4,
              title: LocaleKeys.darnNoFavoriteExperts.tr(),
            ),
          ),
        ]
      ],
    );
  }
}
