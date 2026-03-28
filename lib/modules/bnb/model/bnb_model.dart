// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BnbModel {
  final String text;
  final IconData icon;
  BnbModel({required this.text, required this.icon});
}

List<BnbModel> bnbContent = [
  BnbModel(text: 'الرئيسية', icon: Icons.home_filled),
  BnbModel(text: 'الفئات', icon: Icons.grid_view_rounded),
  BnbModel(text: 'طلباتي', icon: Icons.receipt_long_rounded),
  BnbModel(text: 'الملف الشخصي', icon: Icons.person_outline_rounded),
];
