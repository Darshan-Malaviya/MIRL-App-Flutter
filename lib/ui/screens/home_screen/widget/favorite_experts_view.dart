import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/string_extention.dart';
import 'package:mirl/infrastructure/models/response/home_data_response_model.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';
import 'package:mirl/ui/screens/call_feedback_screen/arguments/call_feddback_arguments.dart';

class FavoriteExpertsView extends ConsumerWidget {
  const FavoriteExpertsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: favoriteListNotifier,
      builder: (BuildContext context, List<UserFavorites> value, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleLargeText(
              title: LocaleKeys.yourFavoriteExperts.tr(),
              fontSize: 18,
            ),

            if ((favoriteListNotifier.value.isNotEmpty)) ...[
              20.0.spaceY,
              SizedBox(
                height: 135,
                child: ListView.builder(
                    itemCount: favoriteListNotifier.value.length,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.toPushNamed(RoutesConstants.expertDetailScreen, args: CallFeedBackArgs(expertId: favoriteListNotifier.value[index].id.toString(),callType: ''));
                        },
                        child: ShadowContainer(
                            padding: EdgeInsets.only(bottom: 5, top: 4, left: 8, right: 8),
                            shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                            width: 96,
                            height: 130,
                            isShadow: true,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                            blurRadius: 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 2,
                                          child: CircleAvatar(
                                            radius: 37.5,
                                            backgroundColor: ColorConstants.blackColor.withOpacity(0.2),
                                          )),
                                      CircleNetworkImageWidget(
                                          imageURL: favoriteListNotifier.value[index].expertProfile ?? '', isNetworkImage: true, key: UniqueKey()),
                                    ],
                                  ),
                                ),
                                5.0.spaceY,
                                Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: LabelSmallText(
                                        fontSize: 13,
                                        title: (favoriteListNotifier.value[index].expertName?.toCapitalizeAllWord() ?? '').toString(),
                                        maxLine: 5,
                                        titleTextAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).addPaddingLeft(10),
                        );
                    }),
              ),
              20.0.spaceY,
              InkWell(
                onTap: (){
                  context.toPushNamed(RoutesConstants.seeAllFavoriteExpertsListViewScreen);
                },
                child: Center(
                  child: LabelSmallText(
                    fontSize: 10,
                    titleTextAlign: TextAlign.center,
                    title: LocaleKeys.seeAllFavoriteExperts.tr().toUpperCase(),
                  ),
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
    );
  }
}
