import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/bloc_file/cubit_page.dart';
import 'package:shop_app/bloc_file/state_page.dart';
import 'package:shop_app/classes/cache_memory/cache_memory_file.dart';
import 'package:shop_app/constant_variables_file.dart';
import 'package:shop_app/screens_file/home_screen.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      return Scaffold(
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
                      'Register Now',style: TextStyle(color:Colors.deepPurple,fontFamily:"Playwrite",fontSize: 35.0,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 60,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter your name';
                        }
                        return null;
                      },
        
                      controller: nameController,
                      decoration: InputDecoration(
        
        
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person,color: Colors.deepPurple,),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(color: Colors.deepPurple,width: 20.0)),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value){
                        if(value!.isEmpty||value.length<11){
                          return 'Please enter your phone';
                        }
                          return null;
                      },
        
                      controller:phoneController,
                      decoration: InputDecoration(
        
        
                        labelText: 'phone',
                        prefixIcon: const Icon(Icons.phone_android,color: Colors.deepPurple,),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(color: Colors.deepPurple,width: 20.0)),
                      ),
                    ),
                    const SizedBox(height: 50,),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child:  MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            AppCubit.get(context).registerUser(name: nameController.text, email: emailController.text, password: passwordController.text, phone: phoneController.text);

                          }
                        },
                        child: const Text('REGISTER',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      ),
                    ),
        
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context,state){
      if(state is RegisterSuccessState){
        if(AppCubit.get(context).registerUserInfo!.status==true) {
          Fluttertoast.showToast(
              msg: AppCubit.get(context).registerUserInfo!.message??'',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 20,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
             CacheMemory.saveData(key: 'token', value: AppCubit.get(context).registerUserInfo!.data!.token).then((value) {
            token = AppCubit.get(context).registerUserInfo!.data!.token;
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              });
      }}
      else{
        Fluttertoast.showToast(
            msg: AppCubit.get(context).registerUserInfo!.message??'',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    });
  }
}
