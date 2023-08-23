import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'OnurHalBulutApp',
      'date_picker_select_date': 'Select Date',
      'date_picker_cancel': 'Cancel',
      'date_picker_done': 'Done',
      'month_january': 'January',
      'month_february': 'February',
      'month_march': 'March',
      'month_april': 'April',
      'month_may': 'May',
      'month_june': 'June',
      'month_july': 'July',
      'month_august': 'August',
      'month_september': 'September',
      'month_october': 'October',
      'month_november': 'November',
      'month_december': 'December',
      'day_monday': 'Monday',
      'day_tuesday': 'Tuesday',
      'day_wednesday': 'Wednesday',
      'day_thursday': 'Thursday',
      'day_friday': 'Friday',
      'day_saturday': 'Saturday',
      'day_sunday': 'Sunday',
    },
    'tr': {
      'app_title': 'OnurHalBulutUygulaması',
      'date_picker_select_date': 'Tarih Seçin',
      'date_picker_cancel': 'İptal',
      'date_picker_done': 'Tamam',
      'month_january': 'Ocak',
      'month_february': 'Şubat',
      'month_march': 'Mart',
      'month_april': 'Nisan',
      'month_may': 'Mayıs',
      'month_june': 'Haziran',
      'month_july': 'Temmuz',
      'month_august': 'Ağustos',
      'month_september': 'Eylül',
      'month_october': 'Ekim',
      'month_november': 'Kasım',
      'month_december': 'Aralık',
      'day_monday': 'Pazartesi',
      'day_tuesday': 'Salı',
      'day_wednesday': 'Çarşamba',
      'day_thursday': 'Perşembe',
      'day_friday': 'Cuma',
      'day_saturday': 'Cumartesi',
      'day_sunday': 'Pazar',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
