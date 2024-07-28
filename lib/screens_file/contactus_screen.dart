import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ContactusScreen extends StatelessWidget {
  const ContactusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.deepPurple,),),
      )  ,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            const Text('you can get in touch with us through below platforms . Our team will reach out to you soon .',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey,),),
            const SizedBox(height: 40,),
            const Text('Customer Support',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,),),
            const SizedBox(height: 30,),
            const Row(
              children: [
                Icon(Icons.email,color: Colors.deepPurple,size: 30,),
                SizedBox(width: 20,),
                Expanded(child: Text('Email: CompanyEmail@example.com ',maxLines: 2,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey,),))
           ],
      ),
            const SizedBox(height: 20,),
            const Row(
              children: [
                Icon(Icons.phone,color: Colors.deepPurple,size: 30,),
                SizedBox(width: 20,),
                Expanded(child: Text('Phone: +91 1234567890',maxLines: 2,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey,),))
              ],
            ),
            const SizedBox(height: 60,),
            const Text('Social Media',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,),),
            const SizedBox(height: 30,),
            Row(
              children: [
                const Icon(Icons.facebook,color: Colors.deepPurple,size: 30,),
                const SizedBox(width: 20,),
                 Expanded(child:InkWell(
                    onTap: (){},
                    child: const Text('Facebook: CompanyName',maxLines: 2,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey,),)
                 ))
              ],
            ),
            const SizedBox(height: 20,),
            const Row(
              children: [
                Icon(FontAwesomeIcons.instagram,color: Colors.deepPurple,size: 30,),
                SizedBox(width: 20,),
                Expanded(child: Text('Instagram: CompanyName',maxLines: 2,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey,),))
              ],
            ),
            const SizedBox(height: 20,),
            const Row(
              children: [
                Icon(FontAwesomeIcons.twitter,color: Colors.deepPurple,size: 30,),
                SizedBox(width: 20,),
                Expanded(child: Text('Twitter: CompanyName',maxLines: 2,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey,),))
              ],
            ),

    ],
    )
    ));
  }
}
