// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_devices_app/modules/home/model/device_model.dart';

class OrderModel {
  final String orderId;
  final String phone;
  final String address;
  final String userId;
  final String status;
  final DateTime? createdAt;

  final List<DeviceModel> devices; // ✅ changed

  OrderModel({
    required this.orderId,
    required this.phone,
    required this.address,
    required this.userId,
    required this.status,
    required this.devices,
    this.createdAt,
  });

  factory OrderModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      orderId: snapshot.id,
      address: data['info']?['address'] ?? '',
      phone: data['info']?['phone'] ?? '',
      userId: data['userID'] ?? '',
      status: data['status'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      // ✅ map devices list correctly
      devices: (data['devices'] as List<dynamic>? ?? []).map((e) {
        final product = e['product']; // because structure has "product"
        return DeviceModel.fromJson(product);
      }).toList(),
    );
  }

  @override
  String toString() {
    return '''
OrderModel(
  orderId: $orderId,
  phone: $phone,
  address: $address,
  userId: $userId,
  status: $status,
  devices: $devices,
  createdAt: $createdAt
)
''';
  }
}
