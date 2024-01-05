import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/providers/provider_registration.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/container_widgets/shadow_container.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class AddYourAreasOfExpertiseScreen extends ConsumerStatefulWidget {
  const AddYourAreasOfExpertiseScreen({super.key});

  @override
  ConsumerState<AddYourAreasOfExpertiseScreen> createState() => _AddYourAreasOfExpertiseScreenState();
}

class _AddYourAreasOfExpertiseScreenState extends ConsumerState<AddYourAreasOfExpertiseScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(categoryListProvider).AddAreaCategoryListApiCall();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryListProviderWatch = ref.watch(categoryListProvider);
    // final categoryListProviderRead = ref.read(categoryListProvider);
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
        appTitle: TitleLargeText(
          title: StringConstants.addYourAreas,
          titleColor: ColorConstants.bottomTextColor,
          fontFamily: FontWeightEnum.w700.toInter,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleSmallText(
              title: StringConstants.categoryView,
              titleColor: ColorConstants.blackColor,
              fontFamily: FontWeightEnum.w400.toInter,
              titleTextAlign: TextAlign.center,
            ),
            30.0.spaceY,
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 30, mainAxisExtent: 140),
                itemCount: categoryListProviderWatch.categoryList?.length ?? 0,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: ShadowContainer(
                      child: Column(
                        children: [
                          Image.asset(
                            categoryListProviderWatch.categoryList?[index].categoryImage ?? '',
                            height: 58,
                            width: 50,
                          ),
                          3.0.spaceY,
                          LabelSmallText(
                            fontSize: 9,
                            title: categoryListProviderWatch.categoryList?[index].categoryName ?? '',
                            titleColor: ColorConstants.blackColor,
                            fontFamily: FontWeightEnum.w700.toInter,
                            titleTextAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      height: 90,
                      width: 90,
                      isShadow: true,
                    ),
                  );
                })
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
