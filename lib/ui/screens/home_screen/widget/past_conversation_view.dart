import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
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
        BodyLargeText(
          title: LocaleKeys.yourPastConversations.tr(),
        ),
        if(homeProviderWatch.homeData?.lastConversionList?.isNotEmpty ?? false)...[
          20.0.spaceY,
          SizedBox(
            height: 130,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 37.5,
                            backgroundImage: NetworkImage(
                                homeProviderWatch.homeData?.lastConversionList?[index].expertProfile ?? ''),
                          ),
                          10.0.spaceY,
                          LabelSmallText(
                            fontSize: 9,
                            title: homeProviderWatch.homeData?.lastConversionList?[index].expertName ?? '',
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

