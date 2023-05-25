import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/dropdown_widget/dropdown_widget.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/searchbar_widget/searchbar_widget.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        isShowLeading: false,
        appTitle: TitleLargeText(
          title: "Text Widgets",
          titleColor: ColorConstants.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.0.spaceY,
              DropdownMenuWidget(dropdownList: const [
                DropdownMenuEntry(value: "Value", label: "Item one"),
                DropdownMenuEntry(value: "Value", label: "Item two"),
                DropdownMenuEntry(value: "Value", label: "Item three"),
                DropdownMenuEntry(value: "Value", label: "Item four"),
                DropdownMenuEntry(value: "Value", label: "Item five"),
                DropdownMenuEntry(value: "Value", label: "Item six"),
              ], onSelect: (value) {}),
              16.0.spaceY,
              PrimaryButton(
                  title: "Open Alert",
                  onPressed: () {
                    CommonAlertDialog.dialog(
                        context: context,
                        child: const SizedBox(
                          height: 300,
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
