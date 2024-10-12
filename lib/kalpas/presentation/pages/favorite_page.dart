import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalpas/kalpas/presentation/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../manager/dashBoard_controller.dart';
import '../widgets/news_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashBoardController>(
        builder: (context, controller, child) {
          if (controller.favList.isEmpty) {
            return const Center(child: Text("No favorite articles yet."));
          } else {
            return ListView.builder(
              itemCount: controller.favList.length,
              itemBuilder: (context, index) {
                final article = controller.favList[index];
                return Dismissible(
                  key: ValueKey(article.url),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.addToWishList(article, context);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NewsViewWidget(
                      article: article,
                      ontap: () {
                        context.push(AppRoutes.description,
                            extra: controller.favList[index]);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
