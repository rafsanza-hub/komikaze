import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:komikaze/app/data/models/bookmark.dart';
import 'package:komikaze/app/data/models/history.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print(e);
      throw Exception('Error signing in with Google: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> addHistory(HistoryItem history) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final docRef = _firestore.collection('history').doc(user.uid);

      await docRef.set({
        'history': {history.comicId: history.toMap()}
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error adding history: $e');
    }
  }

  Future<List<HistoryItem>?> getHistory() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not signed in');

      final docRef = _firestore.collection('history').doc(user.uid);
      final doc = await docRef.get();
      if (doc.exists) {
        final history = History.fromFirestore(doc.data()!);
        final historyItems = history.historyItems.values.toList();

        // Urutkan berdasarkan lastRead (terbaru pertama)
        historyItems.sort((a, b) => b.lastRead.compareTo(a.lastRead));
        return historyItems;
      }
    } catch (e) {
      print(e);
      throw Exception('Error getting history: $e');
    }
    return null;
  }

  Future<void> addBookmark(BookmarkItem bookmark) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final docRef = _firestore.collection('bookmark').doc(user.uid);

      await docRef.set({
        'bookmark': {bookmark.comicId: bookmark.toJson()}
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error adding bookmark: $e');
    }
  }

  Future<List<BookmarkItem>?> getBookmarks() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not signed in');

      final docRef = _firestore.collection('bookmark').doc(user.uid);
      final doc = await docRef.get();
      if (doc.exists) {
        final bookmark = Bookmark.fromFirestore(doc.data()!);
        final bookmarkItems = bookmark.bookmarkItems.values.toList();

        return bookmarkItems;
      }
    } catch (e) {
      print(e);
      throw Exception('Error getting bookmark: $e');
    }
    return null;
  }

  Future<void> deleteBookmark(String comicId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final docRef = _firestore.collection('bookmark').doc(user.uid);

      // Gunakan FieldValue untuk menghapus item spesifik dari nest
      await docRef.update({'bookmark.$comicId': FieldValue.delete()});
    } catch (e) {
      print('Error deleting bookmark: $e');
      throw Exception('Failed to delete bookmark');
    }
  }
}
