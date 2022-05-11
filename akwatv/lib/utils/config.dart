
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Config {

  static Future<void> loadEnv() async {
    await dotenv.load(fileName: ".env");
  }
}