

import 'package:flutter/material.dart';

import '../../Data/models/home_data_model.dart';
import '../../Presenter/bloc_file/cubit_page.dart';
import '../../views/item_details_screen.dart';

Widget buildGridProduct(ProductModel model,BuildContext context) {

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemDetailsScreen(id:model.id, name: model.name, price: model.price, image: model.image, description: model.description, images: model.images)));
          },
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image ?? ''),
                width: double.infinity,
                height: 200,
                fit: BoxFit.fill,
              ),
              if (model.discount != null && model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: <Widget>[
                Text(
                  '\$${model.price}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (model.discount != null && model.discount != 0)
                  if (model.price < 1000.01)
                    Text(
                      '${model.oldPrice}',
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                const Spacer(),


                IconButton(
                  onPressed: () {
                    AppCubit.get(context).addDeleteFavorites( productId: model.id!);

                  },
                  icon: Icon(
                    Icons.favorite,
                    color:AppCubit.get(context).favoritesIdsSet.contains(model.id)? Colors.red:Colors.grey,

                  ),),
              ],
            ),
          ],
        ),
      ],
    ),
  );

}