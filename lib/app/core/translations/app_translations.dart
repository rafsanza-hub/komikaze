import 'package:get/get.dart';
import 'package:komikaze/app/core/translations/en_US.dart';
import 'package:komikaze/app/core/translations/id_ID.dart';

   class AppTranslations extends Translations {
     @override
     Map<String, Map<String, String>> get keys => {
           'en_US': enUS,
           'id_ID': idID,
         };
   }