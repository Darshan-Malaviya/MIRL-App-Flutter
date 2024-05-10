import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';

class SeeAllFavoriteExpertsListViewScreen extends ConsumerStatefulWidget {
  const SeeAllFavoriteExpertsListViewScreen({super.key});

  @override
  ConsumerState<SeeAllFavoriteExpertsListViewScreen> createState() => _SeeAllFavoriteExpertsListViewScreenState();
}

class _SeeAllFavoriteExpertsListViewScreenState extends ConsumerState<SeeAllFavoriteExpertsListViewScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(homeProvider).favoriteExpertsListApiCall(isFullScreenLoader: true);
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(homeProvider).reachedCategoryLastPage;
        if (!isLoading) {
          await ref.read(homeProvider).favoriteExpertsListApiCall();
        } else {
          log('reach last page on get favorite experts list api');
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
          appTitle: TitleLargeText(
            title: LocaleKeys.yourFavoriteExperts.tr(),
            maxLine: 2,
            titleTextAlign: TextAlign.center,
          ),
          //appBarColor: ColorConstants.greyLightColor,
        ),
        body: favoriteExpertsWatch.isLoading
            ? Center(
          child: CupertinoActivityIndicator(
            animating: true,
            color: ColorConstants.primaryColor,
            radius: 16,
          ),
        )
            : SingleChildScrollView(
          controller: scrollController,
              child: Column(
                children: [
                  if (favoriteExpertsWatch.expertsFavoriteList?.isNotEmpty ?? false) ...[
                  LabelSmallText(
                    title: LocaleKeys.networkOfExpertise.tr(),
                    titleTextAlign: TextAlign.center,
                    fontFamily: FontWeightEnum.w400.toInter,
                    maxLine: 2,
                  ),
                  20.0.spaceY,
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
                    child: BodyMediumText(
                      title: LocaleKeys.noResultFound.tr(),
                      fontFamily: FontWeightEnum.w600.toInter,
                      titleTextAlign: TextAlign.center,
                      maxLine: 2,
                    ),
                  )
                  ]
                ],
              ).addAllPadding(20),
            )
      ),
    );
  }
}
