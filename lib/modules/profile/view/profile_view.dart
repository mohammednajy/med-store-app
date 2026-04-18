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
      backgroundColor: const Color(0xFFF8F9FA),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          const PersonalCardInfo(),
          const SizedBox(height: 24),

          // Settings Section
          Text(
            'الإعدادات والدعم',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  ProfileCustomListTile(
                    icon: Icons.mail_outline,
                    text: 'تواصل معنا',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.contactUsView);
                    },
                  ),
                  Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
                  ProfileCustomListTile(
                    icon: Icons.info_outline,
                    text: 'عن التطبيق',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.aboutAppView);
                    },
                  ),
                  Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
                  ProfileCustomListTile(
                    icon: Icons.description_outlined,
                    text: 'سياسة الاستخدام',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.usesPoliceView);
                    },
                  ),
                  Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
                  ProfileCustomListTile(
                    icon: Icons.security_outlined,
                    text: 'سياسة الخصوصية',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.privacyPoliceView);
                    },
                  ),
                  Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
                  ProfileCustomListTile(
                    icon: Icons.help_outline,
                    text: 'الأسئلة الشائعة',
                    onTap: () {
                      NavigationManager.pushNamed(RouteName.faqView);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Logout Section
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    var value = await customDialogWidget(
                      context,
                      message: 'هل انت متأكد من تسجيل الخروج؟',
                    );
                    if (value == true) {
                      context.read<ProfileController>().logOut();
                    }
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.logout_outlined,
                            color: Colors.red.shade600,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'تسجيل الخروج',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Colors.red.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.red.withOpacity(0.4),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
