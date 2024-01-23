import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';

class ChildCategoryBottomView extends ConsumerStatefulWidget {
  final CategoryListData? childCategoryList;

  const ChildCategoryBottomView({required this.childCategoryList, super.key});

  @override
  ConsumerState<ChildCategoryBottomView> createState() => _ChildCategoryBottomViewState();
}

class _ChildCategoryBottomViewState extends ConsumerState<ChildCategoryBottomView> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.childCategoryList?.isVisible ?? false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterChip(
            showCheckmark: false,
            padding: EdgeInsets.symmetric(horizontal: 5),
            selectedColor: ColorConstants.primaryColor,
            onSelected: (bool value) {
              setState(() {
                widget.childCategoryList?.selectAllCategory = value;
              });
              ref.read(addYourAreaExpertiseProvider)
                  .selectAllChildCategory(
                  isSelectAll: value, parentId: widget.childCategoryList?.id ?? -1);
              ref.read(addYourAreaExpertiseProvider).addSelectedChildIds(parentId: widget.childCategoryList?.id ?? -1);
            },
            label: Text('${widget.childCategoryList?.parentName ?? ''} - All topics',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            labelStyle: TextStyle(color: Colors.black),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorConstants.transparentColor),
              borderRadius: BorderRadius.circular(14),
            ),
            shadowColor: Color(0x19000000),
            backgroundColor: Colors.transparent,
            selected: widget.childCategoryList?.selectAllCategory ?? false,
          ),
          Container(
            width: double.infinity,
            child: Wrap(
              children: List.generate(
                widget.childCategoryList?.child?.length ?? 0,
                (position) {
                  return FilterChip(
                    showCheckmark: false,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    selectedColor: ColorConstants.primaryColor,
                    onSelected: (bool value) {
                      setState(() {
                        widget.childCategoryList?.child?[position].isSelected = value;
                      });
                      ref.read(addYourAreaExpertiseProvider).addSelectedChildIds(

                      //    childIndex: position,
                          parentId: widget.childCategoryList?.id ?? -1);
                    },
                    label: Text((widget.childCategoryList?.child?[position].categoryName ?? ''),
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),),
                    labelStyle: TextStyle(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstants.transparentColor),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    shadowColor: Color(0x19000000),
                    backgroundColor: Colors.transparent,
                    selected: widget.childCategoryList?.child?[position].isSelected ?? false,
                  );
                },
              ),
              spacing: 8,
            ),
          ),
        ],
      ).addMarginXY(paddingX: 20,paddingY: 20),
    );
  }
}
