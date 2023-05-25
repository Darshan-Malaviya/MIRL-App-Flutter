import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

class DropdownMenuWidget extends StatelessWidget {
  final List<DropdownMenuEntry<String>> dropdownList;
  final double? menuHeight;
  final double? menuWidth;
  final bool? enableSearch;
  final bool? enableFilter;
  final bool? requestFocusOnTap;
  final bool? enableDropdown;
  final String? errorText;
  final String? labelText;
  final TextEditingController? controller;
  final Function(String value) onSelect;

  const DropdownMenuWidget(
      {Key? key,
      required this.dropdownList,
      this.menuHeight,
      this.enableSearch,
      this.enableFilter,
      this.enableDropdown,
      this.menuWidth,
      this.controller,
      this.errorText,
      this.labelText,
      required this.onSelect,
      this.requestFocusOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (labelText?.isNotEmpty ?? false) && labelText != null
            ? BodyMediumText(
                title: labelText ?? '',
                titleColor: ColorConstants.primaryColor,
                fontWeight: FontWeight.w600,
              )
            : const SizedBox.shrink(),
        (labelText?.isNotEmpty ?? false) && labelText != null ? 6.0.spaceY : const SizedBox.shrink(),
        DropdownMenu<String>(
          width: menuWidth ?? 200,
          menuHeight: menuHeight ?? 300,
          enableSearch: enableSearch ?? false,
          enableFilter: enableFilter ?? false,
          requestFocusOnTap: requestFocusOnTap ?? false,
          enabled: enableDropdown ?? true,
          trailingIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorConstants.primaryColor,
          ),
          selectedTrailingIcon: Icon(
            Icons.keyboard_arrow_up_rounded,
            color: ColorConstants.primaryColor,
          ),
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorConstants.primaryColor,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
          menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.all(ColorConstants.greyLightColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10)),
          ),
          errorText: errorText,
          initialSelection: dropdownList.first.label,
          controller: controller,
          dropdownMenuEntries: dropdownList,
          onSelected: (value) => onSelect(value ?? ''),
          inputDecorationTheme: InputDecorationTheme(
            isCollapsed: true,
            isDense: true,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            fillColor: ColorConstants.whiteColor,
            filled: true,
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
            errorStyle: TextStyle(color: ColorConstants.secondaryColor, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: "MuseoSans"),
            enabledBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
              ),
              shadow: buildBoxShadow(),
            ),
            focusedBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.primaryColor),
                borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
              ),
              shadow: buildBoxShadow(),
            ),
            errorBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.secondaryColor),
                borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
              ),
              shadow: buildBoxShadow(),
            ),
            focusedErrorBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.secondaryColor),
                borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
              ),
              shadow: buildBoxShadow(),
            ),
            errorMaxLines: 3,
          ),
        ),
      ],
    );
  }

  BoxShadow buildBoxShadow() => BoxShadow(color: ColorConstants.primaryColor.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 0));
}

DropdownMenuEntry<String> dropdownMenuEntry({required BuildContext context, required String value, required String label}) {
  return DropdownMenuEntry(
    value: value,
    label: label,
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      textStyle: MaterialStateProperty.all(
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorConstants.primaryColor,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
      ),
    ),
  );
}
