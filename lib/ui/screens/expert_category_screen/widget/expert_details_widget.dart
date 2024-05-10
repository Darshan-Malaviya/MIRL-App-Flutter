import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/string_extention.dart';
import 'package:mirl/infrastructure/models/common/expert_data_model.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';
import 'package:mirl/ui/screens/call_feedback_screen/arguments/call_feddback_arguments.dart';

class ExpertDetailWidget extends StatelessWidget {
  final ExpertData? expertData;
  final bool fromMultiConnect;

  const ExpertDetailWidget({super.key, required this.expertData, this.fromMultiConnect = false});

  @override
  Widget build(BuildContext context) {
    String? fee;
    if (expertData?.fee != null) {
      double data = (expertData?.fee?.toDouble() ?? 0.0) / 100;
      fee = data.toStringAsFixed(2);
    }
    return ShadowContainer(
      width: double.infinity,
      shadowColor: ColorConstants.blackColor.withOpacity(0.3),
      offset: Offset(2, 2),
      border: 15,
      spreadRadius: 0,
      blurRadius: 1,
      padding: EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          context.toPushNamed(
            RoutesConstants.expertDetailScreen,
            args: CallFeedBackArgs(expertId: expertData?.id.toString(), callType: ''),
          );
        },
        child: Stack(
          children: [
            NetworkImageWidget(
              imageURL: expertData?.expertProfile ?? '',
              isNetworkImage: true,
              height: 240,
              width: double.infinity,
              boxFit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                200.0.spaceY,
                Center(
                  child: ShadowContainer(
                    border: 20,
                    shadowColor: ColorConstants.borderColor,
                    offset: Offset(0, 3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: BodyLargeText(title: expertData?.expertName?.toUpperCase() ?? '',maxLine: 2,titleTextAlign: TextAlign.center,)),
                        8.0.spaceY,
                        if (expertData?.expertCategory?.isNotEmpty ?? false) ...[
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 0,
                            children: List.generate(((expertData?.expertCategory?.length ?? 0) > 7) ? 6 : expertData?.expertCategory?.length ?? 0, (i) {
                              String color = expertData?.expertCategory?[i].colorCode?.substring(1) ?? "D97CF0";
                              int colorConcat = int.parse('0xff$color');
                              return Container(
                                color: Color(colorConcat),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                child: BodyMediumText(
                                  title: expertData?.expertCategory?[i].name.toString().toLowerCase().toCapitalizeAllWord() ?? '',
                                  fontFamily: FontWeightEnum.w500.toInter,
                                ),
                              );
                            }),
                          )
                        ]
                      ],
                    ).addAllPadding(10),
                  ),
                ),
                28.0.spaceY,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        BodySmallText(
                          title: LocaleKeys.overAllRating.tr(),
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleTextAlign: TextAlign.center,
                        ),
                        10.0.spaceX,
                        AutoSizeText(
                          expertData?.overAllRating != 0 && expertData?.overAllRating != null
                              ? expertData?.overAllRating?.toString() ?? '' : LocaleKeys.newText.tr(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: ColorConstants.bottomTextColor,
                            shadows: [
                              Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))
                            ],
                          ),
                        )
                      ],
                    ),
                    20.0.spaceX,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodySmallText(
                          title: LocaleKeys.feesPerMinute.tr(),
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleTextAlign: TextAlign.center,
                        ),
                        10.0.spaceX,
                        AutoSizeText(
                          //fee != null || expertData?.fee != 0? '\$${fee}' : LocaleKeys.proBono.tr(),
                         expertData?.fee != 0 ?'\$${fee}' :LocaleKeys.proBono.tr(),
                          maxLines: 2,
                            textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: ColorConstants.bottomTextColor,
                            shadows: [
                              Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                16.0.spaceY,
                Align(alignment: Alignment.centerLeft, child: BodySmallText(title: StringConstants.aboutMe)),
                5.0.spaceY,
                ReadMoreText(
                  style: TextStyle(fontSize: 14, fontFamily: FontWeightEnum.w400.toInter),
                  expertData?.about ?? '',
                  trimLines: 5,
                  trimMode: TrimMode.Line,
                  textAlign: TextAlign.start,
                  trimCollapsedText: LocaleKeys.readMore.tr(),
                  trimExpandedText: ' ${LocaleKeys.readLess.tr()}',
                  moreStyle: TextStyle(fontSize: 12, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                  lessStyle: TextStyle(fontSize: 12, color: ColorConstants.bottomTextColor.withOpacity(0.7)),
                ),
                fromMultiConnect ? 20.0.spaceY : 0.0.spaceY,
              ],
            )
          ],
        ),
      ),
    );
  }
}
