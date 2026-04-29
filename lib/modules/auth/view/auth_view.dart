import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/services/local_services/shared_perf.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/utils/asset_path_manager.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Spacer(),

                  /// 🏷 Title
                  _Header(),

                  const SizedBox(height: 30),

                  /// 🖼 Image
                  _ImageSection(),

                  const Spacer(),

                  /// 🔘 Buttons
                  _Actions(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Image.asset(AssetPathManager.authImage, fit: BoxFit.contain),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'أهلاً وسهلاً 👋',
          style: context.h1.copyWith(fontSize: 26, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'أفضل تطبيق لشراء الأجهزة الطبية بسهولة وأمان',
          style: context.b1.copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🚀 Primary (Register)
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              NavigationManager.goToAndRemove(RouteName.register);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: ColorManager.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('إنشاء حساب'),
          ),
        ),

        const SizedBox(height: 12),

        /// 🔹 Secondary (Login)
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              NavigationManager.goToAndRemove(RouteName.login);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'تسجيل الدخول',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              SharedPrefController().setGuestUser(value: true);
              NavigationManager.goToAndRemove(RouteName.mainAppView);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'الدخول كزائر',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
