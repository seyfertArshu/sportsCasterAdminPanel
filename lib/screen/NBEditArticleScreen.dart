import 'dart:io';

import 'package:agriappadmin/model/request/article/article_model.dart';
import 'package:agriappadmin/model/response/articlesResponse/article_response.dart';
import 'package:agriappadmin/provider/create_article_provider.dart';
import 'package:agriappadmin/provider/image_uploader_provider.dart';
import 'package:agriappadmin/screen/NBCategoryScreen.dart';
import 'package:agriappadmin/services/helpers/image_uploader.dart';
import 'package:agriappadmin/utils/NBColors.dart';
import 'package:agriappadmin/utils/NBDottedBorder.dart';
import 'package:agriappadmin/utils/NBWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class NBEditNewsArticleScreen extends StatefulWidget {
  static String tag = '/NBEditNewsArticleScreen';
  final ArticleResponse? newsDetails;

  NBEditNewsArticleScreen({this.newsDetails});

  @override
  NBEditNewsArticleScreenState createState() => NBEditNewsArticleScreenState();
}

class NBEditNewsArticleScreenState extends State<NBEditNewsArticleScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController twitterIdController = TextEditingController();
  TextEditingController websiteUrlController = TextEditingController();
  //add website url extfild
  TextEditingController descriptionController = TextEditingController();
  final articleFormKey = GlobalKey<FormState>();
  String selectCategories = 'Select Categories';
  bool topTrend = false;
  bool latest = false;

  @override
  void initState() {
    super.initState();
    // Set the initial values of the article

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
    var articleProvider = Provider.of<CreateArticleProvider>(context);

    return Scaffold(
      appBar: nbAppBarWidget(context, title: 'Create New Article'),
      body: Consumer<CreateArticleProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Form(
            key: articleFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                16.height,
                Consumer<ImageUploaderProvier>(
                    builder: (context, ImageUploaderProvier, child) {
                  return ImageUploaderProvier.imageFil.isEmpty
                      ? GestureDetector(
                          onTap: () {
                            ImageUploaderProvier.pickImage();
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8.0),
                            child: Container(
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.image_outlined),
                                  8.width,
                                  Text('Add Article Cover',
                                      style: boldTextStyle()),
                                ],
                              ),
                            ),
                          ),
                        )
                      //give Image
                      : GestureDetector(
                          onTap: () {
                            ImageUploaderProvier.imageFil.clear();
                            setState(() {});
                            //ImageUploaderProvier.pickImage();
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8.0),
                            child: Container(
                              height: 200,
                              width: MediaQuery.sizeOf(context).width,
                              child: Image.file(
                                File(ImageUploaderProvier.imageFil[0]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                }),
                //title
                16.height,
                Text('Author Name', style: boldTextStyle()),
                8.height,
                nbAppTextFieldWidget(authorController,
                    widget.newsDetails!.auther, TextFieldType.OTHER),
                //title
                16.height,
                Text('Title', style: boldTextStyle()),
                8.height,
                nbAppTextFieldWidget(titleController, widget.newsDetails!.title,
                    TextFieldType.OTHER),
                //Content
                16.height,
                Text('Write Content', style: boldTextStyle()),
                8.height,
                TextFormField(
                  controller: contentController,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    filled: true,
                    fillColor: grey.withOpacity(0.1),
                    hintText: widget.newsDetails!.content,
                    hintStyle: secondaryTextStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                  ),
                ),

                //write article
                16.height,
                Text('Write Description', style: boldTextStyle()),
                8.height,
                TextFormField(
                  controller: descriptionController,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    filled: true,
                    fillColor: grey.withOpacity(0.1),
                    hintText: widget.newsDetails!.description,
                    hintStyle: secondaryTextStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                  ),
                ),
                //categoies
                16.height,
                //twitterId
                Text('Twitter Id', style: boldTextStyle()),
                8.height,
                nbAppTextFieldWidget(twitterIdController,
                    widget.newsDetails!.twitterId, TextFieldType.OTHER),
                16.height,

                Text('Categories', style: boldTextStyle()),
                8.height,
                Text('Selected Category :  ${widget.newsDetails!.category}',
                    style: boldTextStyle(color: Colors.grey, size: 14)),
                8.height,
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: grey.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectCategories, style: boldTextStyle()),
                      PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'football',
                            child: Text('Football'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'cricket',
                            child: Text('Cricket'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'tennis',
                            child: Text('Tennis'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'others',
                            child: Text('Others'),
                          ),

                          // Add more PopupMenuItem widgets for additional categories
                        ],
                        onSelected: (String selectedCategory) {
                          // Handle the selected category
                          print('Selected category: $selectedCategory');
                          categoryController.text = selectedCategory;
                          setState(() {
                            selectCategories = selectedCategory;
                          });
                        },
                        icon: Icon(Icons.arrow_forward_ios_outlined, size: 20),
                      ),
                    ],
                  ),
                ),
                8.height,
                Text('Selected Toggle :  ${widget.newsDetails!.topTrend}',
                    style: boldTextStyle(color: Colors.grey, size: 14)),
                16.height,

                SwitchListTile(
                  value: topTrend,
                  activeColor: NBPrimaryColor,
                  onChanged: (value) {
                    setState(
                      () {
                        topTrend = value;
                      },
                    );
                  },
                  title: Text('Top Trending', style: boldTextStyle()),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.all(0),
                ),
                //latest
                16.height,
                Consumer<ImageUploaderProvier>(
                    builder: (context, ImageUploaderProvier, child) {
                  return nbAppButtonWidget(
                    context,
                    'Publish',
                    () {
                      //finish(context);

                      ArticleModel model = ArticleModel(
                        auther: authorController.text.isNotEmpty
                            ? authorController.text
                            : widget.newsDetails!.auther,
                        title: titleController.text.isNotEmpty
                            ? titleController.text
                            : widget.newsDetails!.title,
                        description: descriptionController.text.isNotEmpty
                            ? descriptionController.text
                            : widget.newsDetails!.description,
                        content: contentController.text.isNotEmpty
                            ? contentController.text
                            : widget.newsDetails!.content,
                        category: categoryController.text.isNotEmpty
                            ? categoryController.text
                            : widget.newsDetails!.category,
                        twitterId: twitterIdController.text.isNotEmpty
                            ? twitterIdController.text
                            : widget.newsDetails!.twitterId,
                        websiteUrl: websiteUrlController.text,

                        topTrend: topTrend,
                        imageUrl: widget.newsDetails!.imageUrl.isNotEmpty
                            ? widget.newsDetails!.imageUrl
                            : ImageUploaderProvier.imageUrl.toString(),
                        //latest: latest,
                        //adminId: ,
                      );
                      articleProvider.updateArticlefuc(
                          model, widget.newsDetails!.id);
                    },
                  );
                }),
                16.height,
              ],
            ).paddingOnly(left: 16, right: 16),
          ),
        );
      }),
    );
  }
}
