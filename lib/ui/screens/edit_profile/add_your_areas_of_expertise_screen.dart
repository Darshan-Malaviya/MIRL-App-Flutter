import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/ui/common/network_image/network_image.dart';
import 'package:mirl/ui/screens/conponnet/area_model.dart';
import 'package:mirl/ui/screens/edit_profile/widget/child_category_bottom_view.dart';

class AddYourAreasOfExpertiseScreen extends ConsumerStatefulWidget {
  const AddYourAreasOfExpertiseScreen({super.key});

  @override
  ConsumerState<AddYourAreasOfExpertiseScreen> createState() => _AddYourAreasOfExpertiseScreenState();
}

class _AddYourAreasOfExpertiseScreenState extends ConsumerState<AddYourAreasOfExpertiseScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(addYourAreaExpertiseProvider).clearSelectChildId();
      ref.read(addYourAreaExpertiseProvider).areaCategoryListApiCall();
    });
    super.initState();
  }

  //bool selected = false;
  // List<Tech> _chipsList = [
  //   Tech("India", false),
  //   Tech("Canada", false),
  //   Tech("London", false),
  //   Tech("Paris", false),
  //   Tech("Japan", false),
  //   Tech("Maldives", false),
  //   Tech("Switzerland", false)
  // ];
  List<Child> childList = [];

  @override
  Widget build(BuildContext context) {
    final addYourAreaExpertiseProviderWatch = ref.watch(addYourAreaExpertiseProvider);
    final addYourAreaExpertiseProviderRead = ref.read(addYourAreaExpertiseProvider);
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        trailingIcon: InkWell(
          onTap: () {
            addYourAreaExpertiseProviderRead.childUpdateApiCall(context: context);
          },
          child: TitleMediumText(
            title: StringConstants.done,
            fontFamily: FontWeightEnum.w700.toInter,
          ),
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
            child: addYourAreaExpertiseProviderWatch.categoryList?.isNotEmpty ?? false
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: addYourAreaExpertiseProviderWatch.categoryList?.length ?? 0,
                    itemBuilder: (context, index) {
                      CategoryListData? element = addYourAreaExpertiseProviderWatch.categoryList?[index];
                      return Column(
                        children: [
                          10.0.spaceY,
                          InkWell(
                            onTap: () {
                              addYourAreaExpertiseProviderWatch.onSelected(index);
                              CommonBottomSheet.bottomSheet(context: context,
                                  isDismissible: true,
                                  backgroundColor: ColorConstants.categoryList,
                                  child: ChildCategoryBottomView(childCategoryList: element,));
                            },
                            child: ShadowContainer(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: NetworkImageWidget(
                                      boxFit: BoxFit.cover,
                                      imageURL: addYourAreaExpertiseProviderWatch.categoryList?[index].categoryImage ?? '',
                                      isNetworkImage: true,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  4.0.spaceY,
                                  LabelSmallText(
                                    fontSize: 9,
                                    title: element?.parentName ?? '',
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
                          ),

                        /*  Visibility(
                            visible: element?.isVisible ?? false,
                            child: Container(
                              width: double.infinity,
                              color: ColorConstants.categoryList,
                              child: Wrap(
                                children: List.generate(
                                  element?.child?.length ?? 0,
                                  (position) {
                                    return FilterChip(
                                      showCheckmark: false,
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      selectedColor: ColorConstants.primaryColor,
                                      onSelected: (bool value) {
                                        setState(() {
                                          element?.child?[position].isSelected = value;
                                        });
                                      },
                                      label: Text((element?.child?[position].categoryName ?? '')),
                                      labelStyle: TextStyle(color: Colors.black),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: ColorConstants.transparentColor),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      shadowColor: Color(0x19000000),
                                      backgroundColor: Colors.transparent,
                                      // backgroundColor: _chipsList[i].color,
                                      selected: element?.child?[position].isSelected ?? false,
                                    );
                                  },
                                ),
                                spacing: 8,
                              ),
                            ).addMarginY(20),
                          ),*/

                        ],
                      );
                    })
                : Center(
                    child: BodyLargeText(
                      title: StringConstants.noDataFound,
                      fontFamily: FontWeightEnum.w600.toInter,
                    ),
                  ),
          ),
         // **************
          /*Expanded(
            child: addYourAreaExpertiseProviderWatch.categoryList?.isNotEmpty ?? false
                ? Container(
              width:  300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: addYourAreaExpertiseProviderWatch.categoryList?.length ?? 0,
                      itemBuilder: (context, index) {
                        categoryListData? element = addYourAreaExpertiseProviderWatch.categoryList?[index];
                        return Column(
                          children: [
                            10.0.spaceY,
                            InkWell(
                              onTap: () {
                                addYourAreaExpertiseProviderWatch.onSelected(index);
                              },
                              child: ShadowContainer(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: NetworkImageWidget(
                                        imageURL: addYourAreaExpertiseProviderWatch.categoryList?[index].categoryImage ?? '',
                                        isNetworkImage: true,
                                        height: 50,
                                        width: 50,
                                      ),
                                      // child: Image.network(
                                      //   element.areaOfList?[position].categoryImage ?? '',
                                      //   height: 50,
                                      //   width: 40,
                                      // ),
                                    ),
                                    LabelSmallText(
                                      fontSize: 9,
                                      title: element?.parentName ?? '',
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
                            ),
                            10.0.spaceY,
                            Visibility(
                              visible: element?.isVisible ?? false,
                              child: Container(
                                width: 300,
                                color: ColorConstants.categoryList,
                                child: Wrap(
                                  children: List.generate(
                                    element?.child?.length ?? 0,
                                    (position) {
                                      return FilterChip(
                                        showCheckmark: false,
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        selectedColor: ColorConstants.primaryColor,
                                        onSelected: (bool value) {
                                          setState(() {
                                            element?.child?[position].isSelected = value;
                                          });
                                        },
                                        label: Text((element?.child?[position].categoryName ?? '')),
                                        labelStyle: TextStyle(color: Colors.black),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: ColorConstants.transparentColor),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        shadowColor: Color(0x19000000),
                                        backgroundColor: Colors.transparent,
                                        // backgroundColor: _chipsList[i].color,
                                        selected: element?.child?[position].isSelected ?? false,
                                      );
                                    },
                                  ),
                                  spacing: 8,
                                ),
                              ).addMarginY(20),
                            ),
                            10.0.spaceY,
                          ],
                        );
                      }),
                )
                : Center(
                    child: BodyLargeText(
                      title: StringConstants.noDataFound,
                      fontFamily: FontWeightEnum.w600.toInter,
                    ),
                  ),
          ),*/
          // **************
          // Expanded(
          //   child: addYourAreaExpertiseProviderWatch.categoryList?.isNotEmpty ?? false
          //       ? Wrap(
          //           children: List.generate(addYourAreaExpertiseProviderWatch.categoryList?.length ?? 0, (index) {
          //             categoryListData? element = addYourAreaExpertiseProviderWatch.categoryList?[index];
          //             return Column(
          //               children: [
          //                 10.0.spaceY,
          //                 InkWell(
          //                   onTap: () {
          //                     addYourAreaExpertiseProviderWatch.onSelected(index);
          //                   },
          //                   child: ShadowContainer(
          //                     child: Column(
          //                       children: [
          //                         ClipRRect(
          //                           borderRadius: BorderRadius.circular(20.0),
          //                           child: NetworkImageWidget(
          //                             imageURL: addYourAreaExpertiseProviderWatch.categoryList?[index].categoryImage ?? '',
          //                             isNetworkImage: true,
          //                             height: 50,
          //                             width: 50,
          //                           ),
          //                           // child: Image.network(
          //                           //   element.areaOfList?[position].categoryImage ?? '',
          //                           //   height: 50,
          //                           //   width: 40,
          //                           // ),
          //                         ),
          //                         LabelSmallText(
          //                           fontSize: 9,
          //                           title: element?.parentName ?? '',
          //                           titleColor: ColorConstants.blackColor,
          //                           fontFamily: FontWeightEnum.w700.toInter,
          //                           titleTextAlign: TextAlign.center,
          //                         ),
          //                       ],
          //                     ),
          //                     height: 90,
          //                     width: 90,
          //                     isShadow: true,
          //                   ).addAllPadding(12),
          //                 ),
          //                 10.0.spaceY,
          //                 Visibility(
          //                   visible: element?.isVisible ?? false,
          //                   child: Container(
          //                     width: double.infinity,
          //                     color: ColorConstants.categoryList,
          //                     child: Wrap(
          //                       children: List.generate(
          //                         element?.child?.length ?? 0,
          //                         (position) {
          //                           return FilterChip(
          //                             showCheckmark: false,
          //                             padding: EdgeInsets.symmetric(horizontal: 5),
          //                             selectedColor: ColorConstants.primaryColor,
          //                             onSelected: (bool value) {
          //                               setState(() {
          //                                 element?.child?[position].isSelected = value;
          //                               });
          //                             },
          //                             label: Text((element?.child?[position].categoryName ?? '')),
          //                             labelStyle: TextStyle(color: Colors.black),
          //                             shape: RoundedRectangleBorder(
          //                               side: BorderSide(color: ColorConstants.transparentColor),
          //                               borderRadius: BorderRadius.circular(14),
          //                             ),
          //                             shadowColor: Color(0x19000000),
          //                             backgroundColor: Colors.transparent,
          //                             // backgroundColor: _chipsList[i].color,
          //                             selected: element?.child?[position].isSelected ?? false,
          //                           ).addMarginX(10);
          //                         },
          //                       ),
          //                       spacing: 8,
          //                     ),
          //                   ).addMarginY(20),
          //                 ),
          //                 10.0.spaceY,
          //               ],
          //             );
          //           }),
          //         )
          //       : Center(
          //           child: BodyLargeText(
          //             title: StringConstants.noDataFound,
          //             fontFamily: FontWeightEnum.w600.toInter,
          //           ),
          //         ),
          // ),
          PrimaryButton(
              title: StringConstants.setYourExpertise,
              onPressed: () {
                //addYourAreaExpertiseProviderRead.ChildUpdateApiCall();
              })
        ],
      ).addAllPadding(20),
    );
  }
}

// class Tech {
//   String label;
//   bool isSelected;
//
//   Tech(this.label, this.isSelected);
// }
