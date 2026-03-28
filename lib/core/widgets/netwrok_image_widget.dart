import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_devices_app/core/utils/app_size_extension.dart';

class NetworkCustomImageWidget extends StatelessWidget {
  const NetworkCustomImageWidget({
    required this.imageUrl,
    required this.height,
    this.background = false,
    this.isSvg = false,
    this.fit = BoxFit.fill,
    this.width,
    super.key,
  });
  final String imageUrl;
  final double height;
  final bool background;
  final bool isSvg;
  final BoxFit fit;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height(height),
      width: width,
      child: isSvg
          ? Center(
              child: SvgPicture.network(
                imageUrl,
                placeholderBuilder: (BuildContext context) => Container(
                  alignment: Alignment.center,
                  height: context.height(height),
                  color: background ? Colors.grey.shade300 : null,
                  child: Center(child: CircularProgressIndicator()),
                ),
                height: context.height(height),
                fit: fit,
              ),
            )
          : Center(
              child: CachedNetworkImage(
                alignment: Alignment.center,
                imageUrl: imageUrl,
                fit: fit,
                width: double.infinity,
                placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  height: context.height(height) / 3,
                  color: background ? Colors.grey.shade300 : null,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 50),
              ),
            ),
    );
  }
}
