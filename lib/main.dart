import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ArielSchool/app/Reusables_Components/Customs_reusables_Widget.dart';
import 'package:ArielSchool/app/data/objecbox_store.dart';
import 'app/routes/app_pages.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  await Future.delayed(Duration(seconds: 1));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AFRICATECH",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary_Color),
        useMaterial3: false,
      ),
    ),
  );
}
