import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/cache/locale_manager.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 30,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          items: context.supportedLocales
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e.languageCode,
                  child: Text(e.countryCode.toString().toLanguageString),
                ),
              )
              .toList(),
          value: context.locale.languageCode,
          onChanged: (value) => changeLanguage(context, value),
        ),
      ),
    );
  }

  Future<void> changeLanguage(BuildContext context, String? value) async {
    switch (value) {
      case 'tr':
        await context.setLocale(const Locale('tr', 'TR'));
        await LocaleManager.instance.setStringValue(PreferencesKeys.LANGUAGE, 'T');
        break;
      case 'en':
        await context.setLocale(const Locale('en', 'US'));
        await LocaleManager.instance.setStringValue(PreferencesKeys.LANGUAGE, 'E');
        break;

      default:
    }
  }
}
