import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/news_channel_headline.dart';
class NewsRepository{


  Future<NewsChannelHeadlinesModel> fetchnewsheadlines(String channelName) async {
    String url= 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=fa9501197e8f4db891b4883c2dccf565';
    final response= await http.get(Uri.parse(url));

   if(response.statusCode==200){
     final body=jsonDecode(response.body);
     return NewsChannelHeadlinesModel.fromJson(body);

   }
   throw Exception('Throw');

  }

}