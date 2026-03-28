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
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            context.read<BnbController>().changeIndex(value);
          },
          currentIndex: bnbProvider.selectedTabIndex,
          selectedItemColor: ColorManager.blue,
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          selectedLabelStyle: const TextStyle(color: Colors.black),
          items: bnbContent
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.icon,
                  ),
                  label: e.text,
                ),
              )
              .toList()),
    );
  }
}

List<Widget> taps = [
  const HomeView(),
  const CategoryView(),
  const OrdersScreen(),
  const ProfileView()
];
