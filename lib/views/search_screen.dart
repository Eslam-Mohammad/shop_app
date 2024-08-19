import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Data/models/search_model.dart';
import '../Presenter/bloc_file/cubit_page.dart';
import '../Presenter/bloc_file/state_page.dart';
import 'item_details_screen.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {


      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your search';
                    }
                    return null;
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.deepPurple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AppCubit.get(context).search(text: searchController.text);
                      }
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                if (state is SearchLoadingState)
                  const LinearProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                if (state is SearchSuccessState)
                  if (AppCubit.get(context).searchModel!.data!.data!.isEmpty&& AppCubit.get(context).searchModel != null)
                    const Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'No Data Found',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => itemBuilder(
                          context,
                          AppCubit.get(context).searchModel!,
                          index,
                        ),
                        itemCount: AppCubit.get(context)
                            .searchModel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {});
  }
}

Widget itemBuilder(BuildContext context, SearchModel model, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        // code to navigate to item details
        Navigator.push(context,MaterialPageRoute(builder: (context)=>ItemDetailsScreen(id: model.data!.data![index].id,name: model.data!.data![index].name,
        price: model.data!.data![index].price,image: model.data!.data![index].image,description: model.data!.data![index].description,images:model.data!.data![index].images ,)));
      },
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image(
              image: NetworkImage(model.data!.data![index].image!),
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.data!.data![index].name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '\$${model.data!.data![index].price!}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}