import 'package:flutter_svg/flutter_svg.dart';

class SvgImageRepository {
  preCacheSvgPictures() async {
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/images/permissions/location_image.svg'),
      null,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/images/permissions/notification_image.svg'),
      null,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
          'assets/images/onboardings/onboarding_forth/onboarding_forth_background.svg'),
      null,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/images/order_receiving/background.svg'),
      null,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/images/order_receiving/receiving_dongu_logo.svg'),
      null,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/images/order_receiving/receiving_package_icon.svg'),
      null,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/images/food_waste/food_waste_symbol.svg'),
      null,
    );
  }
}
