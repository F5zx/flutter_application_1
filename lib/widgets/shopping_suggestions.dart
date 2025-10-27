import 'package:flutter/material.dart';
import '../services/history_service.dart';
import '../models/app_theme.dart';

class ShoppingSuggestions extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSuggestionSelected;
  final AppTheme theme;

  const ShoppingSuggestions({
    super.key,
    required this.controller,
    required this.onSuggestionSelected,
    required this.theme,
  });

  @override
  State<ShoppingSuggestions> createState() => _ShoppingSuggestionsState();
}

class _ShoppingSuggestionsState extends State<ShoppingSuggestions> {
  final HistoryService _historyService = HistoryService();
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() async {
    final text = widget.controller.text.trim();
    
    if (text.isEmpty) {
      setState(() {
        _showSuggestions = false;
        _suggestions = [];
      });
      return;
    }

    try {
      final history = await _historyService.getHistory();
      final filtered = history
          .where((item) => item.toLowerCase().contains(text.toLowerCase()))
          .toList();

      setState(() {
        _suggestions = filtered;
        _showSuggestions = filtered.isNotEmpty;
      });
    } catch (e) {
      print('Ошибка при поиске подсказок: $e');
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showSuggestions) return const SizedBox.shrink();

    return Positioned(
      left: 16,
      right: 16,
      bottom: 80,
      child: Material(
        elevation: 8.0,
        color: widget.theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: widget.theme.primaryColor,
            width: 2,
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = _suggestions[index];
              return Container(
                decoration: BoxDecoration(
                  border: index < _suggestions.length - 1
                      ? Border(
                          bottom: BorderSide(
                            color: widget.theme.backgroundColor,
                            width: 1,
                          ),
                        )
                      : null,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.history,
                    color: widget.theme.primaryColor,
                  ),
                  title: Text(
                    _capitalizeFirstLetter(suggestion),
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    widget.onSuggestionSelected(suggestion);
                    widget.controller.clear();
                    setState(() {
                      _showSuggestions = false;
                    });
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}