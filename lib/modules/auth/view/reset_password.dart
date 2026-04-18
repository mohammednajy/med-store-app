import 'package:flutter/material.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../controller/auth_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/asset_path_manager.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const _Header(),

                      const SizedBox(height: 30),

                      _ResetCard(emailController: emailController),

                      const SizedBox(height: 20),
                    ],
                  ),
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
        Image.asset(AssetPathManager.forgetPassword, height: 100),
        const SizedBox(height: 10),
        Text(
          'استعادة كلمة المرور',
          style: context.h1.copyWith(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          'أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور',
          style: context.b1.copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ResetCard extends StatelessWidget {
  final TextEditingController emailController;

  const _ResetCard({required this.emailController});

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
              /// 📧 Email
              TextFieldWidget(
                controller: emailController,
                hintText: 'البريد الالكتروني',
                prefixIcon: Icons.email_outlined,
                validator: (value) => value!.isValidEmail,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              /// 🚀 Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (Form.of(context).validate()) {
                      context.read<AuthController>().sendEmailResetPassword(
                        email: emailController.text,
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
                    'استعادة',
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
