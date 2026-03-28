import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/widgets/appbar_custom.dart';
import '../controller/category_controller.dart';
import '../../home/model/device_model.dart';
import '../../order/controller/order_controller.dart';
import 'package:provider/provider.dart';
// import 'package:skeletons/skeletons.dart';

class DeviceDetailsView extends StatefulWidget {
  const DeviceDetailsView({super.key, required this.deviceModel});
  final DeviceModel deviceModel;

  @override
  State<DeviceDetailsView> createState() => _DeviceDetailsViewState();
}

class _DeviceDetailsViewState extends State<DeviceDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoryController>().getLastAddedDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: widget.deviceModel.name),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 230,
                  child: NetworkCustomImageWidget(
                    height: 230,
                    imageUrl: widget.deviceModel.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.deviceModel.name, style: context.h1),
                      Text(
                        '${widget.deviceModel.price} \$',
                        style: context.h1.copyWith(color: ColorManager.blue),
                      ),
                      Text(
                        widget.deviceModel.details,
                        style: context.b1.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'منتجات ذات صلة',
                    style: context.h1.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<CategoryController>(
                  builder: (context, categoryController, child) {
                    return SizedBox(
                      height: 190,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(right: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          if (categoryController.lastAddedDevices.status ==
                              Status.COMPLETED) {
                            final device = categoryController
                                .lastAddedDevices
                                .data![index];
                            return InkWell(
                              onTap: () {
                                NavigationManager.pushNamedReplacement(
                                  RouteName.devicesDetailsView,
                                  arguments: device,
                                );
                              },
                              child: Column(
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
                                      imageUrl: device.image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    device.name,
                                    style: context.b1.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'USD ${device.price}',
                                    style: context.b1.copyWith(
                                      color: ColorManager.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (categoryController
                                  .lastAddedDevices
                                  .status ==
                              Status.ERROR) {
                            return const Icon(Icons.error, size: 50);
                          } else {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 16,
                                    width: 100,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 16,
                                    width: 60,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                context.read<CategoryController>().addToCart(
                  widget.deviceModel,
                );
                context.read<OrderController>().getCartDevices();
              },
              child: const Text(
                'اضافة للسلة',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
