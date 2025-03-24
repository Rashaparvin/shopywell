import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopywell/domain/models/user_model/user_model.dart';

class LocalDatabase {
  Future<void> dataBaseInitialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());

    await Hive.openBox('userDb');
  }
}
