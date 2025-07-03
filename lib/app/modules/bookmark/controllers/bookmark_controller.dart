import 'package:get/get.dart';
import 'package:komikaze/app/data/models/bookmark.dart';
import 'package:komikaze/app/data/services/firebase_service.dart';

class BookmarkController extends GetxController {
  final _firebaseService = FirebaseService();
  final RxList<BookmarkItem> bookmarks = <BookmarkItem>[].obs;

  Future<void> getBookmark() async {
    try {
      final bookmark = await _firebaseService.getBookmarks();
      if (bookmark != null) {
        bookmarks.value = bookmark;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<BookmarkItem> addBookmark(BookmarkItem bookmark) async {
    try {
      await _firebaseService.addBookmark(bookmark);
      return bookmark;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<void> deleteBookmark(String comicId) async {
    try {
      await _firebaseService.deleteBookmark(comicId);
      getBookmark();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    getBookmark();
    super.onInit();
  }
}
