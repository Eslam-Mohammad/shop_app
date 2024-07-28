import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetailsScreen extends StatelessWidget {
   ItemDetailsScreen({super.key, required this.id, required this.name, required this.price, required this.image, required this.description, required this.images});
  final int? id;
  final num ?price;
  final String? image;
  final String? name;
  final String ?description;
  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(builder: (context,state){
      return Scaffold(
        appBar: AppBar(),
        body: const Center(),
      );
    }, listener: (context,state){});
  }
}
