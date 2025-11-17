# MegaStation iOS Deployment Guide
# ==================================================

## 📋 المعلومات الحالية

**اسم التطبيق:** MegaStation  
**Bundle ID:** com.midnet.ecommerce.mega  
**الإصدار:** 8.0.1 (Build 11)  
**iOS Target:** 12.0+

---

## 🔧 المتطلبات الأساسية

### 1. حساب Apple Developer
- [ ] حساب Apple Developer نشط ($99/سنة)
- [ ] تسجيل الدخول في Xcode
- [ ] App ID مسجل في Developer Portal

### 2. الشهادات والملفات
- [ ] Distribution Certificate
- [ ] App Store Provisioning Profile
- [ ] Push Notification Certificate (للإشعارات)

---

## 🚀 خطوات النشر

### الخطوة 1: إعداد المشروع

1. **افتح المشروع على Mac:**
   ```bash
   cd "D:\app\11\6ammart\User app and web"
   ```

2. **نفذ سكريبت البناء:**
   ```bash
   chmod +x build_ios.sh
   ./build_ios.sh
   ```

### الخطوة 2: إعداد Xcode

1. **افتح Xcode workspace:**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **تحقق من الإعدادات في Xcode:**
   - اذهب إلى **Runner** (في Project Navigator)
   - اختر **Signing & Capabilities**
   - حدد **Team** الخاص بك
   - تأكد من **Bundle Identifier:** `com.midnet.ecommerce.mega`
   - فعّل **Automatically manage signing**

3. **راجع Build Settings:**
   - **iOS Deployment Target:** 12.0 أو أحدث
   - **Display Name:** MegaStation
   - **Version:** 8.0.1
   - **Build:** 11 (زوّد الرقم لكل رفع جديد)

### الخطوة 3: التحقق من الأيقونات

1. في Xcode، اذهب إلى:
   ```
   Runner > Assets.xcassets > AppIcon
   ```

2. تأكد من وجود جميع أحجام الأيقونات:
   - iPhone: 20pt, 29pt, 40pt, 60pt (2x & 3x)
   - iPad: 20pt, 29pt, 40pt, 76pt, 83.5pt
   - App Store: 1024x1024

### الخطوة 4: بناء Archive

1. في Xcode:
   - اختر **Any iOS Device** من قائمة الأجهزة
   - اذهب إلى **Product → Archive**
   - انتظر حتى يكتمل البناء

2. عند الانتهاء، سيفتح Organizer تلقائياً

### الخطوة 5: رفع إلى App Store Connect

1. في **Organizer:**
   - اختر آخر Archive
   - انقر **Distribute App**
   - اختر **App Store Connect**
   - اختر **Upload**
   - اتبع الخطوات

2. أو استخدم **Transporter:**
   - افتح تطبيق Transporter
   - اسحب ملف IPA
   - انقر **Deliver**

---

## 📱 إعداد App Store Connect

### 1. إنشاء App في App Store Connect

1. اذهب إلى: https://appstoreconnect.apple.com
2. انقر **My Apps → + → New App**
3. املأ المعلومات:
   - **Platform:** iOS
   - **Name:** MegaStation
   - **Primary Language:** Arabic (أو English)
   - **Bundle ID:** com.midnet.ecommerce.mega
   - **SKU:** megastation-user-app

### 2. معلومات التطبيق المطلوبة

#### Screenshots (لقطات الشاشة)
- **iPhone 6.7"** (iPhone 15 Pro Max): 1290 x 2796 pixels (3-10 screenshots)
- **iPhone 6.5"** (iPhone 11 Pro Max): 1242 x 2688 pixels (3-10 screenshots)
- **iPad Pro 12.9"**: 2048 x 2732 pixels (optional)

#### App Information
- **App Name:** MegaStation
- **Subtitle:** Multi-vendor Delivery Service
- **Description:** [وصف مفصل للتطبيق]
- **Keywords:** food delivery, grocery, ecommerce, pharmacy, parcel
- **Support URL:** [رابط الدعم]
- **Marketing URL:** [رابط التسويق] (optional)

