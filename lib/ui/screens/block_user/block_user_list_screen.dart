import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class BlockUserListScreen extends ConsumerStatefulWidget {
  const BlockUserListScreen({super.key});

  @override
  ConsumerState<BlockUserListScreen> createState() => _BlockUserListScreenState();
}

class _BlockUserListScreenState extends ConsumerState<BlockUserListScreen> {
  @override
  Widget build(BuildContext context) {
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
            60.0.spaceY,
            ShadowContainer(
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
                                text: 'PREETI',
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
                                text: '26 NOVEMBER 2023',
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
                                text: 'PERMANENT / TEMPORARY',
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
                      BodySmallText(
                        title: 'UNBLOCK USER',
                        titleColor: ColorConstants.buttonTextColor,
                        titleTextAlign: TextAlign.center,
                        fontSize: 13,
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
                        height: 90,
                        width: 90,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).addPaddingX(20),
      ),
    );
  }
}
