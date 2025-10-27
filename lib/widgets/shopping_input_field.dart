import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../services/app_localizations.dart';

class ShoppingInputField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onItemAdded;
  final Function() onQuickPress;
  final AppTheme theme;
  final AppLocalizations localizations;

  const ShoppingInputField({
    super.key,
    required this.controller,
    required this.onItemAdded,
    required this.onQuickPress,
    required this.theme,
    required this.localizations,
  });

  @override
  State<ShoppingInputField> createState() => _ShoppingInputFieldState();
}

class _ShoppingInputFieldState extends State<ShoppingInputField> {
  final FocusNode _focusNode = FocusNode();
  
  final List<DateTime> _pressTimes = [];
  static const int _maxQuickPresses = 7;
  static const int _timeWindowMs = 2000;

  void _checkQuickPress() {
    final now = DateTime.now();
    _pressTimes.add(now);
    
    _pressTimes.removeWhere((time) => 
      now.difference(time).inMilliseconds > _timeWindowMs
    );
    
    if (_pressTimes.length >= _maxQuickPresses) {
      _showFunnyDialog();
      _pressTimes.clear();
    }
  }

  void _showFunnyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: widget.theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: widget.theme.primaryColor, width: 2),
          ),
          title: Text(
            widget.localizations.quickPressDialogTitle,
            style: TextStyle(
              color: widget.theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text(
            widget.localizations.quickPressDialogContent,
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.theme.primaryColor, widget.theme.secondaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                child: Text(
                  widget.localizations.okay,
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

  void _addItem() {
    final text = widget.controller.text.trim();
    if (text.isNotEmpty) {
      widget.onItemAdded(text);
      widget.controller.clear();
      _checkQuickPress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.theme.cardColor,
            widget.theme.backgroundColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withAlpha(128),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.theme.primaryColor.withAlpha(128),
                  width: 2,
                ),
                gradient: LinearGradient(
                  colors: [
                    widget.theme.cardColor,
                    widget.theme.backgroundColor,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: widget.localizations.addItemHint,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    widget.onItemAdded(value);
                    widget.controller.clear();
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.theme.primaryColor, widget.theme.secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: widget.theme.primaryColor.withAlpha(102),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white, size: 28),
              onPressed: _addItem,
            ),
          ),
        ],
      ),
    );
  }
}