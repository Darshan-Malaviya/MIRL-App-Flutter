import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';


class TextWidgetScreen extends StatelessWidget {
  const TextWidgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        isShowLeading: false,
        appTitle: LabelLargeText(title: "Text Widgets",titleColor: ColorConstants.whiteColor,),
      ),
      body: Column(
        children: [
          TextFormFieldWidget()
        ]
      ),
    );
  }
}
