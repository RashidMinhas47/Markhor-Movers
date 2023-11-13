import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataBaseProvider = Provider((ref) => DataBaseRiverpod());

class DataBaseRiverpod {
  Future<String> getUserData() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return "Rashid";
    });
  }
}
