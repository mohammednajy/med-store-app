import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import 'package:medical_devices_app/modules/home/controller/favorite_controller.dart';
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
      backgroundColor: const Color(0xFFF8F9FA),
      body: Consumer<CategoryController>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.devices.status == Status.COMPLETED) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: categoryProvider.devices.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final device = categoryProvider.devices.data![index];
                final favController = context.watch<FavoriteController>();
                final isFav = favController.isFavorite(device.deviceId);
                return GestureDetector(
                  onTap: () {
                    NavigationManager.pushNamed(
                      RouteName.devicesDetailsView,
                      arguments: device,
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Image Container
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                                child: NetworkCustomImageWidget(
                                  height: 140,
                                  imageUrl: device.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Details Container
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Device Name
                                    Text(
                                      device.name,
                                      style: context.b1.copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // Price Badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorManager.blue.withOpacity(
                                          0.12,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '\$${device.price}',
                                        style: context.b1.copyWith(
                                          color: ColorManager.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: IconButton(
                          onPressed: () {
                            context.read<FavoriteController>().toggleFavorite(
                              device,
                            );
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(8),
                          ),
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (categoryProvider.devices.status == Status.ERROR) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.red.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'حدث خطأ',
                    style: context.h1.copyWith(color: Colors.red, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    categoryProvider.devices.message ?? 'فشل تحميل المنتجات',
                    style: context.b1.copyWith(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return loading();
          }
        },
      ),
    );
  }
}
