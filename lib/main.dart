import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:komikaze/app/core/theme/theme.dart';
import 'package:komikaze/app/core/translations/app_translations.dart';

import 'package:komikaze/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  // Test GetStorage write and read
  final storage = GetStorage();
  await storage.write('test_key', 'test_value');
  await storage.save();

  final user = FirebaseAuth.instance.currentUser;
  runApp(
    GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: AppTheme.darkTheme,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: user == null ? Routes.LOGIN : Routes.MAIN,
      getPages: AppPages.routes,
    ),
  );
}
