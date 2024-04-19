import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';

class NotificationAndPreferencesScreen extends ConsumerStatefulWidget {
  const NotificationAndPreferencesScreen({super.key});

  @override
  ConsumerState<NotificationAndPreferencesScreen> createState() => _NotificationAndPreferencesScreenState();
}

class _NotificationAndPreferencesScreenState extends ConsumerState<NotificationAndPreferencesScreen> {
  List<String> _locations = ["Yes", "No"];

  List<String> get locations => _locations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Column(
        children: [
          30.0.spaceY,
          TitleLargeText(
            title: LocaleKeys.notificationAndPreference.tr(),
            titleColor: ColorConstants.bottomTextColor,
            titleTextAlign: TextAlign.center,
            maxLine: 2,
          ),
          40.0.spaceY,
          BodySmallText(
            title: LocaleKeys.preferredCurrency.tr(),
            titleColor: ColorConstants.bottomTextColor,
            titleTextAlign: TextAlign.center,
            maxLine: 3,
          ),
          2.0.spaceY,
          DropdownMenuWidget(
            hintText: LocaleKeys.theDropdown.tr(),
            // controller: expertWatch.locationController,
            dropdownList: locations.map((String item) => dropdownMenuEntry(context: context, value: item, label: item)).toList(),
            onSelect: (String value) {
              //   expertWatch.locationSelect(value);
            },
          ),
        ],
      ).addAllPadding(20),
    );
  }
}
