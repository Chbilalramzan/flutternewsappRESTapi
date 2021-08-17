import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localnews/data/api.dart';
import 'package:localnews/helper/SharedPreferences.dart';
import 'package:localnews/models/NewsModel.dart';
import 'package:localnews/screens/auth/InitializationScreen.dart';
import 'package:localnews/screens/auth/login_screen.dart';
import 'package:localnews/styles/app_colors.dart';
import 'package:localnews/widgets/news_card.dart';

class UnAuthHomeScreen extends StatefulWidget {
  UnAuthHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UnAuthHomeScreenState createState() => _UnAuthHomeScreenState();
}

class _UnAuthHomeScreenState extends State<UnAuthHomeScreen> {
  final api = Api();
  List<NewsModel> newsModel = [];

  @override
  void initState() {
    api.getNewsList().then((value) => setState(() {
          newsModel = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Local News',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
              );
            },
            child: Text(
              'Sign In! Please',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightGreyBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: newsModel.length,
                    itemBuilder: (BuildContext context, int index) => NewsCard(
                      news: newsModel[index],
                      isAdmin: false,
                      onRefresh: () {},
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
