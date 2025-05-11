import 'package:get/get.dart';
import 'package:komikaze/app/data/services/firebase_service.dart';
import 'package:komikaze/app/routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseService firebaseService = FirebaseService();

  Future<void> loginWithGoogle() async {
    try {
      final user = await firebaseService.signInWithGoogle();
      if (user != null) {
        Get.offAllNamed(Routes.MAIN);
      } else {
        Get.snackbar('Error', 'Login gagal');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
