import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/call_feedback_screen/arguments/call_feddback_arguments.dart';

class ReportedSubmittingScreen extends StatefulWidget {
  final CallFeedBackArgs args;
  const ReportedSubmittingScreen({super.key,required this.args});

  @override
  State<ReportedSubmittingScreen> createState() => _ReportedSubmittingScreenState();
}

class _ReportedSubmittingScreenState extends State<ReportedSubmittingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          100.0.spaceY,
          TitleLargeText(
            title: LocaleKeys.reported.tr(),
            titleColor: ColorConstants.bottomTextColor,
            titleTextAlign: TextAlign.center,
          ),
          20.0.spaceY,
          TitleSmallText(
            title: LocaleKeys.letting.tr(),
            titleColor: ColorConstants.buttonTextColor,
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.center,
            maxLine: 6,
          ),
          50.0.spaceY,
          Image.asset(ImageConstants.reported),
          60.0.spaceY,
          PrimaryButton(
              title: widget.args.callType == '1' ? LocaleKeys.backToProfile.tr() : LocaleKeys.backToHome.tr(),
              titleColor: ColorConstants.buttonTextColor,
              //onPressed: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0),)
              onPressed: () {
                if( widget.args.callType == '1') {
                  context.toPushNamedAndRemoveUntil(RoutesConstants.expertDetailScreen,
                      args: CallFeedBackArgs(expertId: widget.args.expertId, callType: '1'));
                }
                else{
                  context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
                }
              })
        ],
      ).addAllMargin(20),
    );
  }
}
