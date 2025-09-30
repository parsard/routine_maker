import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routine_maker/core/router/app_router.dart'; // فایل روتر را import کنید

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    final router = ref.watch(goRouterProvider); 

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Routine Maker',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fa', ''),
          ],
          locale: const Locale('fa', ''),
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: 'Vazirmatn',
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
          ),
          routerConfig: router,
        );
      },
    );
  }
}
