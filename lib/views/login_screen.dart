import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Presenter/bloc_file/cubit_page.dart';
import 'package:shop_app/views/register_screen.dart';


import '../Core/cache_memory/cache_memory_file.dart';
import '../Core/constant_variables_file.dart';
import '../Presenter/bloc_file/state_page.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
 final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <AppCubit,AppStates>(builder: (context,state){
      return  Scaffold(

        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 50.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    const Text(
                      'Shopping Now',style: TextStyle(color:Colors.deepPurple,fontFamily:"Playwrite",fontSize: 35.0,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 20,),
                    Image.asset('images/shopping-cart.png',height: 300,width: 300,),
                    const SizedBox(height: 20,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty||value.contains('@')==false||value.contains('.com')==false){
                          return 'Please enter your email';
                        }
                        return null;
                      },

                      controller: emailController,
                      decoration: InputDecoration(


                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email,color: Colors.deepPurple,),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(color: Colors.deepPurple,width: 20.0)),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty||value.length<8){
                          return 'Please enter your password';
                        }
                        return null;
                      },

                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock,color: Colors.deepPurple,),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(color: Colors.deepPurple,width: 20.0)),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextButton(onPressed: (){}, child: const Text('Forget Password?',style: TextStyle(color: Colors.deepPurple,fontSize: 18.0),)),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child:  MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            AppCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                          }
                        },
                        child: const Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: Row(

                        children: [
                          const Text('Don\'t have an account?',style: TextStyle(fontSize: 16.0),),
                          TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BlocListener<AppCubit, AppStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  child: RegisterScreen(),
)));
                          }, child: const Text('REGISTER NOW',style: TextStyle(fontSize: 16.0,color: Colors.deepPurple),)),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
     if(state is LoginSuccessState){
       if(state.loginInfo.status == true){

         Fluttertoast.showToast(
             msg: state.loginInfo.message??'',
             toastLength: Toast.LENGTH_LONG,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 20,
             backgroundColor: Colors.green,
             textColor: Colors.white,
             fontSize: 16.0
         );
         CacheMemory.saveData(key: 'token', value: state.loginInfo.data!.token).then((value) {
           token = state.loginInfo.data!.token;
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));

         });
       }
       else{
         Fluttertoast.showToast(
             msg: state.loginInfo.message??'',
             toastLength: Toast.LENGTH_LONG,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 20,
             backgroundColor: Colors.red,
             textColor: Colors.white,
             fontSize: 16.0
         );
       }
     }
    },);
  }
}
