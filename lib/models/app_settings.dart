class AppSettings {
  final String theme;
  final String language;
  final bool categoriesEnabled;

  const AppSettings({
    this.theme = 'dota_red',
    this.language = 'russian',
    this.categoriesEnabled = false,
  });

  AppSettings copyWith({
    String? theme,
    String? language,
    bool? categoriesEnabled,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      language: language ?? this.language,
      categoriesEnabled: categoriesEnabled ?? this.categoriesEnabled,
    );
  }
}