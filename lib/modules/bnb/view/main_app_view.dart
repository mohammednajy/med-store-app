import 'package:flutter/material.dart';
import '../../../core/utils/color_manager.dart';
import '../controller/bnb_controller.dart';
import '../model/bnb_model.dart';
import '../../order/view/order_view.dart';
import 'package:provider/provider.dart';

import '../../category/view/category_view.dart';
import '../../home/view/home_view.dart';
import '../../profile/view/profile_view.dart';

class MainAppView extends StatelessWidget {
  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final bnbProvider = context.watch<BnbController>();
    return Scaffold(
      body: taps[bnbProvider.selectedTabIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: (value) {
            context.read<BnbController>().changeIndex(value);
          },
          currentIndex: bnbProvider.selectedTabIndex,
          selectedItemColor: ColorManager.blue,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorManager.blue,
          ),
          unselectedLabelStyle: Theme.of(context).textTheme.labelSmall
              ?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
              ),
          selectedIconTheme: const IconThemeData(
            color: ColorManager.blue,
            size: 28,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey.shade500,
            size: 24,
          ),
          items: bnbContent
              .map(
                (e) =>
                    BottomNavigationBarItem(icon: Icon(e.icon), label: e.text),
              )
              .toList(),
        ),
      ),
    );
  }
}

List<Widget> taps = [
  const HomeView(),
  const CategoryView(),
  const OrdersScreen(),
  const ProfileView(),
];
