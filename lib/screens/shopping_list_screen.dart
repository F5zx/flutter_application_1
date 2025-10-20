import 'package:flutter/material.dart';
import '../models/shopping_item.dart';
import '../services/history_service.dart';
import '../widgets/shopping_item_card.dart';
import '../widgets/shopping_input_field.dart';
import '../widgets/shopping_suggestions.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final HistoryService _historyService = HistoryService();
  final List<ShoppingItem> _currentShoppingList = [];
  final TextEditingController _inputController = TextEditingController(); // Общий контроллер

  @override
  void initState() {
    super.initState();
    _loadShoppingList();
  }

  void _loadShoppingList() async {
    final savedList = await _historyService.loadShoppingList();
    setState(() {
      _currentShoppingList.addAll(savedList);
    });
  }

  void _saveShoppingList() {
    _historyService.saveShoppingList(_currentShoppingList);
  }

  void _addItemToShoppingList(String item) {
    String formattedItem = _capitalizeFirstLetter(item);

    setState(() {
      _currentShoppingList.add(ShoppingItem(formattedItem));
    });
    _historyService.addToHistory(item);
    _saveShoppingList();
    
    print('Добавлен товар$formattedItem');
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

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dota 2 Shopping',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFd32f2f),
        elevation: 8,
        shadowColor: const Color(0xFF000000).withAlpha(128),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0c0c0c),
                  Color(0xFF1a1a1a),
                  Color(0xFF0c0c0c),
                ],
              ),
            ),
            child: Column(
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
                              const Text(
                                'Список покупок пуст\nДобавьте первый товар',
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
                            );
                          },
                        ),
                ),
                ShoppingInputField(
                  controller: _inputController,
                  onItemAdded: _addItemToShoppingList,
                  onQuickPress: () {
                  },
                ),
              ],
            ),
          ),
          ShoppingSuggestions(
            controller: _inputController,
            onSuggestionSelected: _addItemToShoppingList,
          ),
        ],
      ),
    );
  }
}