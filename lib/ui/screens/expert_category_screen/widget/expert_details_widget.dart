import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/expert_data_model.dart';
import 'package:mirl/ui/common/read_more/readmore.dart';

class ExpertDetailWidget extends StatelessWidget {
  final ExpertData? expertData;
  const ExpertDetailWidget({super.key, required this.expertData});

  @override
  Widget build(BuildContext context) {
    String? fee;
    if(expertData?.fee!= null){
       double data = (expertData?.fee?.toDouble() ?? 0.0) / 100;
       fee = data.toStringAsFixed(2);
    }
    return ShadowContainer(
      width: double.infinity,
      shadowColor: ColorConstants.blackColor.withOpacity(0.4),
      offset: Offset(2, 2),
      border: 15,
      spreadRadius: 0,
      blurRadius: 2,
      padding: EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          context.toPushNamed(RoutesConstants.expertDetailScreen,
              args: expertData?.id.toString());
        },
        child: Column(
          children: [
            Stack(
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
                            BodyMediumText(title: expertData?.expertName ?? ''),
                            8.0.spaceY,
                            if (expertData?.expertCategory?.isNotEmpty ?? false) ...[
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 0,
                                children: List.generate(
                                    ((expertData?.expertCategory?.length ?? 0) > 7)
                                        ? 6
                                        : expertData?.expertCategory?.length ?? 0, (i) {
                                  String color = expertData?.expertCategory?[i].colorCode?.substring(1) ?? "D97CF0";
                                  int colorConcat = int.parse('0xff$color');

                                  return Container(
                                    color: Color(colorConcat),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    child: BodyMediumText(
                                      title: expertData?.expertCategory?[i].name ?? '',
                                      fontFamily: FontWeightEnum.w400.toInter,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            BodySmallText(
                              title: LocaleKeys.overAllRating.tr(),
                              fontFamily: FontWeightEnum.w400.toInter,
                              titleTextAlign: TextAlign.center,
                            ),
                            10.0.spaceX,
                            HeadlineMediumText(
                              fontSize: 30,
                              title: '-',
                              titleColor: ColorConstants.bottomTextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            BodySmallText(
                              title: LocaleKeys.feesPerMinute.tr(),
                              fontFamily: FontWeightEnum.w400.toInter,
                              titleTextAlign: TextAlign.center,
                            ),
                            10.0.spaceX,
                            HeadlineMediumText(
                              fontSize: 30,
                              title: fee != null ? '\$${fee}' :"",
                              titleColor: ColorConstants.bottomTextColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    10.0.spaceY,
                    Align(alignment: Alignment.centerLeft, child: BodySmallText(title: StringConstants.aboutMe)),
                    5.0.spaceY,
                    ReadMoreText(
                      style: TextStyle(fontSize: 14, fontFamily: FontWeightEnum.w400.toInter),
                      expertData?.about ?? '',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      textAlign: TextAlign.start,
                      trimCollapsedText: LocaleKeys.readMore.tr(),
                      trimExpandedText: LocaleKeys.readLess.tr(),
                      moreStyle: TextStyle(fontSize: 14, color: ColorConstants.bottomTextColor),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
