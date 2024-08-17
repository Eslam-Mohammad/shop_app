import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_file/cubit_page.dart';
import 'package:shop_app/bloc_file/state_page.dart';
import 'package:shop_app/screens_file/home_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
   ItemDetailsScreen({super.key, required this.id, required this.name, required this.price, required this.image, required this.description, required this.images});
  final int? id;
  final num ?price;
   String? image;
  final String? name;
  final String ?description;
  final List<String>? images;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context,state){

      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                AppCubit.get(context).changeIndex(3);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));

              },
              icon: const Icon(size: 30.0,Icons.shopping_cart),
            ),
          ],
        ),
        body: Column(
          children:[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Image(
                        image: NetworkImage(images?[AppCubit.get(context).imageIndex] ?? ''),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              AppCubit.get(context).changeimage(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image(
                                image: NetworkImage(images![index]),
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          itemCount: images!.length,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        name ?? '',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Price: ${price ?? ''}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
              
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.bottomLeft,
                        child: const Text("Description:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20.0,),
                      Text(
                        maxLines: 19,
                        overflow: TextOverflow.ellipsis,
                        description ?? '',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
              
              
              
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0,left: 10.0,right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // make buttons to increase and decrease the quantity of item in cart

                  Container(

                    height: 50.0,
                    width: 200.0,

                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child:  MaterialButton(
                      onPressed: (){
                        AppCubit.get(context).addDeleteCart(productId: id!);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to Cart'),
                                duration: Duration(seconds: 3),
                              ),
                            );


                      },

                      child: const Text('Add to Cart',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      );
    }, listener: (context,state){});
  }
}
