import 'package:get/get.dart';
import 'package:komikaze/app/data/models/history.dart';
import 'package:komikaze/app/data/services/firebase_service.dart';

class HistoryController extends GetxController {
  final _firebaseService = FirebaseService();
  final RxList<HistoryItem> histories = <HistoryItem>[].obs;

  Future<void> getHistory() async {
    try {
      final history = await _firebaseService.getHistory();
      if (history != null) {
        histories.value = history;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<HistoryItem> addHistory(HistoryItem history) async {
    try {
      await _firebaseService.addHistory(history);
      getHistory();
      return history;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  @override
  void onInit() {
    getHistory();
    super.onInit();
  }
}
