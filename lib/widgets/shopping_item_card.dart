import 'package:flutter/material.dart';
import '../models/shopping_item.dart';
import '../models/app_theme.dart';

class ShoppingItemCard extends StatelessWidget {
  final ShoppingItem item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final AppTheme theme;

  const ShoppingItemCard({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: item.isCompleted
              ? [
                  theme.cardColor,
                  theme.backgroundColor,
                ]
              : [
                  theme.primaryColor.withOpacity(0.1),
                  theme.cardColor,
                ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.isCompleted
              ? Colors.grey[700]!
              : theme.primaryColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withAlpha(77),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          item.name,
          style: TextStyle(
            decoration: item.isCompleted 
                ? TextDecoration.lineThrough 
                : TextDecoration.none,
            color: item.isCompleted 
                ? Colors.grey 
                : Colors.white,
            fontWeight: item.isCompleted 
                ? FontWeight.normal 
                : FontWeight.w500,
            fontSize: 16,
          ),
        ),
        leading: Container(
          decoration: BoxDecoration(
            color: item.isCompleted 
                ? theme.primaryColor 
                : Colors.transparent,
            border: Border.all(
              color: theme.primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Checkbox(
            value: item.isCompleted,
            onChanged: (bool? value) {
              onToggle();
            },
            activeColor: Colors.transparent,
            checkColor: Colors.white,
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: theme.primaryColor,
            size: 24,
          ),
          onPressed: onDelete,
        ),
        onTap: onToggle,
      ),
    );
  }
}