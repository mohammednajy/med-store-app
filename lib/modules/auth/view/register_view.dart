import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/secoundery_button_widget.dart';
import '../controller/auth_controller.dart';
import '../models/user_model.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
      body: Stack(
        children: [
          const _Background(),

          SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    /// 🏷 Header
                    const _Header(),

                    const SizedBox(height: 30),

                    /// 🧾 Form
                    _RegisterForm(
                      formKey: formKey,
                      nameController: nameController,
                      emailController: emailController,
                      mobileController: mobileController,
                      passwordController: passwordController,
                    ),

                    const SizedBox(height: 25),

                    /// 🔗 Login
                    const _LoginSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
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
          colors: [Color(0xFF4A90E2), Color(0xFF6FB1FC)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
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
        const Icon(Icons.person_add_alt_1, size: 60, color: Colors.white),
        const SizedBox(height: 10),
        Text(
          'إنشاء حساب',
          style: context.h1.copyWith(color: Colors.white, fontSize: 24),
        ),
        const SizedBox(height: 5),
        Text(
          'ابدأ رحلتك معنا الآن',
          style: context.b1.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

class _RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;

  const _RegisterForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, child) {
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
              /// 👤 Name
              TextFieldWidget(
                controller: nameController,
                hintText: 'اسم المستخدم',
                prefixIcon: Icons.person_outline,
                validator: (value) => value!.isValidName,
              ),

              const SizedBox(height: 15),

              /// 📧 Email
              TextFieldWidget(
                controller: emailController,
                hintText: 'البريد الالكتروني',
                prefixIcon: Icons.email_outlined,
                validator: (value) => value!.isValidEmail,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 15),

              /// 📱 Phone
              TextFieldWidget(
                controller: mobileController,
                hintText: 'رقم الجوال',
                prefixIcon: Icons.phone_iphone_outlined,
                validator: (value) => value!.isValidPhone,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 15),

              /// 🔒 Password
              TextFieldWidget(
                controller: passwordController,
                hintText: 'كلمة المرور',
                isPassword: true,
                prefixIcon: Icons.lock_outline,
                validator: (value) => value!.isValidPassword,
              ),

              const SizedBox(height: 20),

              /// 🚀 Register Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthController>().register(
                        UserModel(
                          name: nameController.text,
                          email: emailController.text,
                          phone: mobileController.text,
                          password: passwordController.text,
                        ),
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
                    'تسجيل مستخدم جديد',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoginSection extends StatelessWidget {
  const _LoginSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('لديك حساب؟', style: context.l1),
        const SizedBox(height: 10),
        SecondaryButtonWidget(
          onPressed: () {
            NavigationManager.pushNamedReplacement(RouteName.login);
          },
          text: 'تسجيل الدخول',
        ),
      ],
    );
  }
}
