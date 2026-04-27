import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/services/local_services/shared_perf.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../controller/auth_controller.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
        builder: (context, auth, child) {
          return Stack(
            children: [
              /// 🔵 Background
              const _Background(),

              /// 📄 Content
              SafeArea(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),

                        /// 🏷 Header
                        const _Header(),

                        const SizedBox(height: 40),

                        /// 🧾 Form Card
                        _FormCard(
                          emailController: emailController,
                          passwordController: passwordController,
                          formKey: formKey,
                        ),

                        const SizedBox(height: 30),

                        /// 🔗 Register
                        _RegisterSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF4A90E2), Color(0xFF6FB1FC)],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.medical_services, size: 60, color: Colors.white),
        const SizedBox(height: 10),
        Text(
          'مرحباً بك',
          style: context.h1.copyWith(color: Colors.white, fontSize: 24),
        ),
        const SizedBox(height: 5),
        Text(
          'قم بتسجيل الدخول للمتابعة',
          style: context.b1.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

class _FormCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const _FormCard({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 📧 Email
          TextFieldWidget(
            controller: emailController,
            hintText: 'البريد الالكتروني',
            prefixIcon: Icons.email_outlined,
            validator: (value) => value!.isValidEmail,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 15),

          /// 🔒 Password
          TextFieldWidget(
            controller: passwordController,
            isPassword: true,
            hintText: 'كلمة المرور',
            prefixIcon: Icons.lock_outline,
            validator: (value) => value!.isValidPassword,
          ),

          /// ❓ Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                NavigationManager.pushNamed(RouteName.forgetPassword);
              },
              child: const Text(
                'هل نسيت كلمة المرور؟',
                style: TextStyle(color: ColorManager.blue),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// 🚀 Login Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthController>().login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'تسجيل دخول',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                SharedPrefController().setGuestUser(value: true);
                NavigationManager.goToAndRemove(RouteName.mainAppView);
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'الدخول كزائر',
                style: TextStyle(color: ColorManager.blue, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterSection extends StatelessWidget {
  const _RegisterSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('ليس لديك حساب؟', style: context.l1),
        const SizedBox(height: 10),
        SecondaryButtonWidget(
          onPressed: () {
            NavigationManager.pushNamedReplacement(RouteName.register);
          },
          text: 'سجل الآن!',
        ),
      ],
    );
  }
}
