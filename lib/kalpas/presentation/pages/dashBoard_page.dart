import 'package:flutter/material.dart';
import 'package:kalpas/kalpas/presentation/manager/dashBoard_controller.dart';
import 'package:kalpas/kalpas/presentation/pages/favorite_page.dart';
import 'package:provider/provider.dart';

import '../theme/app_colors.dart';
import '../widgets/news_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    final controller = Provider.of<DashBoardController>(context, listen: false);

    controller.getNewsApi();
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
        bottom: TabBar(
          unselectedLabelColor: Colors.blueGrey,
          controller: tabController,
          tabs: const [
            Tab(text: 'News', icon: Icon(Icons.article)),
            Tab(
                icon: Icon(Icons.favorite, color: AppColors.red),
                child:
                    Text("Favorites", style: TextStyle(color: AppColors.red))),
          ],
        ),
      ),
      body: Consumer<DashBoardController>(
        builder: (context, controller, child) {
          return TabBarView(
            controller: tabController,
            children: const [
              NewsWidget(),
              FavoritePage(),
            ],
          );
        },
      ),
    );
  }
}
