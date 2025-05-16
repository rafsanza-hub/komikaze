import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:komikaze/app/data/services/firebase_service.dart';
import 'package:komikaze/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);

  final firebaseService = FirebaseService();

  final GetStorage _storage = GetStorage();
  var selectedLanguage = 'en_US'.obs;

  final RxList<String> downloads = <String>[
    'Solo Leveling Chapter 210-215',
    'Tower of God Chapter 120-123',
    'The Beginning After The End Chapter 145-150',
    'Omniscient Reader Chapter 100-104',
  ].obs;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }

  Future<void> signOut() async {
    try {
      await firebaseService.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value = _storage.read('language') ?? 'en_US';
    Get.updateLocale(Locale(selectedLanguage.value.split('_')[0],
        selectedLanguage.value.split('_')[1]));
  }

  void changeLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    _storage.write('language', languageCode);
    Get.updateLocale(
        Locale(languageCode.split('_')[0], languageCode.split('_')[1]));
    print('Language changed to: $languageCode');
  }
}
