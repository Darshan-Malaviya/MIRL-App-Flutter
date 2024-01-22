import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CategoryAndTopicListView extends StatelessWidget {
  const CategoryAndTopicListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 14.0,
            mainAxisSpacing: 30.0
        ),
        itemBuilder: (BuildContext context, int index){
          return Container(
              // margin: EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFF8F8F8)),
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                children: [
                  Image.asset(
                    ImageConstants.expert,
                    height: 50,
                    width: 50,
                  ),
                  10.0.spaceY,
                  BodySmallText(
                    title: LocaleKeys.experts.tr().toUpperCase(),
                    titleTextAlign: TextAlign.center,
                    maxLine: 3,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ));
        },
      ),
    );
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: List.generate(10,
              (index) {
        return Container(
         // margin: EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFF8F8F8)),
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Image.asset(ImageConstants.expert,
                height: 50,
                width: 50,),
              10.0.spaceY,
              BodySmallText(
                title: LocaleKeys.experts.tr().toUpperCase(),
                titleTextAlign: TextAlign.center,
                maxLine: 3,
                fontWeight: FontWeight.w700,
              ),
            ],
          ).addAllPadding(20),
        ).addMarginRight(10);
              }),
    ).addPaddingY(20);
  }
}
