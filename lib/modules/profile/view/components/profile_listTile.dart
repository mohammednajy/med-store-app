
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/extentions.dart';

class ProfileCustomListTile extends StatelessWidget {
  const ProfileCustomListTile({
    this.onTap,
    required this.text,
    Key? key,
  }) : super(key: key);
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Text(
        text,
        style: context.b1.copyWith(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      trailing: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: const Icon(
          Icons.arrow_right_rounded,
          color: ColorManager.blue,
        ),
      ),
    );
  }
}