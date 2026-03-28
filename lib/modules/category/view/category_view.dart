import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/widgets/appbar_custom.dart';
import '../controller/category_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoryController>().getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'الفئات'),
      body: Consumer<CategoryController>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.categories.status == Status.COMPLETED) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: categoryProvider.categories.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final category = categoryProvider.categories.data![index];
                return InkWell(
                  onTap: () {
                    NavigationManager.pushNamed(
                      RouteName.devicesView,
                      arguments: category,
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NetworkCustomImageWidget(
                          height: 100,
                          imageUrl: category.image,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          category.name,
                          style: context.h1.copyWith(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (categoryProvider.categories.status == Status.ERROR) {
            return Center(
              child: Text(
                categoryProvider.categories.message ?? 'حدث خطأ ما',
                style: context.h1.copyWith(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            /// ⭐ Modern skeleton loading
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
