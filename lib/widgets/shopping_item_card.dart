import 'package:flutter/material.dart';
import '../models/shopping_item.dart';

class ShoppingItemCard extends StatelessWidget {
  final ShoppingItem item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const ShoppingItemCard({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: item.isCompleted
              ? [
                  const Color(0xFF2a2a2a),
                  const Color(0xFF1a1a1a),
                ]
              : [
                  const Color(0x1Ad32f2f),
                  const Color(0xFF1a1a1a),
                ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.isCompleted
              ? Colors.grey[700]!
              : const Color(0x4Dd32f2f),
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
                ? const Color(0xFFd32f2f) 
                : Colors.transparent,
            border: Border.all(
              color: const Color(0xFFd32f2f),
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
            color: const Color(0xFFd32f2f),
            size: 24,
          ),
          onPressed: onDelete,
        ),
        onTap: onToggle,
      ),
    );
  }
}