import 'package:flutter/material.dart';
import 'package:kalpas/injector.dart';
import 'package:kalpas/kalpas/presentation/manager/dashBoard_controller.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => DashBoardController(
        getIt(),
      ),
      child: const MyApp(),
    ),
  );
}
