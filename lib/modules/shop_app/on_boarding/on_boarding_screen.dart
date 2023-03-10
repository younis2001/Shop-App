

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../login_screen/login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
 bool isLast=false;
 void submit(){
   CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>LoginScreen()));
   });
 }

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'images/onboard.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'images/onboard.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'images/onboard.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index){
                    if(index==boarding.length-1){
                      setState(() {
                        isLast=true;
                      });
                    }else
                      setState(() {
                        isLast=false;
                      });
                  },
                    controller: boardController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        BuildItemBoarding(boarding[index]),
                    itemCount: boarding.length),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(

                      controller: boardController,
                      count: boarding.length,

                  effect:ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.5) ,),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLast){
                        submit();
                      }
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.easeInOutQuint);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget BuildItemBoarding(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(width: double.infinity,
                child: Image(image: AssetImage('${model.image}'))),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      );
}
