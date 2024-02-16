import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class BlockUserScreen extends ConsumerStatefulWidget {
  final String userTitleName;

  const BlockUserScreen({super.key, this.userTitleName = 'User: '});

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
              borderColor: ColorConstants.borderColor,
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
                          text: widget.userTitleName.toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: ColorConstants.buttonTextColor,
                                fontFamily: FontWeightEnum.w400.toInter,
                              ),
                          children: [
                            TextSpan(
                                text: 'PREETI',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor)),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: NetworkImageWidget(
                        imageURL:
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        boxFit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            80.0.spaceY,
            PrimaryButton(
              title: LocaleKeys.temporaryBlock.tr(),
              onPressed: () {
                CommonAlertDialog.dialog(
                    context: context,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BodyLargeText(
                          title: 'User Temporarily Blocked!',
                          fontFamily: FontWeightEnum.w600.toInter,
                          titleColor: ColorConstants.bottomTextColor,
                          fontSize: 17,
                          titleTextAlign: TextAlign.center,
                        ),
                        20.0.spaceY,
                        BodyLargeText(
                          title: 'The user has been successfully blocked from contacting you, as per your request.',
                          maxLine: 5,
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleColor: ColorConstants.blackColor,
                          titleTextAlign: TextAlign.center,
                        ),
                        30.0.spaceY,
                        InkWell(
                          onTap: () {
                            blockUserRead.userBlockRequestCall(Status: 1);
                            context.toPop();
                          },
                          child: Center(
                              child: BodyLargeText(
                            title: 'OK',
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
                blockUserRead.userBlockRequestCall(Status: 2);
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
                context.toPushNamed(RoutesConstants.reportUserScreen);
              },
              child: BodySmallText(
                title: LocaleKeys.reportUser.tr(),
                titleColor: ColorConstants.darkRedColor,
                titleTextAlign: TextAlign.center,
                fontSize: 13,
              ),
            ),
            40.0.spaceY,
            BodySmallText(
              title: LocaleKeys.blockedUsers.tr(),
              fontFamily: FontWeightEnum.w600.toInter,
              titleColor: ColorConstants.buttonTextColor,
              titleTextAlign: TextAlign.center,
            ),
            40.0.spaceY,
          ],
        ).addPaddingX(20),
      ),
    );
  }
}
