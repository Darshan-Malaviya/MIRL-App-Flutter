import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class FilterBottomSheetWidget extends StatelessWidget {
  final String title;
  final Function(String value) onTapItem;
  final List<dynamic> itemList;

  const FilterBottomSheetWidget({super.key, required this.title, required this.onTapItem, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TitleMediumText(title: title, titleColor: ColorConstants.sheetTitleColor),
          20.0.spaceY,
          SizedBox(
            height: itemList.length * 50,
            child: Column(
              children: List.generate(
                  itemList.length,
                  (index) => InkWell(
                        onTap: () {
                          onTapItem(itemList[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(title: itemList[index] ?? '', titleColor: ColorConstants.bottomTextColor),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
