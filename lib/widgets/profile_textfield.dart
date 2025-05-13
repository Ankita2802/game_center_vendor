import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_center_vendor/themes/app_font.dart';

class ProfileTextfield extends StatefulWidget {
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
  final Widget? suffixIcon; // Add this line
  final bool isRequired;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final String? labelText;
  final bool? enabled;
  final bool obscureText;
  final int? counter;
  final bool? isLabel;

  const ProfileTextfield({
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
    this.suffixIcon, // Add this line
    this.isRequired = true,
    this.errorText,
    this.inputFormatters,
    this.error,
    this.enabled,
    this.labelText,
    this.obscureText = false,
    this.counter,
    this.isLabel = false,
  });

  @override
  State<ProfileTextfield> createState() => _ProfileTextfieldState();
}

class _ProfileTextfieldState extends State<ProfileTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.topRight,
          colors: [Colors.black, Color(0XFF2B2829)],
        ),
      ),
      child: TextFormField(
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        inputFormatters: widget.inputFormatters,
        cursorColor: widget.themeColor ?? Colors.white,
        keyboardType: widget.textInputType,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        maxLength: widget.counter,
        textAlign: widget.center ? TextAlign.center : TextAlign.start,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        readOnly: widget.readOnly,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        expands: false,
        style:
            widget.style ??
            onestFonts.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          counterStyle: const TextStyle(
            fontSize: 12,
            color: Color(0xFFF0F0F0),
            fontWeight: FontWeight.normal,
          ),
          label:
              widget.isLabel ?? false
                  ? null
                  : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.labelText ?? ""),
                      const SizedBox(width: 11),
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Color(0XFF827A7A),
                      ),
                    ],
                  ),
          labelText: widget.isLabel ?? false ? widget.labelText : null,
          prefixIcon: widget.prefixIcon,
          labelStyle: onestFonts.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0XFF827A7A),
          ),
          prefixIconColor: widget.themeColor,
          prefix: widget.prefix,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixIcon:
              widget.suffixIcon ??
              (widget.suffixArrow
                  ? Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 25,
                    color:
                        widget.isBlackBackground
                            ? Colors.white
                            : widget.themeColor ?? Colors.white,
                  )
                  : null),
          hintStyle: const TextStyle(
            color: Color(0xFF898384),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0XFF544B4B)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0XFF544B4B)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0XFF544B4B)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0XFF544B4B)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0XFF544B4B)),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty && widget.isRequired) {
            return widget.errorText ?? 'This Field Can\'t be empty';
          }
          return widget.error;
        },
      ),
    );
  }
}
