import 'package:flutter/material.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/widgets/appbar_custom.dart';
import 'active_order_view.dart';
import 'completed_ordered_view.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarCustom(
          height: 100,
          title: 'طلباتي',
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorManager.blue,
            labelStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'طلبات قيد التنفيذ',
              ),
              Tab(
                text: 'طلبات مستلمة',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveOrderView(),
            CompletedOrderedView(),
          ],
        ),
      ),
    );
  }
}
