import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalpas/kalpas/presentation/routes/app_routes.dart';

import '../../../injector.dart';
import '../manager/dashBoard_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DashBoardController controller = DashBoardController(getIt());
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.go(AppRoutes.dashboard);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Splash Screen',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: LinearProgressIndicator(
                color: Colors.blue,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
