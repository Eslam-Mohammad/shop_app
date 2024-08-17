import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_file/cubit_page.dart';
import 'package:shop_app/classes/cart_mode.dart';
import 'package:shop_app/screens_file/home_screen.dart';

import '../bloc_file/state_page.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});



  Widget itemBuilder(BuildContext context,Product? cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image(
              image: NetworkImage(cubit!.image!),
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cubit.name!,maxLines: 2,overflow:TextOverflow.ellipsis, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('\$${cubit.price}', style: const TextStyle(fontSize: 18, color: Colors.blue)),
                    const SizedBox(width: 10),
                    if(cubit.discount != 0)
                      Text('\$${cubit.oldPrice}', style: const TextStyle(fontSize: 18, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                    const Spacer(),
                    IconButton(onPressed: ()async {

                      AppCubit.get(context).addDeleteCart(productId: cubit.id!);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item removed from cart')));

                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));




                    }, iconSize: 35.0,icon: const Icon(Icons.remove_shopping_cart, color: Colors.red)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

var cubit = AppCubit.get(context).cartModel?.data?.cartItems;

    return  BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      return  ConditionalBuilder(
        condition: cubit != null && cubit.isNotEmpty,
        builder: (context) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => itemBuilder(context, cubit[index].product),
                  separatorBuilder: (context, index) => const Divider(thickness: 10.0,),
                  itemCount: cubit!.length,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  Text('Total: \$${AppCubit.get(context).cartModel!.data!.total}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed successfully')));
                    
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                      style: ButtonStyle(
                        backgroundColor:WidgetStateProperty.all(Colors.purpleAccent),
                      ),
                      child: const Text('Order Now',
                      style: TextStyle(fontSize: 20.0,color: Colors.white),)),
                  const Spacer(),]),
            ],
          );
        },
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      );
    },listener:(context,state){});
  }
}
