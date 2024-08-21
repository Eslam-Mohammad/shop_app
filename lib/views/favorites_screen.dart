import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Data/models/favorites_model.dart';
import '../Presenter/bloc_file/cubit_page.dart';
import '../Presenter/bloc_file/state_page.dart';
import 'home_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  void initState() {
    super.initState();

  }

  Widget itemBuilder(BuildContext context,  FavoritesProducts cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image(
              image: NetworkImage(cubit.image!),
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

                       await AppCubit.get(context).addDeleteFavorites(productId: cubit.id!);

                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item removed from favorites')));

                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));




                    }, iconSize: 35.0,icon: const Icon(Icons.favorite, color: Colors.red)),
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
    var cubit = AppCubit.get(context).favoritesModel?.data?.data2;
    return BlocConsumer<AppCubit,AppStates>(builder: (context, state) {

      return ConditionalBuilder(
        condition: cubit != null && cubit.isNotEmpty,
        builder: (context) {
          return ListView.separated(
            itemBuilder: (context, index) => itemBuilder(context, cubit[index]),
            separatorBuilder: (context, index) =>  Divider(thickness: 2.0,color: Theme.of(context).colorScheme.secondary,),
            itemCount: cubit!.length,
          );
        },
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      );
    } , listener: (context, state) {});
  }
}

