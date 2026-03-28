import 'package:flutter/material.dart';
import '../utils/color_manager.dart';

class SecondaryButtonWidget extends StatelessWidget {
  const SecondaryButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.background,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: ColorManager.blue,
              ))),
      child: Text(
        text,
        style: TextStyle(
          color: ColorManager.blue,
        ),
      ),
    );
  }
}
