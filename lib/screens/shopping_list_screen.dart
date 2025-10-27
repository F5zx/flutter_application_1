import 'package:flutter/material.dart';
import '../models/shopping_item.dart';
import '../models/app_settings.dart';
import '../models/app_theme.dart';
import '../services/history_service.dart';
import '../services/settings_service.dart';
import '../services/app_localizations.dart';
import '../widgets/shopping_item_card.dart';
import '../widgets/shopping_input_field.dart';
import '../widgets/shopping_suggestions.dart';
import '../widgets/app_drawer.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final HistoryService _historyService = HistoryService();
  final SettingsService _settingsService = SettingsService();
  final List<ShoppingItem> _currentShoppingList = [];
  final TextEditingController _inputController = TextEditingController();
  
  AppSettings _settings = const AppSettings();
  AppTheme get _currentTheme => AppTheme.getTheme(_settings.theme);
  AppLocalizations get _localizations => AppLocalizations(_settings.language);

  @override
  void initState() {
    super.initState();
    _loadShoppingList();
    _loadSettings();
  }

  void _loadShoppingList() async {
    final savedList = await _historyService.loadShoppingList();
    setState(() {
      _currentShoppingList.addAll(savedList);
    });
  }

  void _loadSettings() async {
    final savedSettings = await _settingsService.getSettings();
    setState(() {
      _settings = savedSettings;
    });
  }

  void _saveShoppingList() {
    _historyService.saveShoppingList(_currentShoppingList);
  }

  void _saveSettings() {
    _settingsService.saveSettings(_settings);
  }

  void _addItemToShoppingList(String item) {
    String formattedItem = _capitalizeFirstLetter(item);

    setState(() {
      _currentShoppingList.add(ShoppingItem(formattedItem));
    });
    
    _historyService.addToHistory(item);
    _saveShoppingList();
  }

  void _removeItemFromShoppingList(int index) {
    setState(() {
      _currentShoppingList.removeAt(index);
    });
    _saveShoppingList();
  }

  void _toggleItemCompletion(int index) {
    setState(() {
      _currentShoppingList[index].isCompleted = !_currentShoppingList[index].isCompleted;
    });
    _saveShoppingList();
  }

  void _updateSettings(AppSettings newSettings) {
    setState(() {
      _settings = newSettings;
    });
    _saveSettings();
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _localizations.appTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: _currentTheme.primaryColor,
        elevation: 8,
        shadowColor: const Color(0xFF000000).withAlpha(128),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: AppDrawer(
        settings: _settings,
        onSettingsChanged: _updateSettings,
        localizations: _localizations,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _currentTheme.backgroundColor,
              _currentTheme.cardColor,
              _currentTheme.backgroundColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: _currentShoppingList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 64,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _localizations.emptyList,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18, 
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _currentShoppingList.length,
                          itemBuilder: (context, index) {
                            return ShoppingItemCard(
                              item: _currentShoppingList[index],
                              onToggle: () => _toggleItemCompletion(index),
                              onDelete: () => _removeItemFromShoppingList(index),
                              theme: _currentTheme,
                            );
                          },
                        ),
                ),
                ShoppingInputField(
                  controller: _inputController,
                  onItemAdded: _addItemToShoppingList,
                  onQuickPress: () {
                  },
                  theme: _currentTheme,
                  localizations: _localizations,
                ),
              ],
            ),
            ShoppingSuggestions(
              controller: _inputController,
              onSuggestionSelected: _addItemToShoppingList,
              theme: _currentTheme,
            ),
          ],
        ),
      ),
    );
  }
}