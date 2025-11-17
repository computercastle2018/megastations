import 'package:mega/features/splash/controllers/splash_controller.dart';
import 'package:mega/helper/responsive_helper.dart';
import 'package:mega/util/dimensions.dart';
import 'package:mega/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega/helper/price_converter.dart';

class DiscountTag extends StatelessWidget {
  final double? discount;
  final String? discountType;
  final double fromTop;
  final double? fontSize;
  final bool inLeft;
  final bool? freeDelivery;
  final bool? isFloating;
  final bool? fromTaxi;
  const DiscountTag({super.key,
    required this.discount, required this.discountType, this.fromTop = 10, this.fontSize, this.freeDelivery = false,
    this.inLeft = true, this.isFloating = true, this.fromTaxi = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = Get.find<LocalizationController>().locale.languageCode == 'ar';
    bool isRightSide = !isArabic && Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
    String currencySymbol = PriceConverter.currencySymbol();

    return (discount! > 0 || freeDelivery!) ? Positioned(
      top: fromTop, left: inLeft ? isFloating! ? Dimensions.paddingSizeSmall : 0 : null, right: inLeft ? null : 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: fromTaxi! ? const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault))
              : BorderRadius.horizontal(
            right: Radius.circular(isFloating! ? Dimensions.radiusLarge : inLeft ? Dimensions.radiusSmall : 0),
            left: Radius.circular(isFloating! ? Dimensions.radiusLarge : inLeft ? 0 : Dimensions.radiusSmall),
          ),
        ),
        child: Text(
          discount! > 0 ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}$discount${discountType == 'percent' ? '%'
              : isRightSide ? currencySymbol : ''} ${'off'.tr}' : 'free_delivery'.tr,
          style: robotoMedium.copyWith(
            color: Colors.white,
            fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 8 : 12),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ) : const SizedBox();
  }
}
