import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/home_controller.dart';
import '../model/device_model.dart';
import 'package:provider/provider.dart';

import '../../../core/router/router.dart';

class DevicesSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close, color: Colors.black),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back, color: Colors.black),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<DeviceModel> devices = context
        .read<HomeController>()
        .devices
        .data!
        .where((e) => e.name.startsWith(query))
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('نتائج البحث', style: context.h1.copyWith(fontSize: 17)),
          const SizedBox(height: 15),
          devices.isEmpty
              ? Center(
                  child: Text(
                    'لا يوجد جهاز بهذا الاسم',
                    style: context.h1.copyWith(color: ColorManager.blue),
                  ),
                )
              : Expanded(child: SearchGridViewItems(devices: devices)),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<DeviceModel> devices = context
        .read<HomeController>()
        .devices
        .data!
        .where((e) => e.name.startsWith(query))
        .toList();
    return Consumer<HomeController>(
      builder: (context, homeProvider, child) {
        if (homeProvider.devices.status == Status.COMPLETED) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  query.isEmpty ? 'اقتراحات سريعة' : 'نتائج البحث',
                  style: context.h1.copyWith(fontSize: 17),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: SearchGridViewItems(
                    devices: query.isNotEmpty
                        ? devices
                        : homeProvider.devices.data!,
                  ),
                ),
              ],
            ),
          );
        } else if (homeProvider.devices.status == Status.ERROR) {
          return Text(homeProvider.devices.message ?? 'something went wrong');
        } else {
          return loading();
        }
      },
    );
  }
}

class SearchGridViewItems extends StatelessWidget {
  const SearchGridViewItems({super.key, required this.devices});

  final List<DeviceModel> devices;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: devices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            NavigationManager.pushNamed(
              RouteName.devicesDetailsView,
              arguments: devices[index],
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: NetworkCustomImageWidget(
                    height: 120,
                    imageUrl: devices[index].image,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  devices[index].name,
                  style: context.b1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'USD ${devices[index].price}',
                  style: context.b1.copyWith(
                    color: ColorManager.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
