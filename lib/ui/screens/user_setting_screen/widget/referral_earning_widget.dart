import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import '../../../../infrastructure/commons/exports/common_exports.dart';

class ReferralEarningsWidget extends StatelessWidget {
  final String title;
  final String earnings;
  ReferralEarningsWidget({super.key, required this.title, required this.earnings});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InnerShadow(
            shadows: [
              Shadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstants.callRequestColor,
                  border: Border.all(width: 1, color: Colors.black12)),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TitleSmallText(
                fontFamily: FontWeightEnum.w600.toInter,
                fontSize: 12,
                title: title,
                titleColor: ColorConstants.blackColor,
                maxLine: 2,
              ),
            ),
          ),
          SizedBox(height: 20),
          TitleLargeText(
            fontSize: 40,
            shadow: [
              Shadow(
                offset: Offset(0.4, 0.4),
                blurRadius: 8,
                color: ColorConstants.greyColor,
              ),
            ],
            title: earnings,
            titleColor: ColorConstants.overallRatingColor,
            maxLine: 2,
          ),
        ],
      ),
    );
  }
}
