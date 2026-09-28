import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalizationConfig {
  static const List<Locale> supportedLocales = [
    Locale('tr'),
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('pt'),
  ];

  static const String defaultLocale = 'tr';

  static bool isRTL(BuildContext context) {
    return context.locale.languageCode == 'ar';
  }

  static TextDirection getTextDirection(BuildContext context) {
    return isRTL(context) ? TextDirection.rtl : TextDirection.ltr;
  }
}
