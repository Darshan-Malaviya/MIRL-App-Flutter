import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/dropdown_widget/sort_experts_droup_down_widget.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_args.dart';

class SelectedCategoryScreen extends ConsumerStatefulWidget {
  final String categoryId;

  const SelectedCategoryScreen({super.key, required this.categoryId});

  @override
  ConsumerState createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends ConsumerState<SelectedCategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(filterProvider).getSingleCategoryApiCall(categoryId: widget.categoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterProviderWatch = ref.watch(filterProvider);
    final filterProviderRead = ref.read(filterProvider);

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
        child: filterProviderWatch.isLoading
            ? Center(child: CupertinoActivityIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: TitleLargeText(
                      title: filterProviderWatch.singleCategoryData?.categoryData?.name ?? '',
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
                            imageURL: filterProviderWatch.singleCategoryData?.categoryData?.image ?? '',
                            isNetworkImage: true,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        4.0.spaceY,
                        LabelSmallText(
                          fontSize: 9,
                          title: filterProviderWatch.singleCategoryData?.categoryData?.name ?? '',
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
                  if (filterProviderWatch.singleCategoryData?.categoryData?.topic?.isNotEmpty ?? false) ...[
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
                        children:
                            List.generate(filterProviderWatch.singleCategoryData?.categoryData?.topic?.length ?? 0, (index) {
                          final data = filterProviderWatch.singleCategoryData?.categoryData?.topic?[index];
                          return OnScaleTap(
                            onPress: () {
                              filterProviderRead.setSelectionBoolValueOfChild(position: index);
                            },
                            child: ShadowContainer(
                              shadowColor: ColorConstants.disableColor,
                              backgroundColor: data?.isSelected ?? false ? ColorConstants.primaryColor : null,
                              margin: EdgeInsets.only(bottom: 10, right: 10),
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              offset: Offset(0, 3),
                              child: BodyMediumText(
                                title: data?.name ?? '',
                                fontFamily: FontWeightEnum.w500.toInter,
                                maxLine: 5,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    20.0.spaceY,
                    BodyMediumText(
                      title: StringConstants.topicText,
                      fontFamily: FontWeightEnum.w400.toInter,
                    ),
                    5.0.spaceY,
                    BodyMediumText(
                      title: filterProviderWatch.selectedTopic ?? '',
                      maxLine: 3,
                    ),
                    10.0.spaceY,
                  ],
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
                      context.toPushNamed(RoutesConstants.expertCategoryFilterScreen, args: FilterArgs(fromExploreExpert: false));
                    },
                    prefixIcon: ImageConstants.filter,
                    prefixIconPadding: 10,
                  ).addPaddingX(20),
                  20.0.spaceY,
                  SortExpertDropDown(),
                  if (filterProviderWatch.singleCategoryData?.expertData?.isNotEmpty ?? false) ...[
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        itemBuilder: (context, i) {
                          return ExpertDetailWidget(
                            expertData: filterProviderWatch.singleCategoryData?.expertData?[i],
                          );
                        },
                        separatorBuilder: (context, index) => 20.0.spaceY,
                        itemCount: filterProviderWatch.singleCategoryData?.expertData?.length ?? 0),
                  ]
                ],
              ),
      ),
    );
  }
}
