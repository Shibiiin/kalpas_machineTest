import 'package:kalpas/kalpas/core/usecase.dart';
import 'package:kalpas/kalpas/data/models/response/apple_article_response_modal.dart';
import 'package:kalpas/kalpas/data/repositories/app_repository.dart';
import 'package:kalpas/kalpas/presentation/widgets/custom_print.dart';

class AppleUseCase extends UseCase<AppleArticleResponseModal, NoParams> {
  final AppRepository appRepository;

  AppleUseCase(this.appRepository);

  @override
  Future<AppleArticleResponseModal> call(NoParams params) async {
    final data = await appRepository.appleArticle();
    customPrint("APPle UseCase $data");
    return data;
  }
}
