import 'package:flutter/material.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../controller/auth_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/asset_path_manager.dart';
import '../../../core/utils/constant.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _LoginViewState();
}

class _LoginViewState extends State<ResetPasswordView> {
  GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: ColorManager.blue,
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: height / 9,
          ),
          Image.asset(
            AssetPathManager.forgetPassword,
            height: 100,
            width: 76,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'استعادة كلمة المرور',
            style: context.h1.copyWith(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Text(
            'ادخل البريد الالكتروني المرتبط بحسابك لاستعادة كلمة المرور الخاصة بك',
            textAlign: TextAlign.center,
            style: context.b1.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            keyField: fieldKey,
            controller: emailController,
            hintText: 'البريد الالكتروني',
            prefixIcon: Icons.email_outlined,
            validator: (value) => value!.isValidEmail,
              keyboardType: TextInputType.emailAddress,

          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              if (fieldKey.currentState!.validate()) {
                context
                    .read<AuthController>()
                    .sendEmailResetPassword(email: emailController.text);
              }
            },
            child: const Text('استعادة', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
