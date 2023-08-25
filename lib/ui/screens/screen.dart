import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/animations/shake_animation.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late GlobalKey<CustomShakeWidgetState> buttonShakeKey;
  late final Animatable<Offset> _slideTransition = Tween<Offset>(
    begin: const Offset(0.5, 0),
    end: Offset.zero,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonShakeKey = GlobalKey();
  }

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
      body: Center(
        child: CustomShakeWidget(
          key: buttonShakeKey,
          duration: const Duration(milliseconds: 800),
          shakeCount: 4,
          shakeOffset: 4,
          child: PrimaryButton(title: "Button", onPressed: () => buttonShakeKey.currentState?.shake()),
        ),
      )
    );
  }
}
