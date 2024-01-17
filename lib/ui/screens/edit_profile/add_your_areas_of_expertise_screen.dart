import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/margin_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/models/response/category_list_response_model.dart';
import 'package:mirl/infrastructure/providers/provider_registration.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/container_widgets/shadow_container.dart';
import 'package:mirl/ui/common/network_image/network_image.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';
import 'package:mirl/ui/screens/conponnet/area_model.dart';
import 'package:pinput/pinput.dart';

class AddYourAreasOfExpertiseScreen extends ConsumerStatefulWidget {
  const AddYourAreasOfExpertiseScreen({super.key});

  @override
  ConsumerState<AddYourAreasOfExpertiseScreen> createState() => _AddYourAreasOfExpertiseScreenState();
}

class _AddYourAreasOfExpertiseScreenState extends ConsumerState<AddYourAreasOfExpertiseScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(categoryListProvider).AreaCategoryListApiCall(isChildId: '1');
    });
    super.initState();
  }

  bool selected = false;
  List<Tech> _chipsList = [
    Tech("India", false),
    Tech("Canada", false),
    Tech("London", false),
    Tech("Paris", false),
    Tech("Japan", false),
    Tech("Maldives", false),
    Tech("Switzerland", false)
  ];

  @override
  Widget build(BuildContext context) {
    final categoryListProviderWatch = ref.watch(categoryListProvider);
    final categoryListProviderRead = ref.read(categoryListProvider);
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        trailingIcon: TitleMediumText(
          title: StringConstants.done,
          fontFamily: FontWeightEnum.w700.toInter,
        ).addPaddingRight(14),
      ),
      body: Column(
        children: [
          TitleLargeText(
            title: StringConstants.addYourAreas,
            titleColor: ColorConstants.bottomTextColor,
            fontFamily: FontWeightEnum.w700.toInter,
            maxLine: 2,
            titleTextAlign: TextAlign.center,
          ),
          20.0.spaceY,
          TitleSmallText(
            title: StringConstants.categoryView,
            titleTextAlign: TextAlign.center,
            maxLine: 2,
          ),
          30.0.spaceY,
          Expanded(
            child: categoryListProviderWatch.categoryList?.isNotEmpty ?? false
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 38, mainAxisSpacing: 30),
                    itemCount: categoryListProviderWatch.categoryList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ShadowContainer(
                        child: Column(
                          children: [
                            NetworkImageWidget(
                              imageURL: categoryListProviderWatch.categoryList?[index].categoryImage ?? '',
                              isNetworkImage: true,
                              height: 50,
                              width: 50,
                            ),
                            LabelSmallText(
                              fontSize: 9,
                              title: categoryListProviderWatch.categoryList?[index].categoryName ?? '',
                              fontFamily: FontWeightEnum.w700.toInter,
                            ),
                          ],
                        ),
                        height: 90,
                        width: 90,
                        isShadow: true,
                        shadowColor: ColorConstants.borderColor.withOpacity(0.5),
                      );
                    })
                : Center(
                    child: BodyLargeText(
                      title: StringConstants.noDataFound,
                      fontFamily: FontWeightEnum.w600.toInter,
                    ),
                  ),
          )
        ],
      ).addAllPadding(20),
    );
  }

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = FilterChip(
        showCheckmark: false,
        padding: EdgeInsets.symmetric(horizontal: 5),
        selectedColor: ColorConstants.primaryColor,
        label: Text(_chipsList[i].label),
        labelStyle: TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorConstants.transparentColor),
          borderRadius: BorderRadius.circular(14),
        ),
        //shape: StadiumBorder(side: BorderSide(color: ColorConstants.transparentColor)),
        shadowColor: Color(0x19000000),
        backgroundColor: Colors.transparent,
        // backgroundColor: _chipsList[i].color,
        selected: _chipsList[i].isSelected,
        onSelected: (bool value) {
          setState(() {
            _chipsList[i].isSelected = value;
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }
}

class Tech {
  String label;
  bool isSelected;

  Tech(this.label, this.isSelected);
}
