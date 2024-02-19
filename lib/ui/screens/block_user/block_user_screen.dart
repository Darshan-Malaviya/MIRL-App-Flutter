import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';

class BlockUserScreen extends ConsumerStatefulWidget {
  final BlockUserArgs args;

  const BlockUserScreen({super.key, required this.args});

  @override
  ConsumerState<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends ConsumerState<BlockUserScreen> {
  @override
  Widget build(BuildContext context) {
    final blockUserRead = ref.read(blockUserProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.0.spaceY,
            HeadlineMediumText(
              title: LocaleKeys.blockedUser.tr(),
              titleColor: ColorConstants.bottomTextColor,
              titleTextAlign: TextAlign.center,
              fontSize: 30,
            ),
            10.0.spaceY,
            BodySmallText(
              title: LocaleKeys.contactingUser.tr(),
              titleColor: ColorConstants.buttonTextColor,
              maxLine: 2,
              fontFamily: FontWeightEnum.w600.toInter,
              titleTextAlign: TextAlign.center,
            ),
            BodySmallText(
              title: LocaleKeys.notified.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontFamily: FontWeightEnum.w400.toInter,
            ),
            40.0.spaceY,
            ShadowContainer(
              isShadow: false,
              borderColor: ColorConstants.dropDownBorderColor,
              backgroundColor: ColorConstants.yellowButtonColor,
              border: 5,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        softWrap: true,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'USER: ',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, fontSize: 13),
                          children: [
                            TextSpan(
                                text: widget.args.userName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: ColorConstants.buttonTextColor, fontSize: 13)),
                          ],
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
                          radius: 50, imageURL: widget.args.imageURL ?? '', isNetworkImage: true, key: UniqueKey())),
                ],
              ),
            ),
            80.0.spaceY,
            PrimaryButton(
              title: LocaleKeys.temporaryBlock.tr(),
              onPressed: () {
                CommonAlertDialog.dialog(
                    context: context,
                    width: 300,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BodyLargeText(
                          title: LocaleKeys.userTemporarilyBlocked.tr(),
                          fontFamily: FontWeightEnum.w600.toInter,
                          titleColor: ColorConstants.bottomTextColor,
                          fontSize: 17,
                          titleTextAlign: TextAlign.center,
                        ),
                        20.0.spaceY,
                        BodyLargeText(
                          title: LocaleKeys.theUserHasBeenSuccessfullyBlockedFromContacting.tr(),
                          maxLine: 5,
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleColor: ColorConstants.blackColor,
                          titleTextAlign: TextAlign.center,
                        ),
                        30.0.spaceY,
                        InkWell(
                          onTap: () {
                            blockUserRead.userBlockRequestCall(Status: 1, UserBlockId: widget.args.userId ?? 0);
                            context.toPop();
                          },
                          child: Center(
                              child: BodyLargeText(
                            title: LocaleKeys.ok.tr(),
                            fontFamily: FontWeightEnum.w500.toInter,
                            titleColor: ColorConstants.bottomTextColor,
                            fontSize: 17,
                            titleTextAlign: TextAlign.center,
                          )).addMarginTop(20),
                        )
                      ],
                    ));
                //context.toPushNamed(RoutesConstants.notificationScreen);
              },
              fontSize: 13,
            ),
            10.0.spaceY,
            BodySmallText(
              title: LocaleKeys.timePeriod.tr(),
              fontFamily: FontWeightEnum.w400.toInter,
              titleColor: ColorConstants.buttonTextColor,
              maxLine: 2,
              titleTextAlign: TextAlign.center,
            ),
            60.0.spaceY,
            PrimaryButton(
              title: LocaleKeys.permanentBlock.tr(),
              onPressed: () {
                // context.toPushNamed(RoutesConstants.blockUserListScreen);
                blockUserRead.userBlockRequestCall(Status: 2, UserBlockId: widget.args.userId ?? 0);
              },
              fontSize: 13,
            ),
            10.0.spaceY,
            BodySmallText(
              title: LocaleKeys.permanentlyBlock.tr(),
              fontFamily: FontWeightEnum.w400.toInter,
              titleColor: ColorConstants.buttonTextColor,
              maxLine: 2,
              titleTextAlign: TextAlign.center,
            ),
            50.0.spaceY,
            InkWell(
              onTap: () {
                context.toPushNamed(RoutesConstants.reportUserScreen,
                    args: BlockUserArgs(userRole: 2, reportName: 'REPORT THIS USER'));
              },
              child: BodySmallText(
                title: LocaleKeys.reportUser.tr(),
                titleColor: ColorConstants.darkRedColor,
                titleTextAlign: TextAlign.center,
                fontSize: 13,
              ),
            ),
            40.0.spaceY,
            InkWell(
              onTap: () {
                context.toPushNamed(RoutesConstants.blockUserListScreen);
              },
              child: BodySmallText(
                title: LocaleKeys.blockedUsers.tr(),
                fontFamily: FontWeightEnum.w600.toInter,
                titleColor: ColorConstants.buttonTextColor,
                titleTextAlign: TextAlign.center,
              ),
            ),
            40.0.spaceY,
          ],
        ).addPaddingX(20),
      ),
    );
  }
}
