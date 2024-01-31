import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_args.dart';

class SelectedCategoryScreen extends ConsumerStatefulWidget {
  const SelectedCategoryScreen({super.key});

  @override
  ConsumerState createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends ConsumerState<SelectedCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final addYourAreaExpertiseProviderWatch = ref.watch(addYourAreaExpertiseProvider);
    final addYourAreaExpertiseProviderRead = ref.read(addYourAreaExpertiseProvider);

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBg,
      appBar: AppBarWidget(
        appBarColor: ColorConstants.scaffoldBg,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: TitleLargeText(
                title: addYourAreaExpertiseProviderWatch.selectedCategory?.name ?? '',
                fontSize: 20,
              ),
            ),
            10.0.spaceY,
            LabelSmallText(
              title: StringConstants.needAMentor,
              fontFamily: FontWeightEnum.w400.toInter,
              maxLine: 2,
              titleTextAlign: TextAlign.center,
            ).addPaddingX(20),
            20.0.spaceY,
            ShadowContainer(
              shadowColor: ColorConstants.categoryListBorder,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: NetworkImageWidget(
                      boxFit: BoxFit.cover,
                      imageURL: addYourAreaExpertiseProviderWatch.selectedCategory?.image ?? '',
                      isNetworkImage: true,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  4.0.spaceY,
                  LabelSmallText(
                    fontSize: 9,
                    title: addYourAreaExpertiseProviderWatch.selectedCategory?.name ?? '',
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
            20.0.spaceY,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                ),
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0.0,
                  blurRadius: 10.0,
                ),
              ]),
              child: Wrap(
                children: List.generate(
                    addYourAreaExpertiseProviderWatch.selectedCategory?.topic?.length ?? 0,
                    (index) => OnScaleTap(
                          onPress: () {
                            addYourAreaExpertiseProviderRead.setSelectionBoolValueOfChild(position: index);
                          },
                          child: ShadowContainer(
                              shadowColor: ColorConstants.disableColor,
                              backgroundColor: addYourAreaExpertiseProviderWatch.selectedCategory?.topic?[index].isSelected ?? false ? ColorConstants.primaryColor : null,
                              margin: EdgeInsets.only(bottom: 10, right: 10),
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              offset: Offset(0, 3),
                              child: BodyMediumText(
                                title: addYourAreaExpertiseProviderWatch.selectedCategory?.topic?[index].name ?? '',
                                fontFamily: FontWeightEnum.w500.toInter,
                                maxLine: 5,
                              )),
                        )),
              ),
            ),
            20.0.spaceY,
            BodyMediumText(
              title: StringConstants.topicText,
              fontFamily: FontWeightEnum.w400.toInter,
            ),
            5.0.spaceY,
            BodyMediumText(
              title: addYourAreaExpertiseProviderWatch.selectedTopic ?? '',
              maxLine: 3,
            ),
            10.0.spaceY,
            BodyMediumText(
              title: StringConstants.descriptionText,
              fontFamily: FontWeightEnum.w400.toInter,
              maxLine: 5,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            PrimaryButton(
              title: StringConstants.filterExpertCategory,
              onPressed: () {
                context.toPushNamed(RoutesConstants.expertCategoryFilterScreen,
                    args: FilterArgs(fromExploreExpert: false, list: addYourAreaExpertiseProviderWatch.selectedCategory?.topic ?? []));
              },
              prefixIcon: ImageConstants.filter,
              prefixIconPadding: 10,
            ).addPaddingX(20),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                itemBuilder: (context, index) {
                  return ExpertDetailWidget();
                },
                separatorBuilder: (context, index) => 20.0.spaceY,
                itemCount: 30)
          ],
        ),
      ),
    );
  }
}
