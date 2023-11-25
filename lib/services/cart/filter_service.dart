import 'package:flutter/material.dart';

class FilterService with ChangeNotifier {
  final List<String> _items = [];
  List<String> get items => _items;

  void addFilter(String item) {
    _items.add(item);
    notifyListeners();
  }

  void removeFilter(String item) {
    _items.remove(item);
    notifyListeners();
  }
  
}
