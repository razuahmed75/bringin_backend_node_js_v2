import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'res/app_themes.dart';
import 'utils/routes/route_helper.dart';
import 'utils/services/bindings/dependencies.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown, 
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bringin',
          theme: LightTheme,
          initialBinding: InitDependencies(),
          initialRoute: RouteHelper.getInitialRoute(),
          getPages: RouteHelper.routes(),
        );
      },
    );
  }
}
