import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? initialValue;
  final String hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextStyle? hintStyle;
  final TextInputType? inputType;

  const CustomTextFormField({
    super.key,
    this.initialValue,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.onSaved,
    this.hintStyle,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            Theme.of(context).textTheme.bodyLarge?.apply(
                  fontSizeFactor: 0.9,
                ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
