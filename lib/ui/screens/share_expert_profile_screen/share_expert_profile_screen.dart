import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:qr_flutter/qr_flutter.dart';

class shareExpertProfileScreen extends ConsumerStatefulWidget {
  const shareExpertProfileScreen({super.key});

  @override
  ConsumerState<shareExpertProfileScreen> createState() => _shareExpertProfileScreenState();
}

class _shareExpertProfileScreenState extends ConsumerState<shareExpertProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: ColorConstants.whiteColor,
            shadows: [
              BoxShadow(color: ColorConstants.blackColor.withOpacity(0.25), blurRadius: 4, offset: Offset(0, 0), spreadRadius: 1),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: QrImageView(
            data: 'This is a simple QR code',
            size: 150,
            gapless: false,
            version: QrVersions.auto,
            // errorStateBuilder: (cxt, err) {
            //   return Container(
            //     child: Center(
            //       child: Text(
            //         'Uh oh! Something went wrong...',
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //   );
            // },
          ).addAllPadding(14),
        ),
        40.0.spaceY,
        Container(
          height: 100,
          width: double.infinity,
          //     color: ColorConstants.callRequestColor,
          decoration: ShapeDecoration(
            color: ColorConstants.callRequestColor,
            shadows: [
              BoxShadow(color: ColorConstants.blackColor.withOpacity(0.20), blurRadius: 2, offset: Offset(3, 3), spreadRadius: 0),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            decoration: ShapeDecoration(
              color: ColorConstants.yellowLightColor,
              shadows: [
                BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 2, offset: Offset(0, 2), spreadRadius: 0),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BodySmallText(
                  title: 'MIRL ME',
                  titleColor: ColorConstants.textColor,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 1,
                      color: ColorConstants.blackColor.withOpacity(0.25),
                    ),
                  ],
                ),
                TitleMediumText(
                  title: '@Vaidehi',
                  fontSize: 18,
                  titleColor: ColorConstants.textColor,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 1,
                      color: ColorConstants.blackColor.withOpacity(0.25),
                    ),
                  ],
                ),
                Image.asset(ImageConstants.mirlIcon)
              ],
            ).addMarginX(10),
          ).addMarginXY(marginX: 30, marginY: 20),
        ),
        20.0.spaceY,
        Container(
          height: 100,
          width: double.infinity,
          decoration: ShapeDecoration(
            color: ColorConstants.callRequestColor,
            shadows: [
              BoxShadow(color: Color(0x33000000), blurRadius: 2, offset: Offset(3, 3), spreadRadius: 0),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: ShapeDecoration(
                  color: ColorConstants.yellowLightColor,
                  shadows: [
                    BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 2, offset: Offset(0, 2), spreadRadius: 0),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodySmallText(
                      title: LocaleKeys.shareProfile.tr(),
                      fontSize: 11,
                      titleColor: ColorConstants.textColor,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: ColorConstants.blackColor.withOpacity(0.25),
                        ),
                      ],
                    ),
                    30.0.spaceX,
                    Image.asset(ImageConstants.shareProfile)
                  ],
                ).addMarginXY(marginX: 10, marginY: 16),
              ).addAllPadding(20),
              Container(
                decoration: ShapeDecoration(
                  color: ColorConstants.yellowLightColor,
                  shadows: [
                    BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 2, offset: Offset(0, 2), spreadRadius: 0),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodySmallText(
                      title: LocaleKeys.copyLink.tr(),
                      titleColor: ColorConstants.textColor,
                      fontSize: 11,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: ColorConstants.blackColor.withOpacity(0.25),
                        ),
                      ],
                    ),
                    30.0.spaceX,
                    Image.asset(ImageConstants.copyLink)
                  ],
                ).addMarginXY(marginX: 10, marginY: 16),
              ).addAllPadding(20)
            ],
          ),
        ),
      ],
    ).addAllPadding(20);
  }
}
