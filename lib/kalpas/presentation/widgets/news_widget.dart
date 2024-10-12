import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kalpas/kalpas/presentation/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/respose_classify.dart';
import '../../data/models/response/apple_article_response_modal.dart';
import '../manager/dashBoard_controller.dart';
import '../routes/app_routes.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardController>(
      builder: (context, controller, child) {
        if (controller.appleList.isEmpty ||
            controller.appleState.status == Status.LOADING) {
          return ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Container(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      subtitle: Container(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return ListView.builder(
            itemCount: controller.appleList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                onDismissed: (direction) {
                  setState(() {
                    controller.addToWishList(
                        controller.appleList[index], context);
                    setState(() {
                      controller.appleList.removeAt(index);
                    });
                  });
                },
                dragStartBehavior: DragStartBehavior.down,
                background: Container(
                  color: AppColors.red,
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.only(left: 5),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Add to Favorite",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.favorite,
                        size: 40,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                key: ValueKey(controller.appleList[index]),
                direction: DismissDirection.endToStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewsViewWidget(
                    article: controller.appleList[index],
                    ontap: () {
                      context.push(AppRoutes.description,
                          extra: controller.appleList[index]);
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class NewsViewWidget extends StatelessWidget {
  final AppleArticle article;
  final Function() ontap;

  const NewsViewWidget({super.key, required this.article, required this.ontap});

  @override
  Widget build(BuildContext context) {
    String formatPublishedDate(String publishedAt) {
      DateTime dateTime = DateTime.parse(publishedAt);

      return '${DateFormat('EEE, dd MMM yyyy, HH:mm').format(dateTime)} GMT';
    }

    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: ontap,
      child: Card(
        child: ListTile(
          title: Text(
            article.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
            maxLines: 2,
          ),
          subtitle: Column(
            children: [
              Text(
                article.description,
                maxLines: 3,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 13,
                  ),
                  Text(
                    formatPublishedDate(article.publishedAt.toString()),
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
          leading: Container(
            height: size.height * 0.095,
            width: size.width * 0.20,
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.red,
                size: 40,
              ),
              imageUrl: article.urlToImage.toString(),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
