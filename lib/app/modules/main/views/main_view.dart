import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:komikaze/app/modules/home/views/home_view.dart';
import 'package:komikaze/app/modules/profile/views/profile_view.dart';

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
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => SizedBox(
            child: BottomNavigationBar(
              backgroundColor: kBackgroundColor,
              currentIndex: controller.index.value,
              onTap: controller.changeIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).unselectedWidgetColor,
              type: BottomNavigationBarType.fixed,
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.home_2_copy), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.search_normal_1_copy), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.clock_copy), label: 'History'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.user_copy), label: 'Profile'),
              ],
            ),
          )),
    );
  }
}

const kBackgroundColor = Color(0xff121012);
const kButtonColor = Color.fromARGB(255, 89, 54, 133);
const kSearchbarColor = Color(0xff382C3E);
