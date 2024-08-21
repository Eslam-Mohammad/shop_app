import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
final  pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Column(
                  children: [
                    Image.asset('images/shop_app_image1.jpg'),
                    const SizedBox(height: 20,),
                    const Text('Shop From Home ',style: TextStyle(fontFamily:"Playwrite",fontSize: 35.0,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 20,),
                    const Text('Fashion & Clothes & All u need ',style: TextStyle(fontFamily:"Playwrite",fontSize: 18.0,fontWeight: FontWeight.w400),),
                    const SizedBox(height: 5,),
                    const Text('Shop from the comfort of your home' ,style: TextStyle(fontFamily:"Playwrite",fontSize: 18.0,fontWeight: FontWeight.w400),),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('images/shop_app_image3.jpg'),
                    const SizedBox(height: 60,),
                    const Text('Purchase Online ',style: TextStyle(fontFamily:"Playwrite",fontSize: 35.0,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 20,),
                    const Text('Three methods of payment available',style: TextStyle(fontFamily:"Playwrite",fontSize: 18.0,fontWeight: FontWeight.w400),),
                    const SizedBox(height: 5,),
                    const Text('cash , vodafone cash , credit card' ,style: TextStyle(fontFamily:"Playwrite",fontSize: 18.0,fontWeight: FontWeight.w400),),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('images/shop_app_image2.jpg'),
                    const SizedBox(height: 40,),
                    const Text('Shop Online',style: TextStyle(fontFamily:"Playwrite",fontSize: 35.0,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 20,),
                    const Text('Get discounts on your favorite products',style: TextStyle(fontFamily:"Playwrite",fontSize: 18.0,fontWeight: FontWeight.w400),),
                    const SizedBox(height: 5,),
                    const Text('Take your chance' ,style: TextStyle(fontFamily:"Playwrite",fontSize: 18.0,fontWeight: FontWeight.w400),),
                  ],
                ),
              ],

            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0,left: 10.0,right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }, child: const Text('Skip',style: TextStyle(fontFamily:"Playwrite",fontSize: 18.0,fontWeight: FontWeight.w700),)),

                SmoothPageIndicator(controller: pageController, count: 3,
                  effect: const JumpingDotEffect(
                    jumpScale: 0.9,
                    spacing: 15.0,
                    verticalOffset: 20,
                    dotHeight: 20,
                    dotWidth: 20,
                    activeDotColor: Colors.deepPurpleAccent,
                  ),
                ),

                FloatingActionButton(onPressed: (){
                  if(pageController.page! < 2){
                    pageController.nextPage(duration: const Duration(milliseconds: 450), curve: Curves.easeIn);
                  }else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }
                },
                shape: const CircleBorder(),backgroundColor: Colors.deepPurpleAccent,child: const Icon(Icons.arrow_forward_ios),),
              ],
            ),
          ),

        ],
      ),
    );
  }







}