import 'package:daily/pack.dart';

class Constants {
  static const String ADD = 'Ekle';
  static const String EDIT = 'Düzenle';
  static const String DELETE = 'Sil';
  static const String REFRESH = 'Yenile';
  static const String DELETE_ALL = 'Temizle';
  static const List<String> choise = [EDIT, DELETE];
  static const List<String> choise2 = [ADD, REFRESH, DELETE_ALL];
  static final List<String> imageList = prepareList();

  LinearGradient customGradient() => LinearGradient(
      colors: [Color(0xFF1D1033), Color(0xFFA800B7)],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      tileMode: TileMode.clamp,
      stops: [0, 1]);

  LinearGradient customGradientR() => LinearGradient(
      colors: [Color(0xFFA800B7), Color(0xFF1D1033)],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      tileMode: TileMode.clamp,
      stops: [0, 1]);

  String pickImage() {
    var sayi; //random
    Random random = new Random();
    sayi = random.nextInt(12);

    return 'assets/images/$sayi.jpg';
  }

  String getCurrentDate() {
    var now = new DateTime.now();
    String d1 = now.toLocal().day.toString();
    int d2 = now.toLocal().month;
    String d3 = now.toLocal().year.toString();

    return d1 + '.' + ((d2 < 10) ? '0$d2' : d2.toString()) + '.' + d3;
  }

  static List<String> prepareList() {
    var list = List<String>();
    for (int i = 1; i < 64; i++) {
      list.add('$i');
    }
    return list;
  }
}
