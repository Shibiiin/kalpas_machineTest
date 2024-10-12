import 'package:kalpas/kalpas/data/data_sources/app_dataSource.dart';
import 'package:kalpas/kalpas/data/models/response/apple_article_response_modal.dart';
import 'package:kalpas/kalpas/data/repositories/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final AppDataSource dataSource;

  AppRepositoryImpl(this.dataSource);

  @override
  Future<AppleArticleResponseModal> appleArticle() async {
    final data = await dataSource.appleArticle();
    return data;
  }
}
