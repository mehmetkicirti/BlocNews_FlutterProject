import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Category{
  String _categoryName;
  IconData _icon;

  Category(this._categoryName,this._icon){
  }

  IconData get icon => _icon;

  set icon(IconData value) {
    _icon = value;
  }

  String get categoryName => _categoryName;

  set categoryName(String value) {
    _categoryName = value;
  }
}
List<Category> categories = [
  Category("business",Icons.business),
  Category("entertainment",Zocial.delicious),
  Category("health",FontAwesome.hospital_o),
  Category("science",Icons.school),
  Category("sports",FontAwesome5Regular.futbol),
  Category("technology",Icons.computer)
];