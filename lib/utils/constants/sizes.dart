import 'package:flutter/material.dart';

class TSizes {
  TSizes._();

  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  /// Padding and Margin (responsive)
  static double xs(BuildContext context) => screenWidth(context) * 0.01;
  static double sm(BuildContext context) => screenWidth(context) * 0.02;
  static double md(BuildContext context) => screenWidth(context) * 0.04;
  static double lg(BuildContext context) => screenWidth(context) * 0.06;
  static double xl(BuildContext context) => screenWidth(context) * 0.08;

  /// Icon Sizes
  static double iconSm(BuildContext context) => screenWidth(context) * 0.035;
  static double iconMd(BuildContext context) => screenWidth(context) * 0.06;
  static double iconLg(BuildContext context) => screenWidth(context) * 0.08;


  /// Font Sizes
  static double fontSizeSm(BuildContext context) => screenWidth(context) * 0.035;
  static double fontSizeMd(BuildContext context) => screenWidth(context) * 0.04;
  static double fontSizeLg(BuildContext context) => screenWidth(context) * 0.045;

  /// Button Sizes
  static double buttonRadius(BuildContext context) => screenWidth(context) * 0.03;
  static double buttonWidth(BuildContext context) => screenWidth(context) * 0.4;
  static double buttonElevation = 4.0;

  /// AppBar Height
  static double appBarHeight = 56;

  /// Image Sizes
  static double imageThumbSize(BuildContext context) => screenWidth(context) * 0.2;

  /// Spacing
  static double defaultSpace(BuildContext context) => screenWidth(context) * 0.062;
  static double spaceBtwItems(BuildContext context) => screenWidth(context) * 0.04;
  static double spaceBtwSections(BuildContext context) => screenWidth(context) * 0.08;

  /// Border Radius
  static double borderRadiusSm(BuildContext context) => screenWidth(context) * 0.015;
  static double borderRadiusMd(BuildContext context) => screenWidth(context) * 0.025;
  static double borderRadiusLg(BuildContext context) => screenWidth(context) * 0.03;

  /// Product Sizes
  static double productImageSize(BuildContext context) => screenWidth(context) * 0.3;
  static double productImageRadius(BuildContext context) => screenWidth(context) * 0.04;
  static double productItemHeight(BuildContext context) => screenHeight(context) * 0.25;

  /// Input Field
  static double inputFieldRadius(BuildContext context) => screenWidth(context) * 0.03;
  static double spaceBtwInputFields(BuildContext context) => screenWidth(context) * 0.048;

  /// Card Sizes
  static double cardRadiusLg(BuildContext context) => screenWidth(context) * 0.04;
  static double cardRadiusMd(BuildContext context) => screenWidth(context) * 0.03;
  static double cardRadiusSm(BuildContext context) => screenWidth(context) * 0.025;
  static double cardRadiusXs(BuildContext context) => screenWidth(context) * 0.015;
  static double cardElevation = 2.0;

  /// Image Carousel
  static double imageCarouselHeight(BuildContext context) => screenHeight(context) * 0.25;

  /// Loader
  static double loaderIndicatorSize(BuildContext context) => screenWidth(context) * 0.1;

  /// GridView
  static double gridViewSpacing(BuildContext context) => screenWidth(context) * 0.04;
}


// import 'package:flutter/material.dart';
// class TSizes{
//   TSizes._();
//
//   /// Padding and margin Sizes
//   static const double xs = 4.0;
//   static const double sm = 8.0;
//   static const double md = 16.0;
//   static const double lg = 24.0;
//   static const double xl = 32.0;
//
//   /// Icon Sizes
//   static const double iconXs = 12.0;
//   static const double iconSm = 16.0;
//   static const double iconMd = 24.0;
//   static const double iconLg = 32.0;
//
//   /// Font Sizes
//   static const double fontSizeSm = 14.0;
//   static const double fontSizeMd = 16.0;
//   static const double fontSizeLg = 18.0;
//
//   /// Button Sizes
//   static const double buttonRadius = 12;
//   static const double buttonWidth = 120;
//   static const double buttonElevation = 4.0;
//
// /// AppBar Height
//   static const double appBarHeight = 56;
//
// /// Image Sizes
//   static const imageThumbSize = 80;
//
// /// Default Spacing between sections
//   static const double defaultSpace = 24.0;
//   static const  double spaceBtwItems = 16.0;
//   static const double spaceBtwSections = 32.0;
//
// /// Border radius
//   static const double borderRadiusSm = 4.0;
//   static const double borderRadiusMd = 8.0;
//   static const double borderRadiusLg = 12.0;
//
// /// Divider height
//   static const double dividerHeight = 1.0;
//
// /// Product item dimensions
//   static const double productImageSize = 120.0;
//   static const double productImageRadius = 16.0;
//   static const double productItemHeight = 160.0;
//
// /// Input field
//   static const double inputFieldRadius = 12.0;
//   static const double spaceBtwInputFields = 16.0;
//
// /// Card sizes
//   static const double cardRadiusLg = 16.0;
//   static const double cardRadiusMd = 12.0;
//   static const double cardRadiusSm = 10.0;
//   static const double cardRadiusXs = 6.0;
//   static const double cardElevation = 2.0;
//
// /// Image CarouselHeight
//   static const double imageCarouselHeight = 200.0;
//
// /// Loader Indicator SIze
//   static const double loaderIndicatorSize = 36.0;
//
// /// GridView Spacing
//   static const double gridViewSpacing = 16.0;
// }