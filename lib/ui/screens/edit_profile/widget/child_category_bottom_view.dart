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
      child: Container(
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
                  print("widget.childCategoryList?.child?[position].id ");
                  print(widget.childCategoryList?.child?[position].id);
                  setState(() {
                    widget.childCategoryList?.child?[position].isSelected = value;
                  });
                  ref.read(addYourAreaExpertiseProvider).addSelectedChildIds(childCategoryId: widget.childCategoryList?.child?[position].id ?? 0,
                      childIndex: position);
                },
                label: Text((widget.childCategoryList?.child?[position].categoryName ?? '')),
                labelStyle: TextStyle(color: Colors.black),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorConstants.transparentColor),
                  borderRadius: BorderRadius.circular(14),
                ),
                shadowColor: Color(0x19000000),
                backgroundColor: Colors.transparent,
                // backgroundColor: _chipsList[i].color,
                selected: widget.childCategoryList?.child?[position].isSelected ?? false,
              );
            },
          ),
          spacing: 8,
        ),
      ).addMarginXY(paddingX: 20,paddingY: 20),
    );
  }
}
