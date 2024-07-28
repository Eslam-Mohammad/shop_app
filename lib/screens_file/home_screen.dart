
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_file/cubit_page.dart';
import 'package:shop_app/bloc_file/state_page.dart';
import 'package:shop_app/classes/cache_memory/cache_memory_file.dart';
import 'package:shop_app/screens_file/about_us_screen.dart';
import 'package:shop_app/screens_file/account_screen.dart';
import 'package:shop_app/screens_file/contactus_screen.dart';
import 'package:shop_app/screens_file/login_screen.dart';
import 'package:shop_app/screens_file/search_screen.dart';



class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


 

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<AppCubit,AppStates>(builder:(context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          drawer:  Drawer(
            child:Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white,Colors.purple],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
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
                            Text('Hi,${ cubit.userInfo?.data?.name}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                                fontFamily: 'Playwrite'),),
                            ],
                    ),],),
                    const SizedBox(height: 40,),
                    const Divider(
                      thickness: 2,
                      color: Colors.deepPurple,

                    ),
                    const SizedBox(height: 5,),
                    ListTile(
                      onTap: (){
                        cubit.changeIndex(0);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.home),
                      title: const Text('Home',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                          ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AccountScreen()));
                      },
                      leading: const Icon(Icons.key),
                      title: const Text('Account',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                     ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ContactusScreen()));
                      },
                      leading: const Icon(Icons.send_to_mobile),
                      title: const Text('Contact us',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                     ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AboutUsScreen()));
                      },
                      leading: const Icon(Icons.help),
                      title: const Text('About us',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Signout',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),
                      ),
                      onTap: (){
                        CacheMemory.removeData(key: 'token').then((value) {
                          if(value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),

              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Marché',
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                  fontFamily: 'Playwrite'),),
            actions: [
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
              }, icon: const Icon(Icons.search),iconSize: 30.0,),

            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 16.0,
            selectedIconTheme: const IconThemeData(color: Colors.white, size: 30),
            currentIndex: cubit.currentIndex,
            onTap: (index){
              if(index==4){
                scaffoldKey.currentState!.openDrawer();
                cubit.changeIndex(index);
              }else{
                cubit.changeIndex(index);
              }

            },
             items: const [
              BottomNavigationBarItem(backgroundColor: Colors.purple,
                  icon:Icon(Icons.home,),label: 'Home'),
              BottomNavigationBarItem(backgroundColor:  Colors.purple,icon: Icon(Icons.category),label: 'Categories'),
              BottomNavigationBarItem(backgroundColor: Colors.purple,icon: Icon(Icons.favorite),label: 'Favorites'),
              BottomNavigationBarItem(backgroundColor: Colors.purple,icon: Icon(Icons.shopping_cart),label: 'Cart'),
              BottomNavigationBarItem(backgroundColor: Colors.purple,icon: Icon(Icons.person),label: 'Profile'),

            ],
          ),
          body:cubit.currentIndex==4? cubit.bottomScreens[(cubit.currentIndex)-4]:cubit.bottomScreens[cubit.currentIndex],

        );
      }, listener:(context,state){},);
  }
}
