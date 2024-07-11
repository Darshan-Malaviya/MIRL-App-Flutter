import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/user_setting_screen/widget/reusable_rich_text.dart';

import '../../../../generated/locale_keys.g.dart';
import '../widget/referral_earning_widget.dart';

class MirlReferralDashboardScreen extends ConsumerStatefulWidget {
  const MirlReferralDashboardScreen({super.key});

  @override
  ConsumerState<MirlReferralDashboardScreen> createState() =>
      _MirlReferralDashboardScreenState();
}

class _MirlReferralDashboardScreenState
    extends ConsumerState<MirlReferralDashboardScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(mirlConnectProvider).referralListApiCall(context: context);
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        ref.read(mirlConnectProvider).isListLoading == false) {
      await ref
          .read(mirlConnectProvider)
          .referralListApiCall(context: context, isFirstTime: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mirlConnectWatch = ref.watch(mirlConnectProvider);

    return Scaffold(
      backgroundColor: ColorConstants.purpleDarkColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Image.asset(ImageConstants.mirlConnect,
                    fit: BoxFit.fitWidth, width: double.infinity),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: InkWell(
                    child: Image.asset(ImageConstants.backIcon,
                        color: Colors.white),
                    onTap: () => context.toPop(),
                  ),
                ).addMarginXY(marginX: 20, marginY: 40),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: mirlConnectWatch.isListLoading == true
                  ? SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.7,
                      width: double.infinity,
                      child: Center(
                        child: CupertinoActivityIndicator(
                            radius: 16, color: ColorConstants.primaryColor),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: HeadlineMediumText(
                            title: LocaleKeys.connect.tr(),
                            fontSize: 30,
                            titleColor: ColorConstants.bottomTextColor,
                            shadow: [
                              Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 4,
                                  color: ColorConstants.mirlConnectShadowColor
                                      .withOpacity(0.50))
                            ],
                          ),
                        ),
                        20.0.spaceY,
                        Center(
                          child: HeadlineSmallText(
                            title: LocaleKeys.referralDashboard.tr(),
                            fontSize: 10,
                            titleColor: ColorConstants.bottomTextColor,
                            shadow: [
                              Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 4,
                                  color: ColorConstants.mirlConnectShadowColor
                                      .withOpacity(0.50))
                            ],
                          ),
                        ),
                        20.0.spaceY,
                        mirlConnectWatch.isListLoading == false &&
                                mirlConnectWatch
                                        .responseModel.data?.reflist?.length ==
                                    0
                            ? SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.5,
                                child: Column(
                                  children: [
                                    100.0.spaceY,
                                    TitleSmallText(
                                      fontFamily: FontWeightEnum.w600.toInter,
                                      fontSize: 13,
                                      title:
                                          LocaleKeys.youHaveNoAnyReferral.tr(),
                                      titleColor: ColorConstants.blackColor,
                                      maxLine: 2,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      20.0.spaceX,
                                      TitleSmallText(
                                        fontFamily: FontWeightEnum.w600.toInter,
                                        fontSize: 13,
                                        title:
                                            LocaleKeys.yourReferralEarning.tr(),
                                        titleColor: ColorConstants.blackColor,
                                        maxLine: 2,
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: mirlConnectWatch.responseModel
                                            .data?.totalAllTime?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return ReferralEarningsWidget(
                                        title: mirlConnectWatch
                                                .responseModel
                                                .data
                                                ?.totalAllTime?[index]
                                                .title ??
                                            "",
                                        earnings:
                                            "\$${mirlConnectWatch.responseModel.data?.totalAllTime?[index].value ?? 0.0}",
                                      );
                                    },
                                  ),
                                  Visibility(
                                    visible: !(mirlConnectWatch.responseModel
                                            .data?.isAdvanceStatus ==
                                        true),
                                    child: PrimaryButton(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      buttonColor: ColorConstants.primaryColor,
                                      title: LocaleKeys.unlockAdvancedDashboard
                                          .tr(),
                                      titleColor: ColorConstants.textColor,
                                      onPressed: () {
                                        if (mirlConnectWatch.responseModel.data
                                                ?.isAdvanceStatus ==
                                            false) {
                                          //show Advanced Dashboard Access dialog
                                          CommonAlertDialog.dialog(
                                              context: context,
                                              width: 300,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  BodyLargeText(
                                                    title: LocaleKeys
                                                        .advancedDashboardAccess
                                                        .tr(),
                                                    fontFamily: FontWeightEnum
                                                        .w600.toInter,
                                                    titleColor: ColorConstants
                                                        .bottomTextColor,
                                                    fontSize: 17,
                                                    titleTextAlign:
                                                        TextAlign.center,
                                                  ),
                                                  20.0.spaceY,
                                                  BodyLargeText(
                                                    title: LocaleKeys
                                                        .inviteMoreFriends
                                                        .tr(),
                                                    maxLine: 5,
                                                    fontFamily: FontWeightEnum
                                                        .w400.toInter,
                                                    titleColor: ColorConstants
                                                        .blackColor,
                                                    titleTextAlign:
                                                        TextAlign.center,
                                                  ),
                                                  30.0.spaceY,
                                                  InkWell(
                                                    onTap: () async {
                                                      await context.toPop();
                                                    },
                                                    child: Center(
                                                        child: BodyLargeText(
                                                      title: LocaleKeys.ok.tr(),
                                                      fontFamily: FontWeightEnum
                                                          .w500.toInter,
                                                      titleColor: ColorConstants
                                                          .bottomTextColor,
                                                      fontSize: 17,
                                                      titleTextAlign:
                                                          TextAlign.center,
                                                    )).addMarginTop(20),
                                                  )
                                                ],
                                              ));
                                        }
                                      },
                                    ),
                                  ),
                                  30.0.spaceY,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      20.0.spaceX,
                                      TitleSmallText(
                                        fontFamily: FontWeightEnum.w600.toInter,
                                        fontSize: 13,
                                        title: LocaleKeys.yourReferrals.tr(),
                                        titleColor: ColorConstants.blackColor,
                                        maxLine: 2,
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: mirlConnectWatch.responseModel
                                                .data?.isAdvanceStatus ==
                                            true
                                        ? mirlConnectWatch.responseModel.data
                                                ?.reflist?.length ??
                                            0
                                        : (mirlConnectWatch.responseModel.data
                                                        ?.reflist?.length ??
                                                    0) <
                                                10
                                            ? mirlConnectWatch.responseModel.data
                                                    ?.reflist?.length ??
                                                0
                                            : 10,
                                    itemBuilder: (context, index) {
                                      final refData = mirlConnectWatch
                                          .responseModel.data?.reflist?[index];
                                      print(refData?.user?.referralDateAt);
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: Offset(1,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 32,
                                                  width: 32,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorConstants
                                                        .yellowButtonColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        spreadRadius: 2,
                                                        blurRadius: 1,
                                                        offset: Offset(1,
                                                            2), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: TitleSmallText(
                                                    fontFamily: FontWeightEnum
                                                        .w600.toInter,
                                                    fontSize: 12,
                                                    title: (index + 1)
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                    titleColor: ColorConstants
                                                        .blackColor,
                                                  ),
                                                ),
                                                20.0.spaceX,
                                                Expanded(
                                                  child: InnerShadow(
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black54,
                                                        blurRadius: 4,
                                                        offset: Offset(1, 1),
                                                      ),
                                                    ],
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: ColorConstants
                                                              .greenColor,
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Colors
                                                                  .black12)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      child: TitleSmallText(
                                                        fontFamily:
                                                            FontWeightEnum
                                                                .w600.toInter,
                                                        fontSize: 13,
                                                        title: refData?.user
                                                                ?.userName ??
                                                            "User Name",
                                                        titleColor:
                                                            ColorConstants
                                                                .blackColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                10.0.spaceX,
                                              ],
                                            ),
                                            Visibility(
                                              visible: mirlConnectWatch
                                                      .responseModel
                                                      .data
                                                      ?.isAdvanceStatus ??
                                                  false,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  15.0.spaceY,
                                                  ReusableRichText(
                                                    labelText:
                                                        "REFERRAL DATE: ",
                                                    valueText: formatDate(refData
                                                            ?.user
                                                            ?.referralDateAt ??
                                                        DateTime.now()),
                                                  ),
                                                  10.0.spaceY,
                                                  ReusableRichText(
                                                    labelText: 'VALIDITY: ',
                                                    valueText:
                                                        refData?.vilidity ?? "",
                                                  ),
                                                  10.0.spaceY,
                                                  ReusableRichText(
                                                    labelText:
                                                        'MONTHLY REFERRAL EARNINGS: ',
                                                    valueText:
                                                        '\$${refData?.refAmount ?? ""}',
                                                  ),
                                                  10.0.spaceY,
                                                  ReusableRichText(
                                                    labelText:
                                                        'LIFETIME REFERRAL EARNINGS: ',
                                                    valueText: '\$25.40',
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  if (mirlConnectWatch.isListLoading==true)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CupertinoActivityIndicator(radius: 16, color: ColorConstants.primaryColor),
                                      ),
                                    ),
                                ],
                              )
                      ],
                    ).addAllPadding(20),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(date);
  }
}
