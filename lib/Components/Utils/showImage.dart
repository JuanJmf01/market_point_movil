import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, 
    this.imageAsset,
    this.networkImage,
    this.imageMemory,
    this.height,
    this.width,
    this.heightAsset,
    this.widthAsset,
    this.fit,
    this.color,
    this.borderRadius,
  });

  final Asset? imageAsset;
  final String? networkImage;
  final Uint8List? imageMemory;
  final double? height;
  final double? width;
  final int? heightAsset;
  final int? widthAsset;
  final BoxFit? fit;
  final Color? color;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final hasBorderRadius = borderRadius != null;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius:
              borderRadius
          ),
      child: ClipRRect(
        borderRadius:
            hasBorderRadius ? borderRadius! : BorderRadius.circular(0.0),
        child: imageAsset != null
            ? AssetThumb(
                asset: imageAsset!,
                width: widthAsset ?? 0,
                height: heightAsset ?? 0,
              )
            : Image.network(
                networkImage!,
                fit: fit,
              ),
      ),
    );
  }
}
