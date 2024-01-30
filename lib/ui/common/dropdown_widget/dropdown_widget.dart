import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

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
  final String? hintText;
  final Color? labelColor;
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
      this.hintText,
      this.labelColor,
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
            ? Center(
                child: BodySmallText(
                  title: labelText ?? '',
                  titleColor: labelColor ?? ColorConstants.blackColor,
                ),
              )
            : const SizedBox.shrink(),
        (labelText?.isNotEmpty ?? false) && labelText != null ? 6.0.spaceY : const SizedBox.shrink(),
        DropdownMenu<String>(
          expandedInsets: EdgeInsets.all(0),
          hintText: hintText,
          width: menuWidth,
          menuHeight: menuHeight,
          enableSearch: enableSearch ?? false,
          enableFilter: enableFilter ?? false,
          requestFocusOnTap: requestFocusOnTap ?? false,
          enabled: enableDropdown ?? true,
          trailingIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorConstants.dropDownBorderColor,
            size: 18,
          ),
          selectedTrailingIcon: Icon(
            size: 18,
            Icons.keyboard_arrow_up_rounded,
            color: ColorConstants.dropDownBorderColor,
          ),
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorConstants.buttonTextColor,
                fontFamily: FontWeightEnum.w400.toInter,
                overflow: TextOverflow.ellipsis,
              ),
          errorText: errorText,
          initialSelection: hintText ?? dropdownList.first.label,
          controller: controller,
          dropdownMenuEntries: dropdownList,
          onSelected: (value) => onSelect(value ?? ''),
        ),
      ],
    );
  }
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
