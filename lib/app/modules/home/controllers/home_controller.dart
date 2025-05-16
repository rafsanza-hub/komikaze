import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/models/popular_comic.dart';
import 'package:komikaze/app/data/services/comic_service.dart';
import 'package:komikaze/app/modules/genre/controllers/genre_controller.dart';
import 'package:komikaze/app/modules/history/controllers/history_controller.dart';

class HomeController extends GetxController {
  final ComicService _comicService = ComicService();
  final GenreController genreController = Get.find();
  final HistoryController historyController = Get.find();
  PageController pageController = PageController(initialPage: 0);
  Timer? _timer;
  final currentPage = 0.obs;

  final heroComics = [
    {
      "comicId": "omniscient-readers-viewpoint",
      "title": "OMNISCIENT READER'S VIEWPOINT",
      "subtitle": "top_fantasy_manhwa".tr,
      "image":
          "https://i.pinimg.com/736x/84/5f/9d/845f9dab7240d5f249efc289dde4d7af.jpg",
    },
    {
      "comicId": "solo-leveling",
      "title": "SOLO LEVELING",
      "subtitle": "top_action_manhwa".tr,
      "image":
          "https://i.pinimg.com/736x/12/76/3d/12763d6cc85d5c00e20dd20052187138.jpg",
    },
    {
      "comicId": "legend-of-the-northern-blade",
      "title": "LEGEND OF THE NORTHERN BLADE",
      "subtitle": "top_murim_manhwa".tr,
      "image":
          "https://i.pinimg.com/736x/af/5a/0d/af5a0d7373b41b607e0588f34ae1d5c7.jpg",
    }
  ];

  var comicData = ComicData(
    comicsList: [],
    page: 1,
    genres: [],
    status: "",
    type: "",
    orderby: "",
    source: "",
  ).obs;

  var isLoading = false.obs;
  var popularKomikData = PopularKomikData(popularManga: [], source: "").obs;

  Future<void> fetchComics() async {
    try {
      isLoading(true);
      comicData.value = await _comicService.fetchComics();
    } catch (e) {
      print('error cuy: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchPopularComics() async {
    try {
      isLoading(true);
      popularKomikData.value = await _comicService.fetchPopularComics();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch popular comics: $e');
    } finally {
      isLoading(false);
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      int nextPage = currentPage.value + 1;
      if (nextPage >= heroComics.length) {
        nextPage = 0;
      }

      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );

      currentPage.value = nextPage;
    });
  }

  @override
  void onInit() {
    genreController.fetchGenres();

    fetchComics();
    fetchPopularComics();
    print('genre: ${genreController.genreData.value.genres}');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _startAutoScroll();
    historyController.histories.first.coverImage;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
