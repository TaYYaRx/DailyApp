class TodoModel {
  int _id;
  String _title;
  String content;
  int _isDone;
  int _kategoriId;

  TodoModel(this._title, this._isDone, this._kategoriId, {this.content});
  TodoModel.withID(this._id, this._title, this._isDone, this._kategoriId,
      {this.content});

  TodoModel.fromMap(Map<String, dynamic> map) {
    // Veri gösterirken
    this._id = map['id'];
    this._title = map['title'];
    this.content = map['content'];
    this._isDone = map['isDone'];
    this._kategoriId = map['kategoriID'];
  }
  factory TodoModel.factoryFromMap(Map<String, dynamic> map) {
    return TodoModel.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    // veri kaydederken
    Map<String, dynamic> map = Map();
    map['id'] = this._id;
    map['title'] = this._title;
    map['content'] = this.content;
    map['isDone'] = this._isDone;
    map['kategoriID'] = this._kategoriId;
    return map;
  }

  int get getTodoId => this._id;
  String get getTitle => this._title;
  String get getContent => this.content;
  int get getIsDone => this._isDone;
  int get getKategoriId => this._kategoriId;

  @override
  String toString() {
    return '${this._id} ${this._title} ${this.content} ${this._isDone} ${this._kategoriId}';
  }
}
