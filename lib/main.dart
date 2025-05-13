import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikaze/app/core/theme/theme.dart';
import 'package:komikaze/app/core/translations/app_translations.dart';
import 'package:komikaze/app/core/translations/en_US.dart';
import 'package:komikaze/app/core/translations/id_ID.dart';
import 'package:komikaze/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user = FirebaseAuth.instance.currentUser;
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: AppTheme.darkTheme,
      translations: AppTranslations(),
      locale: const Locale('id', 'ID'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: user == null ? Routes.LOGIN : Routes.MAIN,
      getPages: AppPages.routes,
    ),
  );
}
