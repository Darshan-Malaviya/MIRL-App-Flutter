import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/string_extention.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';
import 'package:mirl/ui/screens/call_feedback_screen/arguments/call_feddback_arguments.dart';

class PastConversationsView extends ConsumerStatefulWidget {
  const PastConversationsView({super.key});
  @override
  ConsumerState<PastConversationsView> createState() => _PastConversationsViewState();
}

class _PastConversationsViewState extends ConsumerState<PastConversationsView> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLargeText(
          fontSize: 18,
          title: LocaleKeys.yourPastConversations.tr(),
        ),
        if(homeProviderWatch.homeData?.lastConversionList?.isNotEmpty ?? false)...[
          20.0.spaceY,
          SizedBox(
            height: 135,
            child: ListView.builder(
                itemCount: homeProviderWatch.homeData?.lastConversionList?.length ?? 0,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.toPushNamed(RoutesConstants.expertDetailScreen,
                          args: CallFeedBackArgs(expertId: homeProviderWatch.homeData?.lastConversionList?[index].id.toString(),
                              callType: ''));
                    },
                    child: ShadowContainer(
                      padding: EdgeInsets.only(bottom: 8, top: 4, left: 8, right: 8),
                      shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                      width: 96,
                      height: 130,
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
                                    child: CircleAvatar(
                                      radius: 37.5,
                                      backgroundColor: ColorConstants.blackColor.withOpacity(0.2),
                                    )),
                                CircleNetworkImageWidget(
                                    imageURL: homeProviderWatch.homeData?.lastConversionList?[index].expertProfile ?? ''),
                              ],
                            ),
                          ),
                          6.0.spaceY,
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding:   EdgeInsets.symmetric(horizontal: 5.0),
                                child: LabelSmallText(
                                  title: (homeProviderWatch.homeData?.lastConversionList![index].expertName?.toCapitalizeAllWord() ?? '').toString(),
                                  fontSize: 12,
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
          10.0.spaceY,
          InkWell(
            onTap: () {
              context.toPushNamed(RoutesConstants.seeAllLastConversationListViewScreen);
            },
            child: Center(
              child: TitleMediumText(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                titleTextAlign: TextAlign.center,
                title: LocaleKeys.seeAllPastConversations.tr().toUpperCase(),
              ),
            ),
          ),
        ] else
          ...[
            10.0.spaceY,
            BodySmallText(
              titleColor: ColorConstants.emptyTextColor,
              fontFamily: FontWeightEnum.w400.toInter,
              maxLine: 2,
              title: LocaleKeys.cricketsTalkToSomeone.tr(),
            ),
          ]
      ],
    );
  }
}

