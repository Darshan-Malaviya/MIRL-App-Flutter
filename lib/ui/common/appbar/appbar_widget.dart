import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
      {Key? key,
      this.leadingIcon,
      this.appTitle,
      this.trailingIcon,
      this.onLeadingIconTap,
      this.onTrailingIconTap,
      this.bottomTabs,
      this.bottomBorderColor,
      this.centerTitle,
      this.appBarPadding,
      this.preferSize,
      this.isShowLeading = true,
      this.appBarColor})
      : super(key: key);

  final Widget? appTitle;
  final String? leadingIcon;
  final Widget? trailingIcon;
  final VoidCallback? onLeadingIconTap;
  final VoidCallback? onTrailingIconTap;
  final PreferredSize? bottomTabs;
  final Color? bottomBorderColor;
  final bool? centerTitle;
  final double? preferSize;
  final EdgeInsets? appBarPadding;
  final Color? appBarColor;
  final bool? isShowLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.primaryColor,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle ?? true,
      title: appTitle,
      leading: (isShowLeading ?? false)
          ? leadingIcon != null && (leadingIcon?.isNotEmpty ?? false)
              ? InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: onLeadingIconTap,
                  child: Image.asset(leadingIcon ?? ''),
                )
              : InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: onLeadingIconTap ?? () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 24,
                    color: ColorConstants.whiteColor,
                  ),
                )
          : null,
      actions: [
        trailingIcon != null
            ? InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: onTrailingIconTap,
                child: trailingIcon ?? const SizedBox.shrink())
            : const SizedBox.shrink()
      ],
      bottom: bottomTabs,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferSize ?? 64);
}
