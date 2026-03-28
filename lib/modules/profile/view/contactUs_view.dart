import 'package:flutter/material.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/widgets/appbar_custom.dart';
import '../controller/profile_controller.dart';
import 'package:provider/provider.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'تواصل معنا'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            Text(
              'شكرًا لاستخدامكم متجرنا الإلكتروني للأجهزة الطبية. إذا كان لديك أي استفسارات أو تحتاج إلى مساعدة، فلا تتردد في التواصل معنا باستخدام الوسائل التالية: 😊 ',
              style: context.b1,
            ),
            const SizedBox(height: 30),
            ContactUsButton(
              icon: Icons.chat_bubble_outline,
              text: 'رسالة واتساب',
              onPressed: () {
                context.read<ProfileController>().whatsappSupport();
              },
            ),
            const SizedBox(height: 15),
            ContactUsButton(
              icon: Icons.call_outlined,
              text: 'مكالمة',
              onPressed: () {
                context.read<ProfileController>().callSupport();
              },
            ),
            const SizedBox(height: 15),
            ContactUsButton(
              icon: Icons.email_outlined,
              text: 'تواصل عبر الإيميل',
              onPressed: () {
                context.read<ProfileController>().emailSupport();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.text,
  });
  final IconData icon;
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          alignment: Alignment.centerRight,
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      label: Text(
        text,
        textAlign: TextAlign.right,
        style: context.h1.copyWith(fontSize: 17),
      ),
    );
  }
}
