import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
        bool isLoading = ref
            .watch(blockUserProvider)
            .reachedCategoryLastPage;
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
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        30.0.spaceY,
        TitleLargeText(
          title: LocaleKeys.blockedUserList.tr(),
          titleColor: ColorConstants.bottomTextColor,
          titleTextAlign: TextAlign.center,
        ),
        40.0.spaceY,
        Expanded(
          child: blockUserWatch.isLoading
              ? Center(
            child: CupertinoActivityIndicator(radius: 16, color: ColorConstants.primaryColor),
          )
              : blockUserWatch.blockUserDetails.isNotEmpty
              ? ListView.builder(
              controller: scrollController,
              itemCount: (blockUserWatch.blockUserDetails.length) + (blockUserWatch.reachedCategoryLastPage ? 0 : 1),
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
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                  color: ColorConstants.buttonTextColor,
                                  fontFamily: FontWeightEnum.w400.toInter,
                                  fontSize: 13),
                              children: [
                                WidgetSpan(child: 2.0.spaceX),
                                TextSpan(
                                    text: blockUserWatch.blockUserDetails[index].userDetail?.userName?.toUpperCase() ??
                                        LocaleKeys.anonymous.tr().toUpperCase(),
                                    style: Theme
                                        .of(context)
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
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                  color: ColorConstants.buttonTextColor,
                                  fontFamily: FontWeightEnum.w400.toInter,
                                  fontSize: 11),
                              children: [
                                WidgetSpan(child: 2.0.spaceX),
                                TextSpan(
                                    text: blockUserWatch.blockUserDetails[index].firstCreated
                                        ?.toLocalFullDateWithoutSuffix()?.toUpperCase() ??
                                        '',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
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
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                  color: ColorConstants.buttonTextColor,
                                  fontFamily: FontWeightEnum.w400.toInter,
                                  fontSize: 11),
                              children: [
                                WidgetSpan(child: 2.0.spaceX),
                                TextSpan(
                                    text: blockUserRead.userStatus(index),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w400.toInter,
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                          20.0.spaceY,
                          InkWell(
                            onTap: () {
                              CommonAlertDialog.dialog(
                                  width: 290,
                                  context: context,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BodyLargeText(
                                        title: LocaleKeys.unblock.tr(),
                                        fontFamily: FontWeightEnum.w600.toInter,
                                        titleColor: ColorConstants.bottomTextColor,
                                        fontSize: 17,
                                        titleTextAlign: TextAlign.center,
                                      ),
                                      30.0.spaceY,
                                      BodyLargeText(
                                        title: LocaleKeys.unBlockThisUser.tr(),
                                        maxLine: 4,
                                        fontFamily: FontWeightEnum.w400.toInter,
                                        titleColor: ColorConstants.blackColor,
                                        titleTextAlign: TextAlign.center,
                                      ),
                                      40.0.spaceY,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              blockUserRead.unBlockUserApiCall(
                                                  userBlockId: blockUserWatch.blockUserDetails[index].userDetail?.id ?? 0,
                                                  index: index);
                                              context.toPop();
                                            },
                                            child: BodyMediumText(
                                              title: LocaleKeys.yes.tr().toUpperCase(),
                                              fontFamily: FontWeightEnum.w500.toInter,
                                              titleColor: ColorConstants.bottomTextColor,
                                              titleTextAlign: TextAlign.center,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => context.toPop(),
                                            child: BodyMediumText(
                                              title: LocaleKeys.no.tr().toUpperCase(),
                                              fontFamily: FontWeightEnum.w500.toInter,
                                              titleColor: ColorConstants.bottomTextColor,
                                              titleTextAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ).addPaddingX(10)
                                    ],
                                  ));
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
              : Column(
            children: [
              60.0.spaceY,
              Image.asset(ImageConstants.blockedUser),
              Center(
                child: HeadlineSmallText(
                  title: LocaleKeys.soFarYouHaveNotBlockedAnyUsers.tr(),
                  titleColor: ColorConstants.bottomTextColor,
                  titleTextAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                  maxLine: 3,
                ),
              ),
            ],
          ),
        ),
      ]).addPaddingX(20),
    );
  }
}
