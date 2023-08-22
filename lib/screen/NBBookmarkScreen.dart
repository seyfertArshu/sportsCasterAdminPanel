import 'package:agriappadmin/model/NBModel.dart';
import 'package:agriappadmin/provider/create_article_provider.dart';
import 'package:agriappadmin/provider/get_articles_provider.dart';
import 'package:agriappadmin/screen/NBEditArticleScreen.dart';
import 'package:agriappadmin/screen/NBNewsDetailsScreen.dart';
import 'package:agriappadmin/utils/NBColors.dart';
import 'package:agriappadmin/utils/NBDataProviders.dart';
import 'package:agriappadmin/utils/NBWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class NBBookmarkScreen extends StatefulWidget {
  static String tag = '/NBBookmarkScreen';

  @override
  NBBookmarkScreenState createState() => NBBookmarkScreenState();
}

class NBBookmarkScreenState extends State<NBBookmarkScreen> {
  List<String> dropDownItems = ['football', 'cricket', 'tennis', 'others'];
  List<NBNewsDetailsModel> newsList = nbGetNewsDetails();
  List<NBNewsDetailsModel> bookmarkNewsList = [];

  String? dropDownValue = 'football';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    newsList.forEach((element) {
      if (element.isBookmark) {
        bookmarkNewsList.add(element);
      }
    });
  }

  //alert Dialouge
  Future<bool> showConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this article?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Return false when cancel is pressed
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Return true when delete is pressed
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var articleProvider = Provider.of<CreateArticleProvider>(context);

    return Scaffold(
      appBar: nbAppBarWidget(context, title: 'News Articles'),
      body: Consumer<getArticleProvider>(
          builder: (context, getArticleProvider, child) {
        getArticleProvider.getArticles(dropDownValue!);
        return bookmarkNewsList.length != 0
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sort by', style: primaryTextStyle()),
                        DropdownButton(
                          value: dropDownValue,
                          items: List.generate(
                            dropDownItems.length,
                            (index) {
                              return DropdownMenuItem(
                                child: Text('${dropDownItems[index]}',
                                    style: boldTextStyle()),
                                value: dropDownItems[index],
                              );
                            },
                          ),
                          onChanged: (dynamic value) {
                            setState(
                              () {
                                dropDownValue = value;
                                toasty(context, dropDownValue);
                              },
                            );
                          },
                        ),
                      ],
                    ),

                    //
                    FutureBuilder(
                        future: getArticleProvider.articleList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("article is waiting");
                          } else if (snapshot.hasError) {
                            return Text("Error ${snapshot.error}");
                          } else {
                            final article = snapshot.data;
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: article!.length,
                              itemBuilder: (context, index) {
                                final articles = article[index];
                                // NBNewsDetailsModel mData =
                                //     bookmarkNewsList[index];
                                return Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      commonCachedNetworkImage(
                                        articles.imageUrl,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      )
                                          .cornerRadiusWithClipRRect(16)
                                          .expand(flex: 1),
                                      16.width,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(articles.category,
                                              style: boldTextStyle(
                                                  color: NBPrimaryColor)),
                                          Text(articles.title,
                                              style: boldTextStyle(),
                                              softWrap: true,
                                              maxLines: 3),
                                          8.height,
                                          Text(articles.createdAt.toString(),
                                              style: secondaryTextStyle()),
                                        ],
                                      ).expand(flex: 2),
                                      PopupMenuButton(
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              height: 10,
                                              child: Text(
                                                'Edit Article',
                                                style: boldTextStyle(),
                                              ),
                                              value: 'Edit',
                                            ),
                                            PopupMenuItem(
                                              height: 10,
                                              child: Text(
                                                'Remove',
                                                style: boldTextStyle(),
                                              ),
                                              value: 'Remove',
                                            ),
                                          ];
                                        },
                                        onSelected: (dynamic value) {
                                          setState(
                                            () async {
                                              //remove
                                              if (value == 'Remove') {
                                                bool confirmed =
                                                    await showConfirmationDialog(
                                                        context);

                                                if (confirmed) {
                                                  // Proceed with the deletion logic here
                                                  articleProvider
                                                      .deleteArticlefuc(
                                                          articles.id);
                                                }
                                              }
                                              //Edit
                                              if (value == 'Edit') {
                                                //navigate to edit Screen
                                                NBEditNewsArticleScreen(
                                                        newsDetails: articles)
                                                    .launch(context);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ).onTap(() {
                                  NBNewsDetailsScreen(newsDetails: articles)
                                      .launch(context);
                                });
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                            );
                          }
                        }),
                    // child: ListView
                  ],
                ).paddingOnly(left: 16, right: 16),
              )
            : Center(
                child: Text('No Data Found', style: boldTextStyle()),
              );
      }),
    );
  }
}
