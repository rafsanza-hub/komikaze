// ignore_for_file: public_member_api_docs, sort_constructors_first
class History {
  final Map<String, HistoryItem> historyItems;

  History({required this.historyItems});

  factory History.fromFirestore(Map<String, dynamic> data) {
    final historyMap = data['history'] as Map<String, dynamic>? ?? {};

    final items = historyMap.map((comicId, itemData) =>
        MapEntry(comicId, HistoryItem.fromMap(comicId, itemData)));

    return History(historyItems: items);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'history':
          historyItems.map((comicId, item) => MapEntry(comicId, item.toMap())),
    };
  }
}

class HistoryItem {
  final String comicId;
  final String title;
  final String chapterId;
  final String chapterTitle;
  final DateTime lastRead;
  final String coverImage;
  final String type;

  HistoryItem({
    required this.comicId,
    required this.title,
    required this.chapterId,
    required this.chapterTitle,
    required this.lastRead,
    required this.coverImage,
    required this.type,
  });

  // Convert dari Map ke HistoryItem
  factory HistoryItem.fromMap(String comicId, Map<String, dynamic> map) {
    return HistoryItem(
      comicId: comicId,
      title: map['title'] ?? '',
      chapterId: map['chapterId'] ?? '',
      chapterTitle: map['chapterTitle'] ?? '',
      lastRead: DateTime.parse(map['lastRead']),
      coverImage: map['coverImage'] ?? '',
      type: map['type'] ?? 'manga',
    );
  }

  // Convert dari HistoryItem ke Map
  Map<String, dynamic> toMap() {
    return {
      'comicId': comicId,
      'title': title,
      'chapterId': chapterId,
      'chapterTitle': chapterTitle,
      'lastRead': lastRead.toIso8601String(),
      'coverImage': coverImage,
      'type': type,
    };
  }
}
