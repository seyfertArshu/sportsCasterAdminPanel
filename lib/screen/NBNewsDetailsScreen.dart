import 'package:agriappadmin/main.dart';
import 'package:agriappadmin/model/NBModel.dart';
import 'package:agriappadmin/model/response/articlesResponse/article_response.dart';
import 'package:agriappadmin/screen/NBCommentScreen.dart';
import 'package:agriappadmin/utils/NBColors.dart';
import 'package:agriappadmin/utils/NBImages.dart';
import 'package:agriappadmin/utils/NBWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NBNewsDetailsScreen extends StatefulWidget {
  static String tag = '/NBNewsDetailsScreen';

  final ArticleResponse? newsDetails;

  NBNewsDetailsScreen({this.newsDetails});

  @override
  NBNewsDetailsScreenState createState() => NBNewsDetailsScreenState();
}

class NBNewsDetailsScreenState extends State<NBNewsDetailsScreen> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: appStore.isDarkModeOn ? white : black),
          onPressed: () {
            finish(context);
          },
        ),
        elevation: 0,
        backgroundColor: context.cardColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.newsDetails!.category}',
                style: boldTextStyle(color: NBPrimaryColor)),
            Row(
              children: [
                Text('${widget.newsDetails!.title}',
                        style: boldTextStyle(size: 20))
                    .expand(flex: 3),
                IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {
                    setState(
                      () {
                        // widget.newsDetails!.isBookmark =
                        //     !widget.newsDetails!.isBookmark;
                      },
                    );
                    toasty(context, 'Removed from Bookmark');
                  },
                )
              ],
            ),
            16.height,
            commonCachedNetworkImage(
              widget.newsDetails!.imageUrl,
              height: 200,
              width: context.width(),
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(16),
            16.height,
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text('by Jones Hawkins', style: boldTextStyle()),
              subtitle: Text('12 jan 2021', style: secondaryTextStyle()),
              leading:
                  CircleAvatar(backgroundImage: AssetImage(NBProfileImage)),
              trailing: AppButton(
                elevation: 0,
                text: isFollowing ? 'Following' : 'Follow',
                onTap: () {
                  setState(
                    () {
                      isFollowing = !isFollowing;
                    },
                  );
                },
                color: isFollowing ? grey.withOpacity(0.2) : black,
                textColor: isFollowing ? grey : white,
              ).cornerRadiusWithClipRRect(30),
            ),
            16.height,
            Text('${widget.newsDetails!.content}',
                style: primaryTextStyle(), textAlign: TextAlign.justify),
            16.height,
            // nbAppButtonWidget(
            //   context,
            //   'Comment',
            //   () {
            //     NBCommentScreen(widget.newsDetails).launch(context);
            //   },
            // ),
            // 16.height,
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }
}
