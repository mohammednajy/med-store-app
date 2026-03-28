import 'package:flutter/material.dart';
import 'package:medical_devices_app/core/widgets/netwrok_image_widget.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/extentions.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/appbar_custom.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../controller/order_controller.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OrderController>().getCartDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'السلة'),
      body: Consumer<OrderController>(
        builder: (context, orderController, child) {
          if (orderController.cart.status == Status.COMPLETED) {
            if (orderController.cart.data!.isEmpty) {
              return Center(
                child: Text(
                  'لا يوجد عناصر في السلة',
                  style: context.h1.copyWith(color: ColorManager.blue),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    itemCount: orderController.cart.data!.length,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            margin: const EdgeInsets.only(left: 15),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: NetworkCustomImageWidget(
                              height: 75,
                              imageUrl: orderController
                                  .cart
                                  .data![index]
                                  .device
                                  .image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderController.cart.data![index].device.name,
                                style: context.h1.copyWith(fontSize: 17),
                              ),
                              Text(
                                '${orderController.cart.data![index].device.price} \$',
                                style: context.b1.copyWith(
                                  color: ColorManager.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              orderController.deleteOrder(
                                orderController.cart.data![index].cartId,
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Total price: ${orderController.cart.data!.fold(0, (sum, product) => sum + int.parse(product.device.price))}',
                        style: context.h1.copyWith(fontSize: 22),
                      ),
                      Text(
                        'Total items: ${orderController.cart.data!.length}',
                        style: context.b1.copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                left: 26,
                                right: 26,
                                top: 20,
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'تفاصيل الطلب',
                                      style: context.h1.copyWith(
                                        color: ColorManager.blue,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFieldWidget(
                                      controller: mobileController,
                                      hintText: 'رقم الجوال',
                                      prefixIcon: Icons.phone_iphone_outlined,
                                      validator: (value) => value!.isValidPhone,
                                      keyboardType: TextInputType.phone,
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      minLines: 2,
                                      maxLines: 2,
                                      controller: addressController,
                                      validator: (value) =>
                                          value!.isNotEmptyField,
                                      decoration: const InputDecoration(
                                        label: Text('تفاصيل العنوان'),
                                        hintText:
                                            'ادخل تفاصيل العنوان كاملا ، المدينة ، الحي ، الشارع ....',
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          context
                                              .read<OrderController>()
                                              .completeOrder(
                                                address: addressController.text,
                                                mobile: mobileController.text,
                                              );
                                        }
                                      },
                                      child: const Text(
                                        'تاكيد',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'تاكيد الطلب',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          } else if (orderController.cart.status == Status.ERROR) {
            return const Text('something went wrong');
          } else {
            return loading();
          }
        },
      ),
    );
  }
}
