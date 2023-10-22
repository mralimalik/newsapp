import 'package:newsapp/models/news_channel_headline.dart';
import 'package:newsapp/repository/news_repository.dart';

class NewsViewModel{

  final repo= NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchnewsheadlines(String channelName) async {
    final response= await repo.fetchnewsheadlines(channelName);
    return response;
  }
}