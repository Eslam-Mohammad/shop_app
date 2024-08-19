import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Core/reusable_items/product_home_display.dart';
import '../Presenter/bloc_file/cubit_page.dart';
import '../Presenter/bloc_file/state_page.dart';


class HomeScreenInNavigationBar extends StatelessWidget {
  const HomeScreenInNavigationBar({super.key});

  @override
  Widget  build(BuildContext context) {
    var cubit = AppCubit.get(context);


    return BlocConsumer<AppCubit,AppStates>(builder: (context,state){

      return  ConditionalBuilder(
          condition: cubit.homeModel != null &&
              cubit.homeModel?.data != null &&
              (cubit.homeModel?.data?.products.isNotEmpty?? false),
          builder: (context) {
            List<Widget> bannerImages = cubit.homeModel?.data?.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList()?? [const CircularProgressIndicator()];
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(
                        items: [...bannerImages],
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Best Selling Products',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // i will make it by grid view
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1 / 1.7,
                      children: List.generate(
                          cubit.homeModel!.data!.products.length,
                              (index) => buildGridProduct(
                              cubit.homeModel!.data!.products[index],context)),
                    ),
                  ],
                ),
              ),
            );},
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
    }, listener: (context, state) {},);
  }
}