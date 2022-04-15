import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PackageDelivery extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? color;
  const PackageDelivery({
    Key? key,
    this.image,
    this.width,
    this.height,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backgroundColor,
      ),
      child: SvgPicture.asset(
        image!,
        color: color,
      ),
    );
  }
}
