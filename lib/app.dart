import 'package:flutter/material.dart';
import 'package:kalpas/kalpas/presentation/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppPages().goRouter,
    );
  }
}
