import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({super.key});

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  List<String> languageList = ["English", "عربي"];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;

    if (provider.currentLanguage == "ar") {
      languageList = ["عربي", "English"];
    }
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            lang.settings,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontSize: 33, fontFamily: "Poppins"),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              lang.language,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDropdown<String>(
            items: languageList,
            initialItem: languageList[0],
            onChanged: (newLanguage) {
              if (newLanguage != null) {
                newLanguage = newLanguage == "English" ? "en" : "ar";
                if (newLanguage == provider.currentLanguage) return;
                provider.changeLanguage(newLanguage);
                languageList.reversed;
              }
            },
            decoration: CustomDropdownDecoration(
              closedFillColor: Colors.white,
              expandedFillColor: Colors.white,
              closedSuffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,),
              expandedSuffixIcon: const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black,),
              listItemStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              headerStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 65,
          ),
          Material(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () => closeSettings(context),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  lang.done,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void closeSettings(BuildContext context) {
    Navigator.pop(context);
  }
}
