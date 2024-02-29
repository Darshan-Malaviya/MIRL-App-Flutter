import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/expert_data_model.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';

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
          context.toPushNamed(RoutesConstants.expertDetailScreen, args: expertData?.id.toString());
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
                180.0.spaceY,
                Center(
                  child: ShadowContainer(
                    border: 20,
                    shadowColor: ColorConstants.borderColor,
                    offset: Offset(0, 3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BodyLargeText(title: expertData?.expertName?.toUpperCase() ?? ''),
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
                                child: BodySmallText(
                                  title: expertData?.expertCategory?[i].name ?? '',
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
                        TitleLargeText(
                          title: expertData?.overAllRating != 0 ? expertData?.overAllRating?.toString() ?? '' : LocaleKeys.newText.tr(),
                          titleColor: ColorConstants.bottomTextColor,
                        ),
                      ],
                    ),
                    20.0.spaceX,
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BodySmallText(
                            title: LocaleKeys.feesPerMinute.tr(),
                            fontFamily: FontWeightEnum.w400.toInter,
                            titleTextAlign: TextAlign.center,
                          ),
                          10.0.spaceX,
                          Flexible(
                            child: TitleLargeText(
                              maxLine: 3,
                              title: fee != null ? '\$${fee}' : "",
                              titleColor: ColorConstants.bottomTextColor,
                              titleTextAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.0.spaceY,
                Align(alignment: Alignment.centerLeft, child: BodySmallText(title: StringConstants.aboutMe)),
                5.0.spaceY,
                ReadMoreText(
                  style: TextStyle(fontSize: 12, fontFamily: FontWeightEnum.w400.toInter),
                  expertData?.about ?? '',
                  trimLines: 4,
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
