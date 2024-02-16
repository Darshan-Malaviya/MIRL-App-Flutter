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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(blockUserProvider).getAllBlockListApiCall();
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
          trailingIcon: InkWell(
            // onTap: () => expertRead.updateGenderApi(),
            child: TitleMediumText(
              title: StringConstants.done,
            ).addPaddingRight(14),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.0.spaceY,
            TitleLargeText(
              title: LocaleKeys.blockedUserList.tr(),
              titleColor: ColorConstants.bottomTextColor,
              titleTextAlign: TextAlign.center,
            ),
            40.0.spaceY,
            Column(
              children: List.generate(blockUserWatch.blockUserDetails.length, (index) {
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
                              text: 'USER: ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 13),
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
                              text: 'BLOCKED ON: ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 11),
                              children: [
                                TextSpan(
                                    text: blockUserWatch.blockUserDetails[index].firstCreated ?? '',
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
                              text: 'STATUS: ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 11),
                              children: [
                                TextSpan(
                                    text: blockUserRead.userStatus(index),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: ColorConstants.buttonTextColor,
                                        fontFamily: FontWeightEnum.w400.toInter,
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     BodySmallText(
                          //       title: 'STATUS:',
                          //       titleColor: ColorConstants.buttonTextColor,
                          //       titleTextAlign: TextAlign.center,
                          //       fontSize: 13,
                          //     ),
                          //     5.0.spaceX,
                          //     BodySmallText(
                          //       title: 'PERMANENT / TEMPORARY',
                          //       maxLine: 2,
                          //       titleColor: ColorConstants.buttonTextColor,
                          //       titleTextAlign: TextAlign.center,
                          //       fontSize: 13,
                          //     ),
                          //   ],
                          // ),
                          20.0.spaceY,
                          InkWell(
                            onTap: () {
                              blockUserRead.unBlockUserApiCall(userBlockId: blockUserWatch.blockUserDetails[index].id ?? 0, index: index);
                            },
                            child: BodySmallText(
                              title: 'UNBLOCK USER',
                              titleColor: ColorConstants.buttonTextColor,
                              titleTextAlign: TextAlign.center,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   decoration: BoxDecoration(boxShadow: [
                      //     BoxShadow(
                      //         offset: Offset(2, 4),
                      //         color: ColorConstants.blackColor.withOpacity(0.3),
                      //         spreadRadius: 0,
                      //         blurRadius: 2),
                      //   ], shape: BoxShape.circle),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child: NetworkImageWidget(
                      //       imageURL: blockUserWatch.blockUserDetails[index].userDetail?.userProfile ?? '',
                      //       boxFit: BoxFit.cover,
                      //       height: 90,
                      //       width: 90,
                      //     ),
                      //   ),
                      // ),
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
              }),
            )
          ],
        ).addPaddingX(20),
      ),
    );
  }
}
