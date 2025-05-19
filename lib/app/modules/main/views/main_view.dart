import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:komikaze/app/core/constants/colors.dart';
import 'package:komikaze/app/modules/download/views/download_view.dart';
import 'package:komikaze/app/modules/history/views/history_view.dart';
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
          children: const [
            HomeView(),
            DownloadView(),
            HistoryView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => SizedBox(
            child: BottomNavigationBar(
              backgroundColor: AppColors.background,
              currentIndex: controller.index.value,
              onTap: controller.changeIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).unselectedWidgetColor,
              type: BottomNavigationBarType.fixed,
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Iconsax.home_2_copy), label: 'home'.tr),
                BottomNavigationBarItem(
                    icon: const Icon(Iconsax.import_1_copy),
                    label: 'downloads'.tr),
                BottomNavigationBarItem(
                    icon: const Icon(Iconsax.clock_copy), label: 'history'.tr),
                BottomNavigationBarItem(
                    icon: const Icon(Iconsax.user_copy), label: 'profile'.tr),
              ],
            ),
          )),
    );
  }
}
