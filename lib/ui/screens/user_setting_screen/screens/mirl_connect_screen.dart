import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import '../../../../infrastructure/commons/constants/storage_constants.dart';
import '../widget/activate_your_mirl_connect_code_widget.dart';
import '../widget/get_your_own_mirl_connect_code_widget.dart';
import '../widget/your_mirl_connect_code_widget.dart';

class MirlConnectScreen extends ConsumerStatefulWidget {
  final String? args;

  const MirlConnectScreen({super.key, this.args});

  @override
  ConsumerState<MirlConnectScreen> createState() => _MirlConnectScreenState();
}

class _MirlConnectScreenState extends ConsumerState<MirlConnectScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    mirlConnectView.value = 0;
    // bool isReferralDone =
    //     SharedPrefHelper.getBool(StorageConstants.isReferralDone);
    String isAvailableReferralCode = SharedPrefHelper.getString(StorageConstants.myReferralCode);
    if (isAvailableReferralCode != "") {
      mirlConnectView.value = 2;
    } else {
      if (widget.args != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          final mirlConnectWatch = ref.watch(mirlConnectProvider);
          mirlConnectWatch.friendReferralCodeController.clear();
          mirlConnectWatch.friendReferralCodeController.text = widget.args!;
          mirlConnectView.value = 1;
        });
      } else {
        mirlConnectView.value = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purpleDarkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    ImageConstants.mirlConnect,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: InkWell(
                      child: Image.asset(ImageConstants.backIcon, color: Colors.white),
                      onTap: () => context.toPop(),
                    ),
                  ).addMarginXY(marginX: 20, marginY: 40),
                ],
              ),
              Container(
                color: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.whiteColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: ColorConstants.mirlConnectShadowColor.withOpacity(0.50),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TitleSmallText(
                          title: LocaleKeys.unlimitedInvites.tr(),
                          titleColor: ColorConstants.blackColor,
                          fontFamily: FontWeightEnum.w600.toInter,
                        ),
                        ValueListenableBuilder(
                          valueListenable: mirlConnectView,
                          builder: (context, value, child) {
                            if (mirlConnectView.value == 2) {
                              Future.delayed(Duration(milliseconds: 400), () {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              });
                            }

                            if (mirlConnectView.value == 0) {
                              return ActivateYourMirlConnectCodeWidget();
                            } else if (mirlConnectView.value == 1) {
                              return GetYourOwnMirlConnectCodeWidget();
                            }
                            return YourMirlConnectCodeWidget();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
