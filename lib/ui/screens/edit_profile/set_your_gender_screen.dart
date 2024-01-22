import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/gender_model.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';

class SetYourGenderScreen extends ConsumerStatefulWidget {
  const SetYourGenderScreen({super.key});

  @override
  ConsumerState<SetYourGenderScreen> createState() => _SetYourGenderScreenState();
}

class _SetYourGenderScreenState extends ConsumerState<SetYourGenderScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).getGender();
    });
    super.initState();
  }

  int? index;

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);
    return Scaffold(
      appBar: AppBarWidget(
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () => context.toPop(),
          ),
          trailingIcon: InkWell(
            onTap: () => expertRead.updateGenderApi(),
            child: TitleMediumText(
              title: StringConstants.done,
              fontFamily: FontWeightEnum.w700.toInter,
            ).addPaddingRight(14),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TitleLargeText(
                title: StringConstants.setYourGender,
                titleColor: ColorConstants.bottomTextColor,
                fontFamily: FontWeightEnum.w700.toInter,
              ),
              120.0.spaceY,
              DropdownMenuWidget(
                hintText: expertWatch.isSelectGender == 1
                    ? "Male"
                    : expertWatch.isSelectGender == 2
                        ? "Female"
                        : expertWatch.isSelectGender == 3
                            ? "Other"
                            : StringConstants.theDropDown,
                dropdownList: expertWatch.genderList.map((GenderModel item) => dropdownMenuEntry(context: context, value: item.title ?? '', label: item.title ?? '')).toList(),
                onSelect: (String value) {
                  expertRead.setGender(value);
                },
              )
            ],
          ),
        ).addAllPadding(20),
      ),
    );
  }
}
