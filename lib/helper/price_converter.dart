import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mega/features/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:mega/util/styles.dart';
import 'package:mega/features/language/controllers/language_controller.dart';

class PriceConverter {
  static String convertPrice(double? price, {double? discount, String? discountType, bool forDM = false, bool isFoodVariation = false, String? formatedStringPrice, bool forTaxi = false}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount' && !isFoodVariation) {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool isArabic = Get.find<LocalizationController>().locale.languageCode == 'ar';
    bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right' && !isArabic;

    if(forTaxi && price! > 100000) {
      return '${isRightSide ? '' : '${PriceConverter.currencySymbol()} '}'
          '${intl.NumberFormat.compact().format(price)}'
          '${isRightSide ? ' ${PriceConverter.currencySymbol()}' : ''}';
    }
    return '${isRightSide ? '' : '${PriceConverter.currencySymbol()} '}'
        '${formatedStringPrice ?? toFixed(price!).toStringAsFixed(forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${isRightSide ? ' ${PriceConverter.currencySymbol()}' : ''}';
  }

  static Widget convertAnimationPrice(double? price, {double? discount, String? discountType, bool forDM = false, TextStyle? textStyle}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool isArabic = Get.find<LocalizationController>().locale.languageCode == 'ar';
    bool isRightSide = isArabic ? false : Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';

    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedFlipCounter(
        duration: const Duration(milliseconds: 500),
        value: toFixed(price!),
        textStyle: textStyle ?? robotoMedium,
        fractionDigits: forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!,
        prefix: isRightSide ? '' : '${PriceConverter.currencySymbol()} ',
        suffix: isRightSide ? '${PriceConverter.currencySymbol()} ' : '',
      ),
    );
  }

  static double? convertWithDiscount(double? price, double? discount, String? discountType, {bool isFoodVariation = false}) {
    if(discountType == 'amount' && !isFoodVariation) {
      price = price! - discount!;
    }else if(discountType == 'percent') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double? discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount' || type == 'fixed') {
      calculatedAmount = discount! * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount! / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : PriceConverter.currencySymbol()} OFF';
  }

  static double toFixed(double val) {
    num mod = power(10, Get.find<SplashController>().configModel!.digitAfterDecimalPoint!);
    return (((val * mod).toPrecision(Get.find<SplashController>().configModel!.digitAfterDecimalPoint!)).floor().toDouble() / mod);
  }

  static int power(int x, int n) {
    int retval = 1;
    for (int i = 0; i < n; i++) {
      retval *= x;
    }
    return retval;
  }

  static String currencySymbol() {
    bool isArabic = Get.find<LocalizationController>().locale.languageCode == 'ar';
    return isArabic ? '﷼' : Get.find<SplashController>().configModel!.currencySymbol!;
  }
}
