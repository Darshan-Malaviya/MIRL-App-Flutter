import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CategoryCommonView extends StatefulWidget {
  final void Function()? onTap;
  final String imageUrl;
  final String categoryName;
  final double? blurRadius;
  final double? spreadRadius;
  final bool isSelectedShadow;
  const CategoryCommonView({super.key,this.onTap,required this.imageUrl,required this.categoryName,this.blurRadius,this.isSelectedShadow = false,this.spreadRadius});

  @override
  State<CategoryCommonView> createState() => _CategoryCommonViewState();
}

class _CategoryCommonViewState extends State<CategoryCommonView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ShadowContainer(
        shadowColor: widget.isSelectedShadow ? ColorConstants.categoryListBorder : ColorConstants.blackColor.withOpacity(0.1),
        height: 90,
        padding: EdgeInsets.only(top: 8,bottom: 4,left: 6,right: 6),
        width: 90,
        offset: Offset(0,2),
        spreadRadius: widget.spreadRadius ?? 0,
        blurRadius: widget.blurRadius ?? 3,
        isShadow: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: NetworkImageWidget(
                boxFit: BoxFit.cover,
                imageURL: widget.imageUrl,
                isNetworkImage: true,
                height: 58,
                width: 50,
              ),
            ),
            4.0.spaceY,
            LabelSmallText(
              fontSize: 9,
             // title: "ARTS & HOBBIES",
              title: widget.categoryName.toUpperCase(),
              maxLine: 1,
              titleTextAlign: TextAlign.center,
            ),
          ],
        ),

      ),
    );
  }
}
