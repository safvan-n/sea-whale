import 'package:flutter/material.dart';

class CategoryItemModel {
  final String id;
  final String name;
  final IconData icon;
  final String description;
  final Color accentColor;

  const CategoryItemModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    this.accentColor = const Color(0xFF00B4D8),
  });
}
