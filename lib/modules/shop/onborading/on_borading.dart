import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/shop/login/login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';


class Boarding {
  final String image;
  final String title;
  final String body;

  Boarding({@required this.image, @required this.title, @required this.body});
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var controller = PageController();

  List<Boarding> boarding = [
    Boarding(
      image: 'assets/images/onborading_2.jpg',
      title: 'OnBoard 1 Title',
      body: 'OnBoard 1 body',
    ),
    Boarding(
      image: 'assets/images/onborading_1.jpg',
      title: 'OnBoard 2 Title',
      body: 'OnBoard 2 body',
    ),
    Boarding(
      image: 'assets/images/onborading_3.jpg',
      title: 'OnBoard 3 Title',
      body: 'OnBoard 3 body',
    ),
  ];

  bool lastscreen = false;

  void submit() {
    CacheHelper.savedata(key: 'onboarding', value: true).then((value) {
      {
        if (value) {
          navigateand(context, LoginScreen());
        } else {

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(

                onPressed: () {
                  navigateand(context, LoginScreen());
                },
                child: Text(
                  'Skip',
                )),
            SizedBox(width: 5,)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        lastscreen = true;
           //             print('last');
                      });
                    } else {
                      setState(() {
                        lastscreen = false;
                      });
                      print('not last');
                    }
                  },
                  controller: controller,
                  itemBuilder: (context, index) => OnBorading(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: controller,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.deepOrange,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                      ),
                      count: boarding.length),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (lastscreen) {
                        submit();
                      } else {}
                      controller.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.bounceIn);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget OnBorading(Boarding model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(
            height: 25,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 14,
          ),
          Text('${model.body}'),
          SizedBox(
            height: 25,
          ),
        ],
      );
}
// Text Editing Controller
