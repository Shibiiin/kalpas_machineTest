import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kalpas/kalpas/data/models/response/apple_article_response_modal.dart';
import 'package:kalpas/kalpas/presentation/manager/dashBoard_controller.dart';
import 'package:provider/provider.dart';

class DescriptionPage extends StatelessWidget {
  final AppleArticle modal;
  const DescriptionPage({super.key, required this.modal});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DashBoardController>(context);
    String formatPublishedDate(String publishedAt) {
      DateTime dateTime = DateTime.parse(publishedAt);

      return '${DateFormat('EEE, dd MMM yyyy, HH:mm').format(dateTime)} GMT';
    }

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(modal.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: size.height * 0.3,
                    width: size.width * 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: modal.urlToImage.toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        controller.isInFavorites(modal)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red),
                    onPressed: () {
                      controller.addToWishList(modal, context);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                modal.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 13,
                  ),
                  Text(
                    formatPublishedDate(modal.publishedAt.toString()),
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                modal.description,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
