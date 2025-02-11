import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class TextFormFieldWidget extends StatelessWidget {
  final Key? textFormFieldKey;

  /// A controller for an editable text field.
  final TextEditingController? controller;

  /// The type of information for which to optimize the text input control
  final TextInputType? textInputType;

  /// Decorate a Material Design text field.
  final InputDecoration? decoration;

  /// Defines make field as a read only
  final bool? isReadOnly;

  /// An action the user has requested the text input control to perform.
  final TextInputAction? textInputAction;

  /// To receive key events that focuses on this node, pass a listener to `onKeyEvent`
  final FocusNode? focusNode;

  /// Defines field fil color
  final Color? fillColor;

  /// Validates the textfield
  final FormFieldValidator<String>? validator;

  /// List of enforcements applied to the editing value
  final List<TextInputFormatter>? inputFormatters;

  /// Specifies the hint
  final String? hintText;

  /// Specifies the initalValue
  final String? initialValue;

  /// Defines hint color
  final Color? hintTextColor;

  /// Whether and how to align text horizontally.
  final TextAlign? textAlign;

  /// Defines suffix icon
  final Widget? suffixIcon;

  /// Defines max lines  of field [Default 1]
  final int? maxLines;

  /// Defines min lines  of field [Default 1]
  final int? minLines;

  /// Defines error lines  of field [Default 1]
  final int? errorLines;

  /// Defines content padding
  final EdgeInsetsGeometry? contentPadding;

  final ValueChanged<String>? onFieldSubmitted;

  /// Defines font weight of entered text
  final FontWeight? fontWeight;

  /// Call when there is the change on the current state of textfield
  final ValueChanged<String>? onChanged;

  final Iterable<String>? autofillHints;

  /// Creates a text style.
  final TextStyle? textStyle;

  /// Creates a hint text style.

  final TextStyle? hintStyle;

  /// Defines enable border color

  final Color? enabledBorderColor;

  /// Defines focus border color

  final Color? focusedBorderColor;

  /// Defines error border color
  final Color? errorBorderColor;

  /// Defines focus error border color
  final Color? focusedErrorBorderColor;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool? autofocus;

  /// Defines on tap of field
  final VoidCallback? onTap;

  /// Callback that generates a custom [InputDecoration.counter] widget.
  final InputCounterWidgetBuilder? buildCounter;

  /// Expands the textfield.
  final bool? expands;

  /// Describes the contrast of a theme or color palette of keyboard.
  final Brightness? keyboardAppearance;

  /// Defines maxlength of text
  final int? maxLength;

  /// Hides the text with the specified character
  final bool? obscureText;

  /// Call when the text editing has been completed
  final VoidCallback? onEditingComplete;

  /// Call when the user saves the form
  final FormFieldSetter<String>? onSaved;

  /// Restoration ID to save and restore the state of the text field.
  final String? restorationId;

  /// Used to show cursor.
  final bool? showCursor;

  /// Indicates how to handle the intelligent replacement of dashes in text input.
  final SmartDashesType? smartDashesType;

  /// Indicates how to handle the intelligent replacement of quotes in text input.
  final SmartQuotesType? smartQuotesType;

  /// Creates a strut style.
  final StrutStyle? strutStyle;

  /// Aligns the text in the vertical axis.
  final TextAlignVertical? textAlignVertical;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard
  final TextCapitalization? textCapitalization;

  /// A direction in which text flows.
  final TextDirection? textDirection;

  /// Configuration of toolbar options.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// ./// Defines the appearance of an [InputDecorator]'s border.
  final InputBorder? border;

  /// Defines the radius of the border.
  final double? borderRadius;

  /// Defines border width
  final double? borderWidth;

  final String? errorText;

  final Widget? prefixWidget;

  final Widget? prefixIconWidget;

  final BoxConstraints? prefixIconWidgetConstraints;
  final BoxConstraints? suffixIconWidgetConstraints;

  final Color? shadowColor;

  final String? fontFamily;

  final double? width;

  final double? height;

  final String? labelText;

  final Color? labelColor;

  final AlignmentGeometry? alignment;

  final String? textFontFamily;

  final String? labelTextFontFamily;

  final double? labelTextSpace;

  final bool? setFormatter;

  final bool? canRequestFocus;

  final bool? enableShadow;

  const TextFormFieldWidget(
      {this.textFormFieldKey,
      this.controller,
      this.textInputType,
      this.decoration,
      this.isReadOnly,
      this.textInputAction,
      this.focusNode,
      this.fillColor,
      this.validator,
      this.inputFormatters,
      this.hintText,
      this.hintTextColor,
      this.textAlign,
      this.suffixIcon,
      this.maxLines,
      this.contentPadding,
      this.minLines,
      this.onFieldSubmitted,
      this.fontWeight,
      this.onChanged,
      this.autofillHints,
      this.textStyle,
      this.hintStyle,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.errorBorderColor,
      this.focusedErrorBorderColor,
      this.onTap,
      this.expands,
      this.keyboardAppearance,
      this.maxLength,
      this.obscureText,
      this.onEditingComplete,
      this.onSaved,
      this.restorationId,
      this.showCursor,
      this.smartDashesType,
      this.smartQuotesType,
      this.strutStyle,
      this.textAlignVertical,
      this.textCapitalization,
      this.textDirection,
      this.contextMenuBuilder,
      this.autofocus,
      this.buildCounter,
      this.labelTextFontFamily,
      this.textFontFamily,
      this.labelTextSpace,
      this.border,
      this.borderRadius,
      this.borderWidth,
      this.errorText,
      this.errorLines,
      this.prefixWidget,
      this.prefixIconWidget,
      this.shadowColor,
      this.width,
      this.height,
      this.fontFamily,
      this.prefixIconWidgetConstraints,
      this.suffixIconWidgetConstraints,
      this.labelText,
      this.labelColor,
      this.initialValue,
      this.alignment,
      this.setFormatter,
      this.canRequestFocus,
      this.enableShadow})
      : super(key: textFormFieldKey);

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = MediaQuery.of(context).textScaleFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (labelText?.isNotEmpty ?? false) && labelText != null
            ? Align(
                alignment: alignment ?? Alignment.center,
                child: BodySmallText(
                  fontFamily: labelTextFontFamily ?? FontWeightEnum.w400.toInter,
                  title: labelText ?? '',
                  titleColor: labelColor ?? ColorConstants.blackColor,
                ),
              )
            : const SizedBox.shrink(),
        (labelText?.isNotEmpty ?? false) && labelText != null ? (labelTextSpace?.spaceY ?? 6.0.spaceY) : const SizedBox.shrink(),
        SizedBox(
          height: height,
          width: width,
          child: Container(
            decoration: enableShadow == true
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.commonRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(-2, -2),
                      ),
                      BoxShadow(
                        color: ColorConstants.whiteColor,
                        spreadRadius: -1.0,
                        blurRadius: 10.0,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  )
                : null,
            child: TextFormField(
              textAlign: textAlign ?? TextAlign.left,
              inputFormatters: setFormatter ?? true
                  ? [
                      ...?inputFormatters,
                      FilteringTextInputFormatter.deny(RegExp(r"^\s*")),
                      FilteringTextInputFormatter.deny(RegExp(RegexConstants.emojiRegex)),
                    ]
                  : null,
              validator: validator,
              focusNode: focusNode,
              maxLines: maxLines ?? 1,
              minLines: minLines ?? 1,
              maxLength: maxLength,
              textInputAction: textInputAction ?? TextInputAction.next,
              readOnly: isReadOnly ?? false,
              style: textStyle ?? TextStyle(color: ColorConstants.blackColor, fontSize: 14 / scaleFactor, fontFamily: textFontFamily ?? FontWeightEnum.w400.toInter),
              keyboardType: textInputType ?? TextInputType.text,
              controller: controller,
              initialValue: initialValue,
              decoration: decoration ??
                  InputDecoration(
                    counterText: '',
                    prefixIconConstraints: prefixIconWidgetConstraints,
                    suffixIconConstraints: suffixIconWidgetConstraints,
                    prefixIcon: prefixIconWidget,
                    prefix: prefixWidget ?? const SizedBox.shrink(),
                    errorText: errorText != null && (errorText?.isNotEmpty ?? false) ? errorText : null,
                    suffixIcon: suffixIcon,
                    hintStyle: hintStyle ?? TextStyle(color: hintTextColor ?? ColorConstants.greyColor, fontSize: 12 / scaleFactor, fontFamily: fontFamily ?? FontWeightEnum.w400.toInter),
                    hintText: hintText ?? '',
                    border: border ?? InputBorder.none,
                    contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    fillColor: fillColor ?? Colors.white,
                    filled: true,
                    errorStyle: TextStyle(color: ColorConstants.secondaryColor, fontSize: 12 / scaleFactor, fontWeight: FontWeight.w600),

                    ///text field with shadow
                    enabledBorder: DecoratedInputBorder(
                      child: OutlineInputBorder(
                        borderSide: BorderSide(color: enabledBorderColor ?? ColorConstants.borderColor, width: borderWidth ?? 1),
                        borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.commonRadius),
                      ),
                      shadow: buildBoxShadow(),
                    ),
                    focusedBorder: DecoratedInputBorder(
                      child: OutlineInputBorder(
                        borderSide: BorderSide(color: focusedBorderColor ?? ColorConstants.borderColor, width: borderWidth ?? 1),
                        borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.commonRadius),
                      ),
                      shadow: buildBoxShadow(),
                    ),
                    errorBorder: DecoratedInputBorder(
                      child: OutlineInputBorder(
                        borderSide: BorderSide(color: errorBorderColor ?? ColorConstants.borderColor, width: borderWidth ?? 1),
                        borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.commonRadius),
                      ),
                      shadow: buildBoxShadow(),
                    ),
                    focusedErrorBorder: DecoratedInputBorder(
                      child: OutlineInputBorder(
                        borderSide: BorderSide(color: focusedErrorBorderColor ?? ColorConstants.borderColor, width: borderWidth ?? 1),
                        borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.commonRadius),
                      ),
                      shadow: buildBoxShadow(),
                    ),
                    disabledBorder: DecoratedInputBorder(
                      child: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.borderColor),
                        borderRadius: BorderRadius.circular(borderRadius ?? RadiusConstant.commonRadius),
                      ),
                      shadow: buildBoxShadow(),
                    ),
                    errorMaxLines: errorLines ?? 3,
                  ),
              onChanged: onChanged,
              autofillHints: autofillHints,
              onFieldSubmitted: onFieldSubmitted,
              onTap: onTap ?? () {},
              autocorrect: false,
              autofocus: autofocus ?? false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: ColorConstants.greyColor,
              cursorRadius: const Radius.circular(100),
              cursorHeight: 24,
              enabled: canRequestFocus ?? true,
              enableIMEPersonalizedLearning: true,
              enableInteractiveSelection: true,
              enableSuggestions: true,
              expands: expands ?? false,
              keyboardAppearance: keyboardAppearance ?? Brightness.light,
              obscureText: obscureText ?? false,
              obscuringCharacter: '●',
              onEditingComplete: onEditingComplete ?? () {},
              onSaved: onSaved ?? (val) {},
              textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              textDirection: textDirection ?? TextDirection.ltr,
              contextMenuBuilder: (context, editableTextState) {
                ///refer this link
                ///https://docs.flutter.dev/release/breaking-changes/context-menus
                final List<ContextMenuButtonItem> buttonItems = [
                  ContextMenuButtonItem(
                      onPressed: () {
                        editableTextState.cutSelection(SelectionChangedCause.longPress);
                      },
                      type: ContextMenuButtonType.cut),
                  ContextMenuButtonItem(
                      onPressed: () {
                        editableTextState.pasteText(SelectionChangedCause.longPress);
                      },
                      type: ContextMenuButtonType.paste),
                  ContextMenuButtonItem(
                      onPressed: () {
                        editableTextState.copySelection(SelectionChangedCause.longPress);
                      },
                      type: ContextMenuButtonType.copy),
                  ContextMenuButtonItem(
                      onPressed: () {
                        editableTextState.selectAll(SelectionChangedCause.longPress);
                      },
                      type: ContextMenuButtonType.selectAll),
                ];
                return AdaptiveTextSelectionToolbar.buttonItems(
                  anchors: editableTextState.contextMenuAnchors,
                  buttonItems: (obscureText ?? false) ? [] : buttonItems,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  BoxShadow buildBoxShadow() => BoxShadow(color: ColorConstants.primaryColor.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 0));
}
