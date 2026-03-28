import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/extentions.dart';
import 'package:provider/provider.dart';
// import 'package:skeletons/skeletons.dart';

import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../category/controller/category_controller.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, categoryProvider, child) {
        return SizedBox(
          height: 60,
          child: ListView.separated(
            padding: const EdgeInsets.only(right: 20),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (categoryProvider.categories.status == Status.COMPLETED) {
                return InkWell(
                  onTap: () {
                    NavigationManager.pushNamed(
                      RouteName.devicesView,
                      arguments: categoryProvider.categories.data![index],
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: ColorManager.blue),
                    ),
                    child: Text(
                      categoryProvider.categories.data![index].name,
                      style: context.h1.copyWith(
                        color: ColorManager.blue,
                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              } else if (categoryProvider.categories.status == Status.ERROR) {
                return Text(
                  categoryProvider.categories.message ?? 'something went wrong',
                );
              } else {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
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
