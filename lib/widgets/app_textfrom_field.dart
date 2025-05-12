import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_center_vendor/themes/app_font.dart';

class AppTextFormField extends StatefulWidget {
  final TextStyle? style;
  final Widget? prefix;
  final int? maxLines;
  final int minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final bool isBlackBackground;
  final bool suffixArrow;
  final Color? themeColor;
  final EdgeInsetsGeometry? margin;
  final bool center;
  final Widget? prefixIcon;
  final bool isRequired;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final bool? enabled;

  const AppTextFormField({
    super.key,
    this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.onTap,
    this.readOnly = false,
    this.textInputType,
    this.suffixArrow = false,
    this.onChanged,
    this.prefix,
    this.textInputAction,
    this.style,
    this.isBlackBackground = false,
    this.themeColor,
    this.margin,
    this.center = false,
    this.prefixIcon,
    this.isRequired = true,
    this.errorText,
    this.inputFormatters,
    this.error,
    this.enabled,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,
      cursorColor: widget.themeColor ?? Colors.white,
      keyboardType: widget.textInputType,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      textAlign: widget.center ? TextAlign.center : TextAlign.start,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      readOnly: widget.readOnly,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style:
          widget.style ??
          poppinsFonts.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.themeColor,
        prefix: widget.prefix,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        suffixIcon:
            widget.suffixArrow
                ? Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 25,
                  color:
                      widget.isBlackBackground
                          ? Colors.white
                          : widget.themeColor ?? Colors.white,
                )
                : null,
        hintText: widget.hintText,
        hintStyle:
            widget.isBlackBackground
                ? poppinsFonts.copyWith(color: Colors.black)
                : poppinsFonts.copyWith(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.isBlackBackground
                    ? Colors.grey
                    : widget.themeColor ?? Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.isBlackBackground
                    ? Colors.grey
                    : widget.themeColor ?? Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty && widget.isRequired) {
          return 'This Field Can\'t be empty';
        }
        return widget.error;
      },
    );
  }
}
