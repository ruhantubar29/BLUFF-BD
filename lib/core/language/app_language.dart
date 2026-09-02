enum AppLanguage {
  bangla,
  english,
}

extension AppLanguageExtension on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.bangla:
        return 'bn';
      case AppLanguage.english:
        return 'en';
    }
  }

  String get displayName {
    switch (this) {
      case AppLanguage.bangla:
        return 'বাংলা';
      case AppLanguage.english:
        return 'English';
    }
  }
}