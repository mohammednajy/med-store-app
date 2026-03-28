// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:medical_devices_app/modules/home/model/device_model.dart';

class OrderModel {
  final String orderId;
  final String phone;
  final String address;
  final String userId;
  final String status;

  final DeviceModel deviceModel;
  OrderModel(
      {required this.orderId,
      required this.phone,
      required this.address,
      required this.userId,
      required this.deviceModel,
      required this.status});

  factory OrderModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return OrderModel(
      orderId: snapshot.id,
      address: snapshot['info']['address'],
      phone: snapshot['info']['phone'],
      userId: snapshot['userID'],
      status: snapshot['status'],
      deviceModel: DeviceModel.fromJson(snapshot['product']),
    );
  }

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, phone: $phone, address: $address, userId: $userId, status: $status, deviceModel: $deviceModel)';
  }
}
