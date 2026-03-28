import 'package:flutter/material.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../controller/auth_controller.dart';
import 'components/header_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/widgets/secoundery_button_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthController>(
        builder: (context, value, child) => Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const HeaderWidget(
                title: 'تسجيل الدخول',
              ),
              const SizedBox(
                height: 20,
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
                controller: passwordController,
                isPassword: true,
                hintText: 'كلمة المرور',
                prefixIcon: Icons.lock_outline,
                validator: (value) => value!.isValidPassword,
                keyboardType: TextInputType.text,
              ),
              TextButton(
                  onPressed: () {
                    NavigationManager.pushNamed(RouteName.forgetPassword);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerRight,
                  ),
                  child: const Text(
                    'هل نسيت كلمة المرور؟',
                    style: TextStyle(
                      color: ColorManager.blue,
                    ),
                    textAlign: TextAlign.end,
                  )),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthController>().login(
                        email: emailController.text,
                        password: passwordController.text);
                  }
                },
                child: const Text('تسجيل دخول', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                ' ليس لديك حساب؟',
                style: context.l1,
                textAlign: TextAlign.center,
              ),
              SecondaryButtonWidget(
                onPressed: () {
                  NavigationManager.pushNamedReplacement(RouteName.register);
                },
                text: 'سجل الآن!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
