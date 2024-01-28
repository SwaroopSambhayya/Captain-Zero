import 'package:flutter/material.dart';

ThemeData gameTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "GillSans",
    primaryColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    cardColor: const Color(0xff45C074),
    dialogTheme: const DialogTheme(backgroundColor: Colors.black),
    extensions: const <ThemeExtension<dynamic>>[
      BrandColors(
        brandColor1: Colors.black,
        brandColor2: Color(0xff45C074),
        brandColor3: Color(0xffF6A69B),
        brandColor4: Color(0xff89A5E3),
        brandColor5: Colors.white,
        borderColor1: Color(0xFF2C2C2C),
        borderColor2: Color(0xFF1F8A5D),
        borderColor3: Color(0xffF27C6C),
      )
    ]);

@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  const BrandColors(
      {required this.brandColor1,
      required this.brandColor2,
      required this.brandColor3,
      required this.brandColor4,
      required this.brandColor5,
      required this.borderColor1,
      required this.borderColor2,
      required this.borderColor3});

  final Color? brandColor1;
  final Color? brandColor2;
  final Color? brandColor3;
  final Color? brandColor4;
  final Color? brandColor5;
  final Color? borderColor1;
  final Color? borderColor2;
  final Color? borderColor3;

  @override
  BrandColors copyWith(
      {Color? brandColor1,
      Color? brandColor2,
      Color? brandColor3,
      Color? brandColor4,
      Color? brandColor5,
      Color? borderColor1,
      Color? borderColor2,
      Color? borderColor3}) {
    return BrandColors(
      brandColor1: brandColor1 ?? this.brandColor1,
      brandColor2: brandColor2 ?? this.brandColor2,
      brandColor3: brandColor3 ?? this.brandColor3,
      brandColor4: brandColor4 ?? this.brandColor4,
      brandColor5: brandColor5 ?? this.brandColor5,
      borderColor1: borderColor1 ?? this.borderColor1,
      borderColor2: borderColor2 ?? this.borderColor2,
      borderColor3: borderColor3 ?? this.borderColor3,
    );
  }

  @override
  BrandColors lerp(BrandColors? other, double t) {
    if (other is! BrandColors) {
      return this;
    }
    return BrandColors(
        brandColor1: Color.lerp(brandColor1, other.brandColor1, t),
        brandColor2: Color.lerp(brandColor2, other.brandColor2, t),
        brandColor3: Color.lerp(brandColor3, other.brandColor3, t),
        brandColor4: Color.lerp(brandColor4, other.brandColor4, t),
        brandColor5: Color.lerp(brandColor5, other.brandColor5, t),
        borderColor1: Color.lerp(borderColor1, other.borderColor1, t),
        borderColor2: Color.lerp(borderColor2, other.borderColor2, t),
        borderColor3: Color.lerp(borderColor3, other.borderColor3, t));
  }

  // Optional
  @override
  String toString() =>
      'BrandColors(brandColor1: $brandColor1, brandColor2: $brandColor2, brandColor3: $brandColor3, brandColor4: $brandColor4)';
}
