import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final VoidCallback onTapGalley, onTapCamera;

  const ImagePickerBottomSheet({super.key, required this.onTapCamera, required this.onTapGalley});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        20.0.spaceY,
        TitleMediumText(
          title: 'Image Picker',
          fontFamily: FontWeightEnum.w500.toInter,
        ),
        20.0.spaceY,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OnScaleTap(
              onPress: onTapGalley,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: ColorConstants.borderColor, width: 2)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image,
                      size: 36,
                      color: ColorConstants.primaryColor,
                    ),
                    12.0.spaceX,
                    BodyMediumText(
                      title: StringConstants.gallery,
                      fontFamily: FontWeightEnum.w500.toInter,
                    ),
                  ],
                ),
              ),
            ),
            OnScaleTap(
              onPress: onTapCamera,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: ColorConstants.borderColor, width: 2)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera,
                      size: 36,
                      color: ColorConstants.primaryColor,
                    ),
                    12.0.spaceX,
                    BodyMediumText(
                      title: StringConstants.camera,
                      fontFamily: FontWeightEnum.w500.toInter,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        20.0.spaceY,
      ],
    ).addPaddingX(40);
  }
}
