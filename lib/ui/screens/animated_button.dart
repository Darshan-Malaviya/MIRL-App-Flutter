import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/button_widget/animated_primary_button.dart';
import 'package:flutter_boilerplate_may_2023/ui/common/button_widget/animated_small_button.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedPrimaryButton(
            text: 'Press',
            onTap: () {
              setState(() {
                isLoading = !isLoading;
              });
            },
            isLoading: isLoading,
          ),
          const SizedBox(
            height: 24,
          ),
          AnimatedSmallButton(
            text: 'Press',
            onTap: () {},
          ),
          const SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(10, (index) {
              return OnScaleTap(
                onPress: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amberAccent,
                  ),
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                ),
              );
            })),
          ),
        ],
      )),
    );
  }
}
