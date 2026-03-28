import 'package:flutter/material.dart';
import '../../../core/utils/extentions.dart';
import '../controller/home_controller.dart';
import 'category_section.dart';
import 'last_added_section.dart';
import 'most_ordered_section.dart';
import 'search_delegate_devices.dart';
import '../../order/controller/order_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/appbar_custom.dart';
import '../../category/controller/category_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeController>().getDevices();
      context.read<CategoryController>().getCategory();
      context.read<HomeController>().getLastAddedDevices();
      context.read<HomeController>().getMostOrderedDevices();
      context.read<OrderController>().getCartDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(
          title: 'الرئيسية',
          showCart: true,
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.wait([
            context.read<CategoryController>().getCategory(),
            context.read<HomeController>().getLastAddedDevices(),
            context.read<HomeController>().getMostOrderedDevices(),
          ]),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  onTap: () {
                    showSearch(
                        context: context, delegate: DevicesSearchDelegate());
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'كلمة البحث هنا...',
                      prefixIcon: const Icon(Icons.search)),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'الفئات',
                  style: context.h1.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CategorySection(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'الأكثر طلباً',
                  style: context.h1.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const MostOrderedSection(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'المضافة حديثاً',
                  style: context.h1.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LastAddedSection(),
            ],
          ),
        ));
  }
}
