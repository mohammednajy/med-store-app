import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import 'package:medical_devices_app/modules/home/controller/favorite_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/utils/extentions.dart';
import '../controller/home_controller.dart';
import 'package:provider/provider.dart';
// import 'package:skeletons/skeletons.dart';

import '../../../core/router/router.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';

class MostOrderedSection extends StatelessWidget {
  const MostOrderedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeProvider, child) {
        return SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.only(right: 20),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (homeProvider.mostOrderedDevices.status == Status.COMPLETED) {
                final item = homeProvider.mostOrderedDevices.data![index];
                final favController = context.watch<FavoriteController>();
                final isFav = favController.isFavorite(item.deviceId);
                return InkWell(
                  onTap: () {
                    NavigationManager.pushNamed(
                      RouteName.devicesDetailsView,
                      arguments: homeProvider.mostOrderedDevices.data![index],
                    );
                  },
                  child: Stack(
                    alignment: AlignmentGeometry.topLeft,
                    children: [
                      Container(
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: NetworkCustomImageWidget(
                                height: 100,
                                imageUrl: item.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      item.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 1.0,
                                      style: context.b1.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'USD ${item.price}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.b1.copyWith(
                                        color: ColorManager.blue,
                                        fontWeight: FontWeight.bold,
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
                              item,
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
              } else if (homeProvider.mostOrderedDevices.status ==
                  Status.ERROR) {
                return const Icon(Icons.error, size: 50);
              } else {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image skeleton
                      Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Title skeleton
                      Container(
                        height: 14,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Price skeleton
                      Container(
                        height: 14,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        );
      },
    );
  }
}
