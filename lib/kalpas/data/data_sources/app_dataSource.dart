import 'package:kalpas/kalpas/core/api_provider.dart';
import 'package:kalpas/kalpas/data/models/response/apple_article_response_modal.dart';
import 'package:kalpas/kalpas/data/remotes_routes/app_remotes.dart';
import 'package:kalpas/kalpas/presentation/widgets/custom_print.dart';

abstract class AppDataSource {
  Future<AppleArticleResponseModal> appleArticle();
}

class AppDataSourceImple extends AppDataSource {
  final ApiProvider apiProvider;

  AppDataSourceImple(this.apiProvider);

  @override
  Future<AppleArticleResponseModal> appleArticle() async {
    final data = await apiProvider
        .get("${AppRemoteRoutes.appleArticle}${AppRemoteRoutes.apiKey}");
    var res = AppleArticleResponseModal.fromJson(data);
    customPrint("AppDataSource Apple $res");
    return res;
  }
}
