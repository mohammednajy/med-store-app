import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/router/router.dart';
import '../../../core/services/local_services/shared_perf.dart';
import '../../../core/services/remote_services/base_model.dart';
import '../../../core/services/remote_services/firebase_init.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/show_snackbar.dart';
import '../model/category_model.dart';
import '../../home/model/device_model.dart';

class CategoryController extends ChangeNotifier {
  FirebaseResponse<List<CategoryModel>> categories = FirebaseResponse.init();
  FirebaseResponse<List<DeviceModel>> devices = FirebaseResponse.init();
  FirebaseResponse<List<DeviceModel>> lastAddedDevices =
      FirebaseResponse.init();
  Future<FirebaseResponse> getCategory() async {
    categories = FirebaseResponse.loading('loading');
    notifyListeners();
    await getIt<FirebaseService>().firestore.collection('Category').get().then(
      (QuerySnapshot value) {
        categories = FirebaseResponse.completed(value.docs
            .map((element) => CategoryModel.fromSnapshot(element))
            .toList());
        notifyListeners();
      },
    ).onError((error, stackTrace) {
      categories = FirebaseResponse.error(error.toString());
      notifyListeners();
    }).catchError((e) {
      categories = FirebaseResponse.error(e.toString());
      notifyListeners();
    });
    return categories;
  }

  getDevices(String categoryId) async {
    await getIt<FirebaseService>()
        .firestore
        .collection('devices')
        .where('categoryId', isEqualTo: categoryId)
        .get()
        .then((value) {
      devices = FirebaseResponse.completed(value.docs.map((element) {
        return DeviceModel.fromSnapshot(element);
      }).toList());
      notifyListeners();
    }).onError((error, stackTrace) {
      devices = FirebaseResponse.error(error.toString());
      notifyListeners();
    }).catchError((e) {
      devices = FirebaseResponse.error(e.toString());
      notifyListeners();
    });
  }

  Future<FirebaseResponse> getLastAddedDevices() async {
    lastAddedDevices = FirebaseResponse.loading('loading');
    notifyListeners();
    await getIt<FirebaseService>().firestore.collection('lastAdded').get().then(
      (QuerySnapshot value) {
        lastAddedDevices = FirebaseResponse.completed(value.docs.map((element) {
          return DeviceModel.fromSnapshot(element);
        }).toList());
        notifyListeners();
      },
    ).onError((error, stackTrace) {
      lastAddedDevices = FirebaseResponse.error(error.toString());
      notifyListeners();
    }).catchError((e) {
      lastAddedDevices = FirebaseResponse.error(e.toString());
      notifyListeners();
    });
    return lastAddedDevices;
  }

  addToCart(DeviceModel deviceModel) {
    loadingWithText(text: 'اضافة للسلة...');
    getIt<FirebaseService>().firestore.collection('cart').add({
      "userID": SharedPrefController().getUser().userId,
      "product": deviceModel.toJson()
    }).whenComplete(() {
      NavigationManager.mayPop();
      showSnackBarCustom(
        text: '✅ تم الاضافة بنجاح ✅',
        backgroundColor: Colors.green,
      );
    }).onError((error, stackTrace) {
      NavigationManager.mayPop();
      return showSnackBarCustom(
        text: 'حدث خطا ما',
      );
    }).catchError((e) {
      NavigationManager.mayPop();
      return showSnackBarCustom(
        text: 'حدث خطا ما',
      );
    });
  }
}
