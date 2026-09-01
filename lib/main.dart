import 'package:circlo/core/router/router.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: "Circlo",
        theme: ThemeData(
          appBarTheme: AppBarThemeData(
            backgroundColor: AppColors.background,
            // elevation: 2,
            scrolledUnderElevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.lightGrey),
            ),
            centerTitle: true,
            titleTextStyle: AppFonts.screenTitle.copyWith(
              color: AppColors.primary,
            ),
          ),
          scaffoldBackgroundColor: AppColors.background,
        ),
      ),
    );
  }
}
