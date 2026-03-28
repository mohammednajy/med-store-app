import 'package:flutter/material.dart';
import '../../../core/router/router.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/services/remote_services/firebase_init.dart';
import '../../../core/widgets/show_snackbar.dart';
import '../model/cart_model.dart';
import '../model/order_model.dart';

import '../../../core/services/local_services/shared_perf.dart';

class OrderController extends ChangeNotifier {
  FirebaseResponse<List<CartModel>> cart = FirebaseResponse.init();

  FirebaseResponse<List<OrderModel>> activeOrder = FirebaseResponse.init();
  FirebaseResponse<List<OrderModel>> completedOrder = FirebaseResponse.init();

  getCartDevices() async {
    try {
      cart = FirebaseResponse.loading('loading');
      notifyListeners();
      final snapshot = await getIt<FirebaseService>()
          .firestore
          .collection('cart')
          .where('userID', isEqualTo: SharedPrefController().getUser().userId)
          .get();
      cart = FirebaseResponse.completed(snapshot.docs.map((element) {
        return CartModel.fromSnapshot(element);
      }).toList());
      notifyListeners();
    } on Exception {
      cart = FirebaseResponse.error('something went wrong');
      notifyListeners();
    }
  }

  deleteOrder(String id) async {
    await getIt<FirebaseService>()
        .firestore
        .collection('cart')
        .doc(id)
        .delete()
        .then((value) {
      getCartDevices();
      showSnackBarCustom(text: 'تم الحذف بنجاح');
    }).onError((error, stackTrace) => showSnackBarCustom(text: 'لم يتم الحذف'));
  }

  completeOrder({required String address, required String mobile}) async {
    try {
      cart.data!.map((e) {
        getIt<FirebaseService>().firestore.collection('order').add({
          "status": "0",
          "info": {"phone": mobile, "address": address},
          ...e.toJson(),
        });
      }).toList();
      clearCart();
      getCartDevices();
      showSnackBarCustom(
        text: 'تم الاضافة بنجاح لقائمة الطلبات',
        backgroundColor: Colors.green,
      );
      NavigationManager.mayPop();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  clearCart() async {
    cart.data!
        .map((e) async => await getIt<FirebaseService>()
            .firestore
            .collection('cart')
            .doc(e.cartId)
            .delete())
        .toList();
    notifyListeners();
  }

  getActiveOrder() async {
    activeOrder = FirebaseResponse.loading('loading');
    notifyListeners();
    try {
      List<OrderModel> value = await getIt<FirebaseService>()
          .firestore
          .collection('order')
          .where('userID', isEqualTo: SharedPrefController().getUser().userId)
          .where('status', isEqualTo: "0")
          .get()
          .then((value) {
        return value.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
      });
      activeOrder = FirebaseResponse.completed(value);
      notifyListeners();
    } on Exception catch (e) {
      activeOrder = FirebaseResponse.error(e.toString());
      notifyListeners();
    }
  }

  getCompletedOrder() async {
    completedOrder = FirebaseResponse.loading('loading');
    notifyListeners();
    try {
      List<OrderModel> value = await getIt<FirebaseService>()
          .firestore
          .collection('order')
          .where('userID', isEqualTo: SharedPrefController().getUser().userId)
          .where('status', isEqualTo: "1")
          .get()
          .then((value) {
        return value.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
      });
      completedOrder = FirebaseResponse.completed(value);
      notifyListeners();
    } on Exception catch (e) {
      completedOrder = FirebaseResponse.error(e.toString());
      notifyListeners();
    }
  }
}
