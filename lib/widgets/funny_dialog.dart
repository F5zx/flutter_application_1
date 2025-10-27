import 'package:flutter/material.dart';
class FunnyDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1a1a1a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFd32f2f), width: 2),
          ),
          title: const Text(
            'Эй, релок!',
            style: TextStyle(
              color: Color(0xFFd32f2f),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: const Text(
            'Хули ты нажимаешь? Я устал\n\nДавай не так быстро',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFd32f2f), Color(0xFFb71c1c)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                child: const Text(
                  'Ладно, ладно',
                  style: TextStyle(color: Colors.white),
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
}
// не хуя не робит НЕ ЗАБЫТЬ ИСПРАВИТЬ!!!!