import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyBoardType;
  final bool? autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? labelText;

  AppTextField({
    this.controller,
    this.hintText,
    this.hintStyle,
    this.fillColor,
    this.autoFocus,
    this.border,
    this.validator,
    this.inputFormatters,
    this.obscureText = false,
    this.keyBoardType,
    this.labelText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.fillColor ?? Colors.grey.shade200,
      ),
      child: TextFormField(
        autofocus: widget.autoFocus ?? false,
        keyboardType: widget.keyBoardType,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormatters ?? [],
        decoration: InputDecoration(
          labelText: widget.labelText,
          contentPadding: const EdgeInsets.all(16),
          border: widget.border ?? InputBorder.none,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
        ),
      ),
    );
  }
}
