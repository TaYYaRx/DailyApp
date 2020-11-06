import 'package:daily/pack.dart';

GetIt locator = GetIt.I;

setupLocator() {
  locator.registerLazySingleton(() => DatabaseHelper());
  locator.registerLazySingleton(() => DailyRepository());
  locator.registerLazySingleton(() => SqlClient());
  //locator.registerLazySingleton(() => ;

}
