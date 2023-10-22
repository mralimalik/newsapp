import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum Filterlist{bbcNews, alJazeera,cnn,independent}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  Filterlist? selectedMenu;
  final format = DateFormat('MMMM dd,yyyy');
  String name='bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.category,
          color: Colors.black,
          size: 30,
        ),
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<Filterlist>(
            onSelected: (Filterlist item){
              if(Filterlist.bbcNews.name==item.name){
                name='bbc-news';
              };
              if(Filterlist.alJazeera.name==item.name){
                name='al-jazeera-english';
              };
              if(Filterlist.cnn.name==item.name){
                name='cnn';
              };

              setState(() {
                selectedMenu=item;

              });
            },
            icon: Icon(Icons.more,color: Colors.black,),
            initialValue: selectedMenu,
            itemBuilder: (context)=> <PopupMenuEntry<Filterlist>>[
            PopupMenuItem(
              value: Filterlist.bbcNews,
              child: Text("BBC News"),
              ),
            PopupMenuItem(
              value: Filterlist.alJazeera,
              child: Text("al Jazeera"),
              ),

            PopupMenuItem(
              value: Filterlist.cnn,
              child: Text("CNN"),
              ),

              ],

         )

        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.5,
            width: width,
            child: FutureBuilder(
                future: newsViewModel.fetchnewsheadlines(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitFadingCircle(
                      size: 40,
                      color: Colors.black,
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.02),
                                  height: height * 0.6,
                                  width: width * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString()),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.bottomCenter,
                                      height: height * 0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.7,
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
