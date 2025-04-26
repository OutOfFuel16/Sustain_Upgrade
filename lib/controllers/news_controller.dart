import 'dart:convert';
import 'package:campus_carbon/models/article_model.dart';
import 'package:campus_carbon/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  // for list view
  List<ArticleModel> allNews = <ArticleModel>[];
  // for carousel
  List<ArticleModel> breakingNews = <ArticleModel>[];
  ScrollController scrollController = ScrollController();
  RxBool articleNotFound = false.obs;
  RxBool isLoading = false.obs;
  RxString cName = ''.obs;
  RxString country = ''.obs;
  RxString category = ''.obs;
  RxString channel = ''.obs;
  RxString searchNews = ''.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 10.obs;
  String baseUrl = "https://newsapi.org/v2/everything?q=(carbon+AND+footprint)+OR+sustainability&apiKey=b8fb5fce80744678aed9b79bf1a91891"; // ENDPOINT

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);
    getAllNewsFromApi();

    super.onInit();
  }

  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading.value = true;
      getAllNewsFromApi();
    }
  }



  // function to retrieve a JSON response for all news from newsApi.org
  getAllNewsFromApi() async {
    //Creates a new Uri object by parsing a URI string.
    http.Response res = await http.get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      //Parses the string and returns the resulting Json object.
      NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          // combining two list instances with spread operator
          allNews = [...allNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            allNews = newsData.articles;
            // list scrolls back to the start of the screen
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotFound.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotFound.value = true;
      update();
    }
  }
}
