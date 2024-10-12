import 'package:flutter/material.dart';
import 'package:kalpas/kalpas/core/respose_classify.dart';
import 'package:kalpas/kalpas/core/usecase.dart';
import 'package:kalpas/kalpas/data/models/response/apple_article_response_modal.dart';
import 'package:kalpas/kalpas/domain/use_cases/apple_useCase.dart';

import '../widgets/custom_print.dart';

class DashBoardController extends ChangeNotifier {
  final AppleUseCase appleUseCase;

  DashBoardController(
    this.appleUseCase,
  );
  final List<AppleArticle> appleList = [];

  ResponseClassify appleState =
      ResponseClassify<AppleArticleResponseModal>.error("");

  getNewsApi() async {
    appleState = ResponseClassify.loading();

    try {
      final response = await appleUseCase.call(NoParams());
      customPrint("Response Controller $response");
      appleState = ResponseClassify.completed(response);

      appleState =
          ResponseClassify.completed(await appleUseCase.call(NoParams()));

      appleList.clear();
      customPrint("Apple List Length ${appleList.length}");

      appleList.addAll(response.articles
          .map((article) => AppleArticle(
                title: article.title,
                description: article.description,
                source: article.source,
                author: article.author,
                url: article.url,
                urlToImage: article.urlToImage,
                publishedAt: article.publishedAt,
                content: article.content,
              ))
          .where(
            (element) =>
                element.title != "[Removed]" &&
                element.description != "[Removed]" &&
                element.source != "[Removed]" &&
                element.author != "[Removed]" &&
                element.url != "https://removed.com" &&
                // element.urlToImage != null &&
                element.content != "[Removed]",
          ));
      notifyListeners();
      customPrint("Apple List After adding ${appleList.length}");

      notifyListeners();
    } catch (e) {
      appleState = ResponseClassify.error("$e}");
      customPrint("Failed Error $e");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  ///favorites
  bool isClicked = false;
  final List<AppleArticle> favList = [];

  addToWishList(AppleArticle modal, BuildContext context) async {
    if (isClicked = true) {
      if (favList.any(
        (element) => element.title == modal.title,
      )) {
        favList.remove(modal);
        _showSnackBar(context, "Item is Removed -> ${modal.title}");
      } else {
        favList.add(modal);
        _showSnackBar(context, "Item is Added -> ${modal.title}");
      }
    }
    notifyListeners();
  }

  bool isInFavorites(AppleArticle modal) {
    return favList.any((element) => element.title == modal.title);
  }
}
