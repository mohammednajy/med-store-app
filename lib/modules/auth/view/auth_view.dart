import 'package:flutter/material.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/utils/asset_path_manager.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extentions.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: height / 9,
          ),
          Text(
            'أَهْلًا وَسَهْلًا 🤩',
            style: context.h1.copyWith(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'أهلاً بك في أفضل تطبيق لشراء الأجهزة الطبية. نقدم لك تجربة تسوق مريحة وآمنة لاحتياجات صحتك.',
            style: context.b1.copyWith(
              color: Colors.black45,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height / 9,
          ),
          SizedBox(
              height: height / 3.5,
              child: Image.asset(
                AssetPathManager.authImage,
                fit: BoxFit.fitHeight,
              )),
          SizedBox(
            height: height / 8.3,
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  NavigationManager.goToAndRemove(RouteName.login);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: ColorManager.blue,
                        ))),
                child: const Text(
                  'تسجيل دخول',
                  style: TextStyle(
                    color: ColorManager.blue,
                  ),
                ),
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  NavigationManager.goToAndRemove(RouteName.register);
                },
                child: const Text('انشاء حساب', style: TextStyle(color: Colors.white),),
              )),
            ],
          )
        ],
      ),
    );
  }
}