#### Privacy Policy
- **Privacy Policy URL:** [مطلوب]

#### App Review Information
- **Contact Information**
- **Demo Account** (إذا كان التطبيق يحتاج تسجيل دخول)
- **Notes:** [ملاحظات للمراجعين]

#### Age Rating
- قم بالإجابة على استبيان Age Rating

### 3. إعداد Build

1. بعد رفع Build عبر Xcode:
   - انتظر معالجة Build (5-15 دقيقة)
   - اذهب إلى **App Store → TestFlight**
   - اختر Build
   - أضف **Export Compliance Information**
   - أضف Build إلى Version

2. في **App Store tab:**
   - اختر **+ Version or Platform**
   - أضف Version جديد
   - اختر Build
   - املأ **What's New in This Version**

---

## 🔍 Checklist قبل النشر

### إعدادات تقنية
- [ ] Bundle ID صحيح ومسجل
- [ ] Version & Build Number محدثين
- [ ] App Icons بجميع الأحجام
- [ ] Launch Screen معدة
- [ ] Info.plist يحتوي على جميع Permissions
- [ ] Firebase معد بشكل صحيح
- [ ] Google Sign-In معد
- [ ] Facebook Login معد
- [ ] Apple Sign In مفعل
- [ ] Push Notifications مفعلة

### محتوى App Store
- [ ] Screenshots لجميع الأحجام
- [ ] App Icon 1024x1024
- [ ] Description و Keywords
- [ ] Privacy Policy URL
- [ ] Support URL
- [ ] Demo Account (إذا لزم)
- [ ] Age Rating

### اختبارات
- [ ] اختبار على أجهزة حقيقية
- [ ] اختبار جميع المزايا
- [ ] اختبار Sign In/Sign Up
- [ ] اختبار Payments
- [ ] اختبار Push Notifications
- [ ] اختبار في Dark Mode
- [ ] اختبار على iOS versions مختلفة

---

## 🛠️ أوامر مفيدة

### تحديث Pod dependencies
```bash
cd ios
pod repo update
pod install
cd ..
```

### بناء للاختبار
```bash
flutter build ios --debug
```

### بناء للإصدار
```bash
flutter build ipa --release
```

### فتح Xcode
```bash
open ios/Runner.xcworkspace
```

### عرض Devices المتصلة
```bash
flutter devices
```

### تشغيل على iPhone محدد
```bash
flutter run -d <device-id>
```

---

## ⚠️ مشاكل شائعة وحلولها

### مشكلة: Pod install يفشل
```bash
cd ios
pod repo update
pod deintegrate
pod install
```

### مشكلة: Signing Error
- تأكد من تسجيل الدخول في Xcode
- تحقق من Certificates في Xcode Preferences
- جرب "Automatically manage signing"

### مشكلة: Build يفشل
```bash
flutter clean
flutter pub get
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter build ios
```

### مشكلة: Archive يفشل
- تأكد من اختيار "Any iOS Device"
- تحقق من Build Settings
- راجع Error log في Xcode

---

## 📞 روابط مفيدة

- **App Store Connect:** https://appstoreconnect.apple.com
- **Apple Developer Portal:** https://developer.apple.com
- **Flutter iOS Deployment:** https://docs.flutter.dev/deployment/ios
- **App Store Guidelines:** https://developer.apple.com/app-store/review/guidelines/

---

## 📝 ملاحظات

1. **أول نشر:** يستغرق عادة 24-48 ساعة للمراجعة
2. **التحديثات:** تستغرق 24 ساعة تقريباً
3. **TestFlight:** يمكن استخدامه للاختبار قبل النشر
4. **Build Number:** يجب أن يكون فريداً لكل رفع

---

## 🎯 Next Steps

بعد اتباع هذا الدليل:
1. ✅ قم برفع Build الأول
2. ✅ اختبر عبر TestFlight
3. ✅ أكمل معلومات App Store Connect
4. ✅ قدم للمراجعة
5. ✅ انتظر الموافقة
6. ✅ انشر التطبيق! 🎉
