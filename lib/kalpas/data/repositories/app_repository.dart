import '../models/response/apple_article_response_modal.dart';

abstract class AppRepository {
  Future<AppleArticleResponseModal> appleArticle();
}
