import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/category_controller.dart';
import '../model/category_model.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/appbar_custom.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({super.key, required this.category});

  final CategoryModel category;

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryController>().getDevices(widget.category.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: widget.category.name),
      body: Consumer<CategoryController>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.devices.status == Status.COMPLETED) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: categoryProvider.devices.data!.length,
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
                      arguments: categoryProvider.devices.data![index],
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
                            imageUrl:
                                categoryProvider.devices.data![index].image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          categoryProvider.devices.data![index].name,
                          style: context.b1.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'USD ${categoryProvider.devices.data![index].price}',
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
          } else if (categoryProvider.devices.status == Status.ERROR) {
            return Text(
              categoryProvider.devices.message ?? 'something went wrong',
            );
          } else {
            return loading();
          }
        },
      ),
    );
  }
}
