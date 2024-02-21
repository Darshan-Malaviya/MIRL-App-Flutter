import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';

class BlockUserListScreen extends ConsumerStatefulWidget {
  const BlockUserListScreen({super.key});

  @override
  ConsumerState<BlockUserListScreen> createState() => _BlockUserListScreenState();
}

class _BlockUserListScreenState extends ConsumerState<BlockUserListScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(blockUserProvider).getAllBlockListApiCall(isFullScreenLoader: true);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(blockUserProvider).reachedCategoryLastPage;
        if (!isLoading) {
          await ref.read(blockUserProvider).getAllBlockListApiCall();
        } else {
          log('reach last page on get block user list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blockUserRead = ref.read(blockUserProvider);
    final blockUserWatch = ref.watch(blockUserProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        /*  trailingIcon: InkWell(
            // onTap: () => expertRead.updateGenderApi(),
            child: TitleMediumText(
              title: StringConstants.done,
            ).addPaddingRight(14),
          )*/
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          30.0.spaceY,
          if (blockUserWatch.blockUserDetails.isNotEmpty) ...[
            TitleLargeText(
              title: LocaleKeys.blockedUserList.tr(),
              titleColor: ColorConstants.bottomTextColor,
              titleTextAlign: TextAlign.center,
            ),
          ],
          if (blockUserWatch.blockUserDetails.length == 0) ...[
            Center(
              child: TitleMediumText(
                title: LocaleKeys.soFarYouHaveNotBlockedAnyUsers.tr(),
                titleColor: ColorConstants.blackColor,
                titleTextAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
                maxLine: 3,
              ),
            ),
          ] else ...[
            40.0.spaceY,
            Expanded(
              child: blockUserWatch.isLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                    )
                  : blockUserWatch.blockUserDetails.isNotEmpty
                      ? ListView.builder(
                          controller: scrollController,
                          itemCount:
                              (blockUserWatch.blockUserDetails.length) + (blockUserWatch.reachedCategoryLastPage ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (index == blockUserWatch.blockUserDetails.length && blockUserWatch.blockUserDetails.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                              );
                            }
                            return ShadowContainer(
                              isShadow: false,
                              borderColor: ColorConstants.borderColor,
                              backgroundColor: ColorConstants.yellowButtonColor,
                              border: 5,
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      15.0.spaceY,
                                      RichText(
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: LocaleKeys.userWith.tr(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: ColorConstants.buttonTextColor,
                                              fontFamily: FontWeightEnum.w400.toInter,
                                              fontSize: 13),
                                          children: [
                                            TextSpan(
                                                text: blockUserWatch.blockUserDetails[index].userDetail?.userName ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(color: ColorConstants.buttonTextColor, fontSize: 13)),
                                          ],
                                        ),
                                      ),
                                      5.0.spaceY,
                                      RichText(
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: LocaleKeys.blockedOn.tr(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: ColorConstants.buttonTextColor,
                                              fontFamily: FontWeightEnum.w400.toInter,
                                              fontSize: 11),
                                          children: [
                                            WidgetSpan(child: 2.0.spaceX),
                                            TextSpan(
                                                text: blockUserWatch.blockUserDetails[index].firstCreated
                                                        ?.toLocalFullDateWithoutSuffix() ??
                                                    '',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      fontSize: 11,
                                                      color: ColorConstants.buttonTextColor,
                                                      fontFamily: FontWeightEnum.w400.toInter,
                                                      overflow: TextOverflow.ellipsis,
                                                    )),
                                          ],
                                        ),
                                      ),
                                      5.0.spaceY,
                                      RichText(
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: LocaleKeys.status.tr(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: ColorConstants.buttonTextColor,
                                              fontFamily: FontWeightEnum.w400.toInter,
                                              fontSize: 11),
                                          children: [
                                            WidgetSpan(child: 2.0.spaceX),
                                            TextSpan(
                                                text: blockUserRead.userStatus(index),
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: ColorConstants.buttonTextColor,
                                                    fontFamily: FontWeightEnum.w400.toInter,
                                                    fontSize: 11)),
                                          ],
                                        ),
                                      ),
                                      20.0.spaceY,
                                      InkWell(
                                        onTap: () {
                                          blockUserRead.unBlockUserApiCall(
                                              userBlockId: blockUserWatch.blockUserDetails[index].id ?? 0, index: index);
                                        },
                                        child: BodySmallText(
                                          title: LocaleKeys.unblockUser.tr(),
                                          titleColor: ColorConstants.buttonTextColor,
                                          titleTextAlign: TextAlign.center,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            offset: Offset(2, 4),
                                            color: ColorConstants.blackColor.withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 2),
                                      ], shape: BoxShape.circle),
                                      child: CircleNetworkImageWidget(
                                          radius: 50,
                                          imageURL: blockUserWatch.blockUserDetails[index].userDetail?.userProfile ?? '',
                                          isNetworkImage: true,
                                          key: UniqueKey())),
                                ],
                              ),
                            ).addMarginY(20);
                          })
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: BodyLargeText(
                              title: StringConstants.noDataFound,
                              fontFamily: FontWeightEnum.w600.toInter,
                            ),
                          ),
                        ),
            ),
          ]
        ],
      ).addPaddingX(20),
    );
  }
}
