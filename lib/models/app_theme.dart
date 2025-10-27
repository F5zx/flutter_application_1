import 'package:flutter/material.dart';
import '../services/app_localizations.dart';

class AppTheme {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color cardColor;

  const AppTheme({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.cardColor,
  });

  String getDisplayName(AppLocalizations localizations) {
    switch (name) {
      case 'dota_red':
        return localizations.dotaRed;
      case 'csgo_orange':
        return localizations.csgoOrange;
      case 'minecraft_green':
        return localizations.minecraftGreen;
      case 'cyberpunk_purple':
        return localizations.cyberpunkPurple;
      case 'ocean_blue':
        return localizations.oceanBlue;
      default:
        return localizations.dotaRed;
    }
  }

  // Dota 2 - Красная тема
  static const dotaRed = AppTheme(
    name: 'dota_red',
    primaryColor: Color(0xFFd32f2f),
    secondaryColor: Color(0xFFb71c1c),
    backgroundColor: Color(0xFF0c0c0c),
    cardColor: Color(0xFF1a1a1a),
  );

  // CS:GO - Оранжевая тема
  static const csgoOrange = AppTheme(
    name: 'csgo_orange',
    primaryColor: Color(0xFFff9800),
    secondaryColor: Color(0xFFf57c00),
    backgroundColor: Color(0xFF1a1a1a),
    cardColor: Color(0xFF2a2a2a),
  );

  // Minecraft - Зеленая тема
  static const minecraftGreen = AppTheme(
    name: 'minecraft_green',
    primaryColor: Color(0xFF4caf50),
    secondaryColor: Color(0xFF388e3c),
    backgroundColor: Color(0xFF1b5e20),
    cardColor: Color(0xFF2e7d32),
  );

  // Cyberpunk - Фиолетовая тема
  static const cyberpunkPurple = AppTheme(
    name: 'cyberpunk_purple',
    primaryColor: Color(0xFF9c27b0),
    secondaryColor: Color(0xFF7b1fa2),
    backgroundColor: Color(0xFF1a1a2a),
    cardColor: Color(0xFF2a2a3a),
  );

  // Ocean - Синяя тема
  static const oceanBlue = AppTheme(
    name: 'ocean_blue',
    primaryColor: Color(0xFF2196f3),
    secondaryColor: Color(0xFF1976d2),
    backgroundColor: Color(0xFF0d47a1),
    cardColor: Color(0xFF1565c0),
  );

  static const all = [
    dotaRed,
    csgoOrange,
    minecraftGreen,
    cyberpunkPurple,
    oceanBlue,
  ];

  static AppTheme getTheme(String name) {
    return all.firstWhere(
      (theme) => theme.name == name,
      orElse: () => dotaRed,
    );
  }
}