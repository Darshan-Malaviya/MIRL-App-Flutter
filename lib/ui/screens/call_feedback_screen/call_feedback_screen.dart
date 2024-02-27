import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CallFeedbackScreen extends StatefulWidget {
  const CallFeedbackScreen({super.key});

  @override
  State<CallFeedbackScreen> createState() => _CallFeedbackScreenState();
}

class _CallFeedbackScreenState extends State<CallFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBarWidget(
          preferSize: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: BodyMediumText(title: 'Call Feedback Screen: Work in progress...',
              maxLine: 3,),
            ),
            20.0.spaceY,
            PrimaryButton(
              buttonColor: ColorConstants.buttonColor,
              title: "Go to Home Screen",
              titleColor: ColorConstants.buttonTextColor,
              onPressed: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen,args: 0),
            ),
          ],
        ).addAllMargin(20),
      ),
    );
  }
}
