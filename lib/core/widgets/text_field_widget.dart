import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.validator,
      this.controller,
      this.keyboardType,
      this.keyField,
      this.isPassword = false});
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final Key? keyField;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType? keyboardType;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.keyField,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? isVisible : false,
      decoration: InputDecoration(
          label: Text(widget.hintText),
          prefixIcon: Icon(
            widget.prefixIcon,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon:
                      Icon(isVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                )
              : null),
    );
  }
}
