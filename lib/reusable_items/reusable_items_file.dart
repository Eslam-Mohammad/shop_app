import 'package:flutter/material.dart';

Widget searchTextField()
{
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 80, right: 20),
    child: TextFormField(

      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: const Icon(Icons.search,size: 30.0,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[400],
      ),

    ),
  );
}



class CustomTextOverflow extends StatelessWidget {
  final String text;
  final int characterLimit;
  final TextStyle? style;

  const CustomTextOverflow({
    super.key,
    required this.text,
    this.characterLimit = 4,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    String displayText = text;
    if (text.length > characterLimit) {
      displayText = '${text.substring(0, characterLimit)}...';
    }
    return Text(
      displayText,
      style: style,
    );
  }
}