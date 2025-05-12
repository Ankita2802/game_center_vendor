import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_center_vendor/themes/app_font.dart';

class TeamTextfield extends StatefulWidget {
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
  final bool suffixArrow;
  final Color? themeColor;
  final EdgeInsetsGeometry? margin;
  final bool center;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isRequired;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final String? labelText;
  final bool? enabled;
  final bool obscureText;

  const TeamTextfield({
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
    this.themeColor,
    this.margin,
    this.center = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isRequired = true,
    this.errorText,
    this.inputFormatters,
    this.error,
    this.enabled,
    this.labelText,
    this.obscureText = false,
  });

  @override
  State<TeamTextfield> createState() => _TeamTextfieldState();
}

class _TeamTextfieldState extends State<TeamTextfield> {
  bool showErr = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF000502), Color(0XFF2B2829)],
            ),
          ),
          child: TextFormField(
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            inputFormatters: widget.inputFormatters,
            cursorColor: widget.themeColor ?? Colors.white,
            keyboardType: widget.textInputType,
            onChanged: (value) {
              if (widget.onChanged != null) widget.onChanged!(value);
              showErr = true;
              setState(() {});
            },
            onTap: widget.onTap,
            textAlign: widget.center ? TextAlign.center : TextAlign.start,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            readOnly: widget.readOnly,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            expands: false,
            style:
                widget.style ??
                onestFonts.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            controller: widget.controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: widget.hintText,
              fillColor: Colors.transparent,
              labelText: widget.labelText,
              prefixIcon: widget.prefixIcon,
              floatingLabelStyle: onestFonts.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0XFF827A7A),
              ),
              hintStyle: onestFonts.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0XFF544B4B),
              ),
              prefixIconColor: widget.themeColor,
              prefix: widget.prefix,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18.5,
              ),
              suffixIcon:
                  widget.suffixIcon ??
                  (widget.suffixArrow
                      ? Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 25,
                        color: Colors.white,
                      )
                      : null),
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
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (BuildContext context, value, Widget? child) {
            return Column(
              children: [
                if (widget.error != null || (value.text.isEmpty && showErr))
                  SizedBox(height: 4),
                if (widget.error != null || (value.text.isEmpty && showErr))
                  Row(
                    children: [
                      SizedBox(width: 16),
                      Text(
                        widget.error ??
                            widget.errorText ??
                            "Please ${widget.labelText}",
                        style: onestFonts.copyWith(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
