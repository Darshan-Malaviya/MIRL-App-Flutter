import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/call_feedback_screen/arguments/call_feddback_arguments.dart';

class FeedbackSubmittingScreen extends StatefulWidget {
  final CallFeedBackArgs args;

  const FeedbackSubmittingScreen({super.key,required this.args});

  @override
  State<FeedbackSubmittingScreen> createState() => _FeedbackSubmittingScreenState();
}

class _FeedbackSubmittingScreenState extends State<FeedbackSubmittingScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          100.0.spaceY,
          TitleLargeText(
            title: LocaleKeys.thanksForFeedback.tr(),
            titleColor: ColorConstants.bottomTextColor,
            titleTextAlign: TextAlign.center,
            maxLine: 2,
          ),
          50.0.spaceY,
          Image.asset(ImageConstants.smiley),
          60.0.spaceY,
          PrimaryButton(
            title:  widget.args.callType == '1' ? LocaleKeys.backToProfile.tr() : LocaleKeys.backToHome.tr(),
            titleColor: ColorConstants.buttonTextColor,
            //onPressed: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0),
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
