import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceModel {
  final String name;
  final String image;
  final String categoryId;
  final String price;
  final String details;
  final String deviceId;
  final String forUsage;
  final String note;
  final List<String> points;

  DeviceModel({
    required this.name,
    required this.image,
    required this.categoryId,
    required this.details,
    required this.price,
    required this.deviceId,
    required this.forUsage,
    required this.note,
    required this.points,
  });

  factory DeviceModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return DeviceModel(
      categoryId: snapshot['categoryId'],
      name: snapshot['name'],
      image: snapshot['image'],
      details: snapshot['details'],
      deviceId: snapshot.id,
      price: snapshot['price'],
      note: snapshot['note'],
      forUsage: snapshot['for'],
      points: List<String>.from(snapshot['points'] as List),
    );
  }

  factory DeviceModel.fromJson(Map<String, dynamic> map) {
    return DeviceModel(
      categoryId: map['categoryId'],
      name: map['name'],
      image: map['image'],
      details: map['details'],
      deviceId: map['deviceId'],
      price: map['price'],
      note: map['note'],
      forUsage: map['for'],
      points: List<String>.from(map['points'] as List),
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'categoryId': categoryId,
      'price': price,
      'details': details,
      'deviceId': deviceId,
      'for': forUsage,
      'note': note,
      'points': points,
    };
  }

  @override
  String toString() {
    return 'DeviceModel(name: $name, image: $image, categoryId: $categoryId, price: $price, details: $details, deviceId: $deviceId)';
  }
}
