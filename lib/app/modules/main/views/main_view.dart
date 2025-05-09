import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikaze/app/modules/home/views/home_view.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.index.value,
          children: [
            HomeView(),
            HomeView(),
            HomeView(),
            HomeView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => SizedBox(
            height: 90,
            child: BottomNavigationBar(
              backgroundColor: kBackgroundColor,
              currentIndex: controller.index.value,
              onTap: controller.changeIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).unselectedWidgetColor,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history_rounded), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
              ],
            ),
          )),
    );
  }
}

const kBackgroundColor = Color(0xff121012);
const kButtonColor = Color.fromARGB(255, 89, 54, 133);
const kSearchbarColor = Color(0xff382C3E);
