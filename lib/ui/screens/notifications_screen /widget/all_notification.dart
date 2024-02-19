import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class AllNotificationTypeNameWidget extends StatefulWidget {
  const AllNotificationTypeNameWidget({super.key});

  @override
  State<AllNotificationTypeNameWidget> createState() => _AllNotificationTypeNameWidgetState();
}

class _AllNotificationTypeNameWidgetState extends State<AllNotificationTypeNameWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ShadowContainer(
                shadowColor: ColorConstants.categoryListBorder,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: NetworkImageWidget(
                        boxFit: BoxFit.cover,
                        imageURL: ImageConstants.exploreImage,
                        isNetworkImage: true,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    4.0.spaceY,
                    LabelSmallText(
                      fontSize: 9,
                      title: "vaidehi",
                      titleColor: ColorConstants.blackColor,
                      fontFamily: FontWeightEnum.w700.toInter,
                      titleTextAlign: TextAlign.center,
                    ),
                  ],
                ),
                height: 90,
                width: 90,
                isShadow: true,
              ).addPaddingTop(5),
              Positioned(
                top: 0,
                right: 15,
                child: CircleAvatar(
                  child: TitleMediumText(
                    title: '0',
                    fontWeight: FontWeight.w600,
                    titleColor: ColorConstants.blackColor,
                  ),
                  radius: 14,
                  backgroundColor: ColorConstants.primaryColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
