import 'package:flutter/material.dart';

import '../../core/language/app_language.dart';
import '../../core/language/language_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  AppLanguage _language =
      LanguageSettings.instance.language;

  Future<void> _changeLanguage(
    AppLanguage language,
  ) async {
    await LanguageSettings.instance.setLanguage(
      language,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Language',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: RadioGroup<AppLanguage>(
              groupValue: _language,
              onChanged: (value) {
                if (value != null) {
                  _changeLanguage(value);
                }
              },
              child: Column(
                children: const [
                  RadioListTile<AppLanguage>(
                    value: AppLanguage.bangla,
                    title: Text('বাংলা'),
                  ),
                  RadioListTile<AppLanguage>(
                    value: AppLanguage.english,
                    title: Text('English'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}