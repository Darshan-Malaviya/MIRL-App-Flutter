import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/drage_widget.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/rating_widget.dart';
import 'package:mirl/slide_rating_dialog_base.dart';
import 'package:mirl/ui/screens/instant_call_screen/instant_call_screen.dart';

class UserSettingScreen extends ConsumerStatefulWidget {
  const UserSettingScreen({super.key});

  @override
  ConsumerState<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends ConsumerState<UserSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        trailingIcon: InkWell(
          onTap: () {},
          child: TitleMediumText(
            title: StringConstants.done,
          ).addPaddingRight(14),
        ),
      ),
      body: Center(
        child: PageView(
          children: [
       /*     RatingWidget(
              onRatingChanged: (value) {},
            )*/
            ReviewSlider(onChange: (value){})
          ],
        ),
      ),
    );
  }
}
