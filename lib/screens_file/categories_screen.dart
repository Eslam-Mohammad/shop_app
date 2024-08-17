import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_file/cubit_page.dart';
import 'package:shop_app/bloc_file/state_page.dart';
import 'package:shop_app/classes/categories_data_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,


    ];
    List<String> names = [
      'Clothes',
      'Electronics',
      'Beauty',
      'Sports',
      'Home',

      'Toys',
      'Books',

      'Grocery',
    ];
    List<String>myImages = [
      'images/brand.png',
      'images/electric-appliance.png',
      'images/makeup.png',
      'images/sports.png',
      'images/house.png',
      'images/toys.png',
      'images/read.png',
      'images/grocery.png',




    ];

    return BlocConsumer<AppCubit,AppStates>(builder:(context,state){


      return  Scaffold(

        body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
            itemBuilder: (context, index) => buildCategoryItemSecondDesign(color: colors[index],name: names[index],image: myImages[index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: 8),
      );
    }, listener: (context,state){});
  }
}


Widget buildCategoryItemFirstDesign(CategoryModel model, int index) {


  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.data!.data2[index].image!),
          width: double.infinity,
          height: 250,
          fit: BoxFit.fill,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            model.data!.data2[index].name!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
  );
}





Widget buildCategoryItemSecondDesign(
    {Color color=Colors.orange, String name = 'Clothes', String image='images/brand.png'}) {
  return  InkWell(
    onTap: (){},
    child: Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.white, // Border color
          width: 4, // Border width
        ),
        borderRadius: BorderRadius.circular(30), // Border radius
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0,left: 30,right: 35,bottom: 15.0), // Padding inside the container
        child: Row(
          children: [
            Text(
              name,style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontFamily: 'Playwrite',
              fontWeight: FontWeight.bold,
            ),
            ),
            const Spacer(),
            SizedBox(
              width: 70,
              height: 100,
              child: Image.asset(
                image,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
      ),
    ),
  );

}