import 'package:agriappadmin/main.dart';
import 'package:agriappadmin/model/NBModel.dart';
import 'package:agriappadmin/utils/NBColors.dart';
import 'package:agriappadmin/utils/NBDataProviders.dart';
import 'package:agriappadmin/utils/NBWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NBLanguageScreen extends StatefulWidget {
  static String tag = '/NBLanguageScreen';

  @override
  NBLanguageScreenState createState() => NBLanguageScreenState();
}

class NBLanguageScreenState extends State<NBLanguageScreen> {
  List<NBLanguageItemModel> mLanguageList = nbGetLanguageItems();

  int selectedIndex = 1;

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
            finish(context, mLanguageList[selectedIndex]);
          },
        ),
        title: Text('Select Language', style: boldTextStyle(size: 20)),
        backgroundColor: context.cardColor,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: mLanguageList.length,
        itemBuilder: (_, index) {
          return Row(
            children: [
              Row(
                children: [
                  commonCachedNetworkImage('${mLanguageList[index].image}',
                      height: 30),
                  8.width,
                  Text('${mLanguageList[index].name}',
                      style: primaryTextStyle()),
                ],
              ).expand(),
              index == selectedIndex
                  ? Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: NBPrimaryColor,
                    )
                  : SizedBox(),
            ],
          ).paddingOnly(top: 8, bottom: 8).onTap(
            () {
              setState(
                () {
                  selectedIndex = index;
                },
              );
              finish(context, mLanguageList[selectedIndex]);
            },
          );
        },
      ),
    );
  }
}
