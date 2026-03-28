import 'package:flutter/material.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/utils/extentions.dart';

import '../../../core/utils/asset_path_manager.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/constant.dart';

class CheckingEmailView extends StatelessWidget {
  const CheckingEmailView({super.key});

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
            AssetPathManager.checkEmail,
            height: 150,
            width: 76,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'التحقق من البريد الالكتروني',
            style: context.h1.copyWith(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Text(
            'لقد قمنا بارسال رابط استعادة كلمة المرور الى بريدك الالكتروني٬ يرجى الضغط على الرابط هناك لاسترجاع كلمة المرور',
            textAlign: TextAlign.center,
            style: context.b1.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              NavigationManager.popUntil(RouteName.login);
            },
            child: const Text('الذهاب لتسجيل الدخول', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
