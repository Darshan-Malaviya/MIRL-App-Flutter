import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';

class SeeAllLastConversationListViewScreen extends ConsumerStatefulWidget {
  const SeeAllLastConversationListViewScreen({super.key});

  @override
  ConsumerState<SeeAllLastConversationListViewScreen> createState() => _SeeAllLastConversationListViewScreenState();
}

class _SeeAllLastConversationListViewScreenState extends ConsumerState<SeeAllLastConversationListViewScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(homeProvider).lastConversationListListApiCall(isFullScreenLoader: true);
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(homeProvider).reachedCategoryLastPage;
        if (!isLoading) {
          await ref.read(homeProvider).lastConversationListListApiCall();
        } else {
          log('reach last page on get last conversation experts list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteExpertsWatch = ref.watch(homeProvider);
    return PopScope(
      child: Scaffold(
          backgroundColor: ColorConstants.greyLightColor,
          appBar: AppBarWidget(
            appBarColor: ColorConstants.greyLightColor,
            leading: InkWell(
                child: Image.asset(ImageConstants.backIcon),
                onTap: () {
                  context.toPop();
                }),
          ),
          body: favoriteExpertsWatch.isLoading
              ? Center(
                  child: SpinKitChasingDots(
                    color: ColorConstants.primaryColor,
                    size: 50.0,
                  ),
                )
              : SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      TitleLargeText(
                        title: LocaleKeys.pastConversations.tr(),
                        maxLine: 2,
                        titleTextAlign: TextAlign.center,
                      ),
                      20.0.spaceY,
                      TitleSmallText(
                        title: LocaleKeys.findPastConversations.tr(),
                        fontFamily: FontWeightEnum.w400.toInter,
                        titleTextAlign: TextAlign.center,
                        maxLine: 4,
                      ),
                      20.0.spaceY,
                      if (favoriteExpertsWatch.expertsFavoriteList?.isNotEmpty ?? false) ...[
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            // padding: EdgeInsets.all(20),
                            // padding: EdgeInsets.only(right: 20,left: 20),
                            itemBuilder: (context, i) {
                              if (i == (favoriteExpertsWatch.expertsFavoriteList?.length ?? 0) &&
                                  (favoriteExpertsWatch.expertsFavoriteList?.isNotEmpty ?? false)) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                                );
                              }
                              return ExpertDetailWidget(
                                expertData: favoriteExpertsWatch.expertsFavoriteList?[i],
                              );
                            },
                            separatorBuilder: (context, index) => 30.0.spaceY,
                            itemCount: (favoriteExpertsWatch.expertsFavoriteList?.length ?? 0) +
                                (favoriteExpertsWatch.reachedCategoryLastPage ? 0 : 1)),
                        20.0.spaceY
                      ] else ...[
                        Center(
                          child: Column(
                            children: [
                              BodySmallText(
                                title: LocaleKeys.noResultFound.tr(),
                                fontFamily: FontWeightEnum.w600.toInter,
                              ),
                              20.0.spaceY,
                              BodySmallText(
                                title: LocaleKeys.tryWideningYourSearch.tr(),
                                fontFamily: FontWeightEnum.w400.toInter,
                                titleTextAlign: TextAlign.center,
                                maxLine: 5,
                              ),
                            ],
                          ).addMarginX(40),
                        )
                      ]
                    ],
                  ).addMarginX(20),
                )),
    );
  }
}
