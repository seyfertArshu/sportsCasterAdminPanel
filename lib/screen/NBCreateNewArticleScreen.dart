import 'dart:io';

import 'package:agriappadmin/model/request/article/article_model.dart';
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

class NBCreateNewArticleScreen extends StatefulWidget {
  static String tag = '/NBCreateNewArticleScreen';

  @override
  NBCreateNewArticleScreenState createState() =>
      NBCreateNewArticleScreenState();
}

class NBCreateNewArticleScreenState extends State<NBCreateNewArticleScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController twitterIdController = TextEditingController();
  TextEditingController websiteUrlController = TextEditingController();
  TextEditingController slugController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  final articleFormKey = GlobalKey<FormState>();
  String selectCategories = 'Select Categories';
  bool topTrend = false;
  bool latest = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    contentController.dispose();
    categoryController.dispose();
    twitterIdController.dispose();
    descriptionController.dispose();
    websiteUrlController.dispose();
    slugController.dispose();
    super.dispose();
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
                nbAppTextFieldWidget(
                    authorController, 'Write Author Name', TextFieldType.OTHER),
                //title
                16.height,
                Text('Title', style: boldTextStyle()),
                8.height,
                nbAppTextFieldWidget(
                    titleController, 'Write a Title', TextFieldType.OTHER),
                //Content
                16.height,
                Text('Write Content', style: boldTextStyle()),
                8.height,
                TextFormField(
                  controller: contentController,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    filled: true,
                    fillColor: grey.withOpacity(0.1),
                    hintText: 'Write Content here',
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
                    hintText: 'Write Description here',
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
                    'Write TwitterId here', TextFieldType.OTHER),
                //website
                16.height,
                Text('Website URL', style: boldTextStyle()),
                8.height,
                nbAppTextFieldWidget(websiteUrlController, 'Write Website Url',
                    TextFieldType.OTHER),
                16.height,
                //slug

                Text('Slug', style: boldTextStyle()),
                8.height,
                nbAppTextFieldWidget(
                    slugController, 'Write Slug here', TextFieldType.OTHER),
                16.height,
                //categories
                Text('Categories', style: boldTextStyle()),
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
                      if (ImageUploaderProvier.imageFil.isEmpty &&
                          ImageUploaderProvier.imageUrl == null) {
                        Get.snackbar("Image Missing",
                            "Please Upload an Image to Procceed",
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                            icon: const Icon(Icons.add_alert));
                      } else {
                        //print(ImageUploaderProvier.imageUrl.toString());

                        ArticleModel model = ArticleModel(
                          auther: authorController.text,
                          title: titleController.text,
                          description: descriptionController.text,
                          imageUrl: ImageUploaderProvier.imageUrl.toString(),
                          slug: slugController.text,
                          content: contentController.text,
                          category: categoryController.text,
                          twitterId: twitterIdController.text,
                          topTrend: topTrend,
                          websiteUrl: websiteUrlController.text,
                          //latest: latest,
                          //adminId: ,
                        );
                        articleProvider.createArticlefuc(model);
                      }
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
