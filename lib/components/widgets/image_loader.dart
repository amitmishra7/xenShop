
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xen_shop/components/util/app_constants.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final ImageType imageType;
  final bool showCircleImage;
  final bool roundCorners;
  final double borderRadius;
  final BoxFit boxFit;
  final Widget accreditedPlaceholder;

  ImageLoader.withImage(
      {Key key,
      @required this.imageUrl,
      @required this.imageType,
      @required this.showCircleImage,
      @required this.roundCorners,
      this.boxFit,
      this.borderRadius,
      this.accreditedPlaceholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case ImageType.ASSET:
        return loadAssetImage(context);
      case ImageType.NETWORK:
        return loadNetworkImage(context);
      default:
        return loadNetworkImage(context);
    }
  }

  Widget loadAssetImage(BuildContext context) {
    return ClipRRect(
      borderRadius: roundCorners != null && roundCorners
          ? BorderRadius.circular(borderRadius)
          : BorderRadius.circular(0),
      child: Container(
        decoration: BoxDecoration(
          shape: showCircleImage != null && showCircleImage
              ? BoxShape.circle
              : BoxShape.rectangle,
        ),
        child: Image.asset(
          imageUrl,
          fit: boxFit == null ? BoxFit.cover : boxFit,
          errorBuilder: (context, error, stackTrace) =>
              accreditedPlaceholder != null
                  ? accreditedPlaceholder
                  : _buildNoImageView(context),
        ),
      ),
    );
  }

  Widget _buildNoImageView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: showCircleImage ? BoxShape.circle : BoxShape.rectangle,
          color: Theme.of(context).scaffoldBackgroundColor),
    );
  }

  Widget loadNetworkImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: showCircleImage != null && showCircleImage
            ? BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: boxFit == null ? BoxFit.cover : boxFit,
                ),
              )
            : BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: roundCorners != null && roundCorners
                    ? BorderRadius.circular(borderRadius)
                    : BorderRadius.circular(10),
                image: DecorationImage(
                  image: imageProvider,
                  fit: boxFit == null ? BoxFit.cover : boxFit,
                ),
              ),
      ),
      placeholder: (context, url) => accreditedPlaceholder != null
          ? accreditedPlaceholder
          : _buildNoImageView(context),
      errorWidget: (context, url, error) => accreditedPlaceholder != null
          ? accreditedPlaceholder
          : _buildNoImageView(context),
    );
  }
}
