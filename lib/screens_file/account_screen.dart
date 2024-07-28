import 'package:flutter/material.dart';
import 'package:shop_app/bloc_file/cubit_page.dart';
import 'package:shop_app/classes/cache_memory/cache_memory_file.dart';
import 'package:shop_app/screens_file/email_update_screen.dart';
import 'package:shop_app/screens_file/login_screen.dart';
import 'package:shop_app/screens_file/name_update_screen.dart';
import 'package:shop_app/screens_file/phone_update_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              const SizedBox(height: 40,),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage( cubit.userInfo?.data?.image ?? 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                  ),
                  const SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text('${ cubit.userInfo?.data?.name}',style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                          ),),

                    ],
                  ),
                  const Spacer(),
                  IconButton(iconSize: 25.0, onPressed:(){
                    // code to edit name
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NameUpdateScreen()));
                  }, icon: const Icon(Icons.edit,color: Colors.black,)),
                  const SizedBox(width: 10,),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.deepPurple,
                    child: IconButton(iconSize: 30,
                        onPressed:(){
                      // code to edit image
                    }, icon: const Icon(Icons.add_a_photo_outlined  ,color: Colors.white,)),
                  ),
                ],
              ),
              const SizedBox(height: 40,),
              const Divider(
                thickness: 2,
                color: Colors.deepPurple,

              ),
              const SizedBox(height: 5,),
              const Text('Info',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                  ),),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text('Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),),
                  const SizedBox(width: 15,),
                  Text('${ cubit.userInfo?.data?.email}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,
                      ),),
                  const Spacer(),
                  IconButton(onPressed:(){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EmailUpdateScreen()));
                  }, icon: const Icon(Icons.edit,color: Colors.black,)),

                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const Text('Phone:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),),
                  const SizedBox(width: 15,),
                  Text('${ cubit.userInfo?.data?.phone}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,
                      ),),
                  const Spacer(),
                  IconButton(onPressed:(){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PhoneUpdateScreen()));
                  }, icon: const Icon(Icons.edit,color: Colors.black,)),

                ],
              ),
              const Divider(
                thickness: 2,
                color: Colors.deepPurple,

              ),
              const SizedBox(height: 20,),
              // need some creative style to change password
              TextButton(
                  onPressed:(){
                    // code to change password
                  }, child: const Text('Change Password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
              ),)),
              const SizedBox(height: 15,),
              TextButton(
                  onPressed:(){
                    CacheMemory.removeData(key: 'token').then((value) {
                      if(value){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }
                    });

                  }, child: const Text('Sign out',style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.deepPurple,
              ),)),

            ],
          ),
        ),
      ),
    )
    ;
  }
}
