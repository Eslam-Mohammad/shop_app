
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/generated/l10n.dart';
import 'package:shop_app/views/search_screen.dart';

import '../Core/cache_memory/cache_memory_file.dart';
import '../Presenter/bloc_file/cubit_page.dart';
import '../Presenter/bloc_file/state_page.dart';
import 'about_us_screen.dart';
import 'account_screen.dart';
import 'contactus_screen.dart';
import 'login_screen.dart';




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
                            Text('${S.current.hi},${ cubit.userInfo?.data?.name}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
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
                      title:  Text(S.current.home,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                          ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AccountScreen()));
                      },
                      leading: const Icon(Icons.key),
                      title:  Text(S.current.account,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                     ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ContactusScreen()));
                      },
                      leading: const Icon(Icons.send_to_mobile),
                      title:  Text(S.current.contact,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                     ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AboutUsScreen()));
                      },
                      leading: const Icon(Icons.help),
                      title:  Text(S.current.about,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    SwitchListTile(
                      title:  Text("Dark Mode",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                      ),
                      ),
                        secondary: const Icon(Icons.dark_mode),
                      value: Theme.of(context).brightness== Brightness.dark,
                        onChanged:(newValue){
                          cubit.switchAppMode(newValue);

                        },
                    ),


                    const SizedBox(height: 15,),
                    ExpansionTile(
                      leading:  FaIcon(FontAwesomeIcons.language),
                        title: Text(S.current.applang,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                        ),
                        ),
                      children: [
                        ListTile(
                          onTap: (){
                            cubit.changeLanguage(lang:'en');
                            Navigator.pop(context);
                          },
                          title:  Text("English",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                          ),
                          ),
                        ),
                        ListTile(
                          onTap: (){
                            cubit.changeLanguage(lang:'ar');
                            Navigator.pop(context);
                          },
                          title:  Text("العربيه",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                          ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title:  Text(S.current.signOut,
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
            title:  Text(S.current.title,
               ),
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

                cubit.changeIndex(index);


            },
             items:  [
              BottomNavigationBarItem(backgroundColor: Theme.of(context).colorScheme.primary,
                  icon:Icon(Icons.home,),label: S.current.home),
              BottomNavigationBarItem(backgroundColor: Theme.of(context).colorScheme.primary,icon: Icon(Icons.category),label: S.current.category),
              BottomNavigationBarItem(backgroundColor: Theme.of(context).colorScheme.primary,icon: Icon(Icons.favorite),label: S.current.favorite),
              BottomNavigationBarItem(backgroundColor: Theme.of(context).colorScheme.primary,icon: Icon(Icons.shopping_cart),label:S.current.cart ),

            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex],

        );
      }, listener:(context,state){},);
  }
}
