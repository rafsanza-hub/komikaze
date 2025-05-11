import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:komikaze/app/data/services/firebase_service.dart';
import 'package:komikaze/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);

  final firebaseService = FirebaseService();

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
}
