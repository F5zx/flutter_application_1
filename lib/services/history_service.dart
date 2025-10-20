import 'package:shared_preferences/shared_preferences.dart';
import '../models/shopping_item.dart';

class HistoryService {
  static const String _historyKey = 'purchaseHistory';
  static const String _shoppingListKey = 'currentShoppingList';
  Future<List<String>> getHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? history = prefs.getStringList(_historyKey);
      print('Загружена история$history'); 
      return history ?? [];
    } catch (e) {
      print('Ошибка загрузки истории$e');
      return [];
    }
  }

  // Добавить в историю
  Future<void> addToHistory(String newItem) async {
    try {
      newItem = newItem.trim().toLowerCase();
      print('Добавляем в историю$newItem'); // Отладка

      List<String> history = await getHistory();
      history.remove(newItem);
      history.insert(0, newItem);

      if (history.length > 50) {
        history = history.sublist(0, 50);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_historyKey, history);
      print('История сохранена$history'); // Отладочка
    } catch (e) {
      print('Ошибка сохранения истории$e');
    }
  }
  Future<void> saveShoppingList(List<ShoppingItem> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> encodedItems = items.map((item) {
        return '${item.name}|${item.isCompleted}';
      }).toList();
      await prefs.setStringList(_shoppingListKey, encodedItems);
      print('Список покупок сохранен${items.length}');
    } catch (e) {
      print('Ошибка сохранения списка$e');
    }
  }
  Future<List<ShoppingItem>> loadShoppingList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? encodedItems = prefs.getStringList(_shoppingListKey);
      if (encodedItems == null) {
        print('Список покупок пуст');
        return [];
      }   final items = encodedItems.map((encoded) {
        final parts = encoded.split('-');
        return ShoppingItem(
          parts[0],
          isCompleted: parts.length > 1 ? parts[1] == 'true' : false,
        );
      }).toList();
      print('Загружен список покупок${items.length}');
      return items;
    } catch (e) {
      print('Ошибка загрузки списка$e');
      return [];
    }
  }
}