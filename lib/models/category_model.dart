import 'package:daily/pack.dart';

class CategoryModel {
  int id;
  String categoryName;

  CategoryModel({@required this.categoryName});

  CategoryModel.withID({@required this.id, @required this.categoryName});

  CategoryModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.categoryName = map['kategori'];
  }

  factory CategoryModel.factoryFromMap(Map<String, dynamic> map) {
    return CategoryModel.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['kategori'] = this.categoryName;
    return map;
  }

  get getId =>this.id;
  get getCategory =>this.categoryName;
  
}
