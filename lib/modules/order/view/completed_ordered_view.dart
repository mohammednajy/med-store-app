import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import '../../../core/router/router.dart';
import '../../../core/router/routers_name.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/order_controller.dart';
import 'package:provider/provider.dart';

class CompletedOrderedView extends StatefulWidget {
  const CompletedOrderedView({super.key});

  @override
  State<CompletedOrderedView> createState() => _CompletedOrderedViewState();
}

class _CompletedOrderedViewState extends State<CompletedOrderedView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OrderController>().getCompletedOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, orderController, child) {
        if (orderController.completedOrder.status == Status.COMPLETED) {
          if (orderController.completedOrder.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 80,
                    color: ColorManager.blue.withOpacity(0.3),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'لا يوجد طلبات مستلمة',
                    style: context.h1.copyWith(
                      color: ColorManager.blue,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'لم تستلم أي طلبات حتى الآن',
                    style: context.b1.copyWith(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: orderController.completedOrder.data!.length,
            itemBuilder: (context, index) {
              final order = orderController.completedOrder.data![index];
              return GestureDetector(
                onTap: () {
                  NavigationManager.pushNamed(
                    RouteName.orderDetailsView,
                    arguments: order,
                  );
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.grey.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Product Image
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(left: 12),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade300,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: NetworkCustomImageWidget(
                            height: 100,
                            imageUrl: order.deviceModel.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.deviceModel.name,
                                style: context.h1.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorManager.blue.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '\$${order.deviceModel.price}',
                                  style: context.b1.copyWith(
                                    color: ColorManager.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Order Status Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'تم الاستلام',
                                  style: context.b1.copyWith(
                                    color: Colors.green.shade700,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (orderController.completedOrder.status == Status.ERROR) {
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
                  'فشل تحميل الطلبات',
                  style: context.b1.copyWith(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          );
        } else {
          return loading();
        }
      },
    );
  }
}
