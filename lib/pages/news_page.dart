import 'package:campus_carbon/contollers/news_controller.dart';
import 'package:campus_carbon/views/web_view_news.dart';
import 'package:campus_carbon/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text('Related News'),floating: true,),
          SliverList(delegate: SliverChildListDelegate([
            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return controller.articleNotFound.value
                      ? const Center(
                    child: Text('Nothing Found'),
                  )
                      : controller.allNews.isEmpty
                      ? Center(child: Lottie.asset('lib/assets/twodots.json',width:200,height:200))
                      : ListView.builder(
                      controller: controller.scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.allNews.length,
                      itemBuilder: (context, index) {
                        index == controller.allNews.length - 1 &&
                            controller.isLoading.isTrue
                            ? const Center(
                          child: CircularProgressIndicator(),
                        )
                            : const SizedBox();
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewNews(
                                  newsUrl: controller.allNews[index].url,
                                ),
                              ),
                            );
                          },
                          child: NewsCard(
                              imgUrl:
                              controller.allNews[index].urlToImage ??
                                  '',
                              desc: controller.allNews[index].description ??
                                  '',
                              title: controller.allNews[index].title,
                              content:
                              controller.allNews[index].content ?? '',
                              postUrl: controller.allNews[index].url),
                        );
                      });
                }),
          ],
          )),
      ]
        ),
      ),
    );
  }
}
