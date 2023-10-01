import 'package:bringin/Hive/init_hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await Firebase.initializeApp();
  // Get.put(ChatControll()).sokcetconnet();
  runApp(MyApp());
}
