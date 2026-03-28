// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:medical_devices_app/core/utils/asset_path_manager.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String description;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingModel> onboardingContent = [
  OnBoardingModel(
      image: AssetPathManager.onboarding1,
      title: 'مرحبًا بك في متجر الأجهزة الطبية',
      description:
          'نحن هنا لتوفير أحدث وأفضل الأجهزة الطبية لتلبية احتياجاتك الصحية'),
  OnBoardingModel(
      image: AssetPathManager.onboarding2,
      title: 'منتجات عالية الجودة',
      description:
          'نقدم مجموعة متنوعة من الأجهزة الطبية ذات الجودة العالية والموثوقة، لضمان صحتك وراحتك'),
  OnBoardingModel(
      image: AssetPathManager.onboarding3,
      title: 'تجربة تسوق مريحة',
      description:
          'نحن نجعل عملية شراء الأجهزة الطبية سهلة ومريحة. اختر، اطلب، واستلم في المنزل'),
];
