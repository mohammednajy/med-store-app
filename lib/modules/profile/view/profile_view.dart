import 'package:flutter/material.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/widgets/appbar_custom.dart';
import '../../../core/widgets/dialog_custome.dart';
import '../controller/profile_controller.dart';
import 'components/personal_cart.dart';
import 'components/profile_listTile.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'الملف الشخصي'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        children: [
          const PersonalCardInfo(),
          const SizedBox(
            height: 16,
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(top: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  ProfileCustomListTile(
                    text: 'تواصل معنا',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.contactUsView);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'عن التطبيق',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.aboutAppView);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'سياسية الاستخدام',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.usesPoliceView);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'سياسية الخصوصية',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.privacyPoliceView);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  ProfileCustomListTile(
                    text: 'الأسئلة الشائعة',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.faqView);
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(top: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              onTap: () async {
                var value = await customDialogWidget(context,
                    message: 'هل انت متاكد من تسجيل الخروج');
                if (value == true) {
                  context.read<ProfileController>().logOut();
                }
              },
              title: const Text(
                'تسجيل الخروح',
              ),
              trailing: Container(
                  height: 22,
                  width: 22,
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.logout_outlined,
                    size: 15,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
