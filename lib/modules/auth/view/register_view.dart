import 'package:flutter/material.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/secoundery_button_widget.dart';
import '../controller/auth_controller.dart';
import '../models/user_model.dart';
import 'components/header_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/widgets/text_field_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const HeaderWidget(
              title: 'مستخدم جديد',
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              controller: nameController,
              hintText: 'اسم المستخدم',
              prefixIcon: Icons.person_outline,
              validator: (value) => value!.isValidName,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              controller: emailController,
              hintText: 'البريد الالكتروني',
              prefixIcon: Icons.email_outlined,
              validator: (value) => value!.isValidEmail,
              keyboardType: TextInputType.emailAddress,

            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              controller: mobileController,
              hintText: 'رقم الجوال',
              prefixIcon: Icons.phone_iphone_outlined,
              validator: (value) => value!.isValidPhone,
              keyboardType: TextInputType.number,

            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              controller: passwordController,
              hintText: 'كلمة المرور',
              isPassword: true,
              prefixIcon: Icons.lock_outline,
              validator: (value) => value!.isValidPassword,
              keyboardType: TextInputType.text,

            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  context.read<AuthController>().register(UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        phone: mobileController.text,
                        password: passwordController.text,
                      ));
                }
              },
              child: const Text('تسجيل مستخدم جديد', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              ' لديك حساب؟',
              style: context.l1,
              textAlign: TextAlign.center,
            ),
            SecondaryButtonWidget(
              onPressed: () {
                NavigationManager.pushNamedReplacement(RouteName.login);
              },
              text: 'سجل الآن!',
            )
          ],
        ),
      ),
    );
  }
}
