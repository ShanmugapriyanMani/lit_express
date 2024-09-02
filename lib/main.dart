import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/repository/authentication_repository.dart';
import 'my_app.dart';

Future<void> main() async {
  // TODO: Add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Init Local Storage


  // TODO: Initialize Firebase

  // TODO: Initialize Authentication

  Get.put(AuthenticationRepository());

  runApp(const MyApp());
}