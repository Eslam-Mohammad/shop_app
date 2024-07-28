import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_file/cubit_page.dart';
import 'package:shop_app/bloc_file/state_page.dart';
import 'package:shop_app/screens_file/account_screen.dart';

class EmailUpdateScreen extends StatelessWidget {
  EmailUpdateScreen({super.key});
var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(builder:(context,state){
      return  Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AccountScreen()));
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is UpdateUserLoadingState)
                  const LinearProgressIndicator(color: Colors.deepPurple,),
                const SizedBox(height: 40,),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty||value.contains('@')==false||value.contains('.com')==false){
                      return 'Please enter your Email';
                    }
                    return null;
                  },

                  controller: emailController,
                  decoration: InputDecoration(


                    labelText:'Email',
                    prefixIcon: const Icon(Icons.person,color: Colors.deepPurple,),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(color: Colors.deepPurple,width: 20.0)),
                  ),
                ),
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
                        AppCubit.get(context).updateUser(name:AppCubit.get(context).userInfo!.data!.name!, email: emailController.text,
                            phone: AppCubit.get(context).userInfo!.data!.phone!);
                      }
                    },
                    child: const Text('Update Email',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }, listener: (context,state){});
  }
}
