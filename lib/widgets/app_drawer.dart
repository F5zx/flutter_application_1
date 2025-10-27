import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import '../models/app_theme.dart';
import '../services/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  final AppSettings settings;
  final Function(AppSettings) onSettingsChanged;
  final AppLocalizations localizations;

  const AppDrawer({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
    required this.localizations,
  });

  void _showThemeDialog(BuildContext context) {
    final currentTheme = AppTheme.getTheme(settings.theme);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: currentTheme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: currentTheme.primaryColor, width: 2),
          ),
          title: Text(
            localizations.themeSelection,
            style: TextStyle(color: currentTheme.primaryColor),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: AppTheme.all.length,
              itemBuilder: (context, index) {
                final theme = AppTheme.all[index];
                return _buildThemeOption(context, theme);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(BuildContext context, AppTheme theme) {
    final isSelected = settings.theme == theme.name;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? theme.primaryColor : Colors.transparent,
          width: 2,
        ),
        color: theme.cardColor,
      ),
      child: ListTile(
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          theme.getDisplayName(localizations),
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isSelected 
            ? Icon(Icons.check, color: theme.primaryColor)
            : null,
        onTap: () {
          onSettingsChanged(settings.copyWith(theme: theme.name));
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final currentTheme = AppTheme.getTheme(settings.theme);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: currentTheme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: currentTheme.primaryColor, width: 2),
          ),
          title: Text(
            localizations.languageSelection,
            style: TextStyle(color: currentTheme.primaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(context, localizations.russian, 'russian'),
              _buildLanguageOption(context, localizations.english, 'english'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(BuildContext context, String title, String value) {
    final currentTheme = AppTheme.getTheme(settings.theme);
    final isSelected = settings.language == value;
    
    return ListTile(
      leading: Icon(
        Icons.language,
        color: currentTheme.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? currentTheme.primaryColor : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected 
          ? Icon(Icons.check, color: currentTheme.primaryColor)
          : null,
      onTap: () {
        onSettingsChanged(settings.copyWith(language: value));
        Navigator.of(context).pop();
      },
    );
  }

  void _showCustomizationDialog(BuildContext context) {
    final currentTheme = AppTheme.getTheme(settings.theme);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: currentTheme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: currentTheme.primaryColor, width: 2),
          ),
          title: Text(
            localizations.customization,
            style: TextStyle(color: currentTheme.primaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text(
                  localizations.categories,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  localizations.categoriesDescription,
                  style: const TextStyle(color: Colors.grey),
                ),
                activeTrackColor: currentTheme.primaryColor.withOpacity(0.5),
                activeThumbColor: currentTheme.primaryColor,
                thumbColor: MaterialStateProperty.all(currentTheme.primaryColor),
                trackColor: MaterialStateProperty.all(currentTheme.primaryColor.withOpacity(0.5)),
                value: settings.categoriesEnabled,
                onChanged: (bool value) {
                  onSettingsChanged(settings.copyWith(categoriesEnabled: value));
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(
                  Icons.color_lens,
                  color: currentTheme.primaryColor,
                ),
                title: Text(
                  localizations.changeTheme,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: currentTheme.primaryColor,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _showThemeDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    final currentTheme = AppTheme.getTheme(settings.theme);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: currentTheme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: currentTheme.primaryColor, width: 2),
          ),
          title: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: currentTheme.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                localizations.aboutApp,
                style: TextStyle(
                  color: currentTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.appTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${localizations.version}: 1.0.0',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.aboutDescription1,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                localizations.aboutDescription2,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [currentTheme.primaryColor, currentTheme.secondaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                child: Text(
                  localizations.close,
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = AppTheme.getTheme(settings.theme);
    
    return Drawer(
      backgroundColor: currentTheme.cardColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [currentTheme.primaryColor, currentTheme.secondaryColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  localizations.appTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  localizations.shoppingList,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.palette,
              color: currentTheme.primaryColor,
            ),
            title: Text(
              localizations.customization,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: currentTheme.primaryColor,
            ),
            onTap: () => _showCustomizationDialog(context),
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: currentTheme.primaryColor,
            ),
            title: Text(
              localizations.language,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: currentTheme.primaryColor,
            ),
            onTap: () => _showLanguageDialog(context),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Icon(
              Icons.info,
              color: currentTheme.primaryColor,
            ),
            title: Text(
              localizations.about,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: currentTheme.primaryColor,
            ),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }
}