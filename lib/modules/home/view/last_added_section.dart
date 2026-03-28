import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/utils/extentions.dart';
import 'package:provider/provider.dart';
// import 'package:skeletons/skeletons.dart';

import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';
import '../controller/home_controller.dart';

class LastAddedSection extends StatelessWidget {
  const LastAddedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeProvider, child) {
        return SizedBox(
          height: 190,
          child: ListView.separated(
            padding: const EdgeInsets.only(right: 20),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (homeProvider.lastAddedDevices.status == Status.COMPLETED) {
                return InkWell(
                  onTap: () {
                    NavigationManager.pushNamed(
                      RouteName.devicesDetailsView,
                      arguments: homeProvider.lastAddedDevices.data![index],
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
                          imageUrl:
                              homeProvider.lastAddedDevices.data![index].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        homeProvider.lastAddedDevices.data![index].name,
                        style: context.b1.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'USD ${homeProvider.lastAddedDevices.data![index].price}',
                        style: context.b1.copyWith(
                          color: ColorManager.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (homeProvider.lastAddedDevices.status == Status.ERROR) {
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
