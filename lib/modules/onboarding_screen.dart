import 'package:flutter/material.dart';
import 'package:shopping/modules/login_screen.dart';
import 'package:shopping/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String image;
  String title;
  String description;

  BoardingModel({required this.image, required this.title,required this.description});
}

class OnBoarding extends StatefulWidget {

  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var pageView=PageController();
  bool isLast=false;
  List<BoardingModel>boarding=[
    BoardingModel(image: "assets/images/Online_shopping.png", title: "Browse our product ",description: "browse our list of highest trending products and our hot offers"),
    BoardingModel(image: "assets/images/Add_to_cart.png", title: "Add to cart",description: "choose items to purchase without actually completing the payment"),
    BoardingModel(image: "assets/images/credit_card.png", title: "Pay by card",description: "quick and easy payment, Accept debit, credit and commercial cards"),
    BoardingModel(image: "assets/images/Order_confirmed.png", title: "Order confirmed ",description: "finally, we will send you a shipping confirmation email"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child:PageView.builder(
                  itemBuilder: (context, index) => onBoarding(boarding[index]),
                  controller: pageView,
                  physics: const BouncingScrollPhysics(),
                  itemCount:boarding.length,
                  onPageChanged: (int index){
                    if(index==boarding.length-1){
                      setState(() {
                        isLast=true;
                      });
                    }
                    else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                )
            ),
            const SizedBox(height: 60,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageView,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,
                    spacing: 10,
                  ),
                ),
                const Spacer(),
                IconButton(onPressed: (){
                  if(isLast==true){
                    navigateAndFinish(context, const Login());
                  }
                  else{
                    pageView.nextPage(
                    duration:const Duration(
                      milliseconds: 750,
                    ) ,
                    curve: Curves.fastLinearToSlowEaseIn,
                  );}

                },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                    ))
              ],
            ),
            const SizedBox(height: 30,)
          ],
        ),
      )
    );
  }
}

Widget onBoarding(BoardingModel boardingModel){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage(
            boardingModel.image
        ),
        ),
      ),
      Text(boardingModel.title,
      style: const TextStyle(
        fontFamily: "PermanentMarker",
        fontSize: 25
      ),),
      const SizedBox(height:10,),
      Text(boardingModel.description,
        style: TextStyle(
            fontFamily: "PermanentMarker",
            fontSize: 16,
          color: Colors.grey.shade400
        ),),
    ],
  );
}
