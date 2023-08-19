import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/shop_bloc/cubit.dart';
import 'package:shopping/bloc/shop_bloc/states.dart';
import 'package:shopping/modules/login_screen.dart';
import 'package:shopping/network/local/cashe_helper.dart';
import 'package:shopping/shared/components.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController=TextEditingController();
    TextEditingController phoneController=TextEditingController();
    TextEditingController emailController=TextEditingController();
    var formKey=GlobalKey<FormState>();
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {
          if(state is UpdateProfileSuccessState){
            if(state.loginModel.status){
              showToast(
                  msg:state.loginModel.message!,
                  state: ToastStates.success);
              }
            else{
              showToast(
                  msg:state.loginModel.message!,
                  state: ToastStates.error);
            }
          }
          if(state is LogoutSuccessState){
            if(state.logoutModel.status){
              showToast(
                  msg:state.logoutModel.message,
                  state: ToastStates.success);
              CacheHelper.removeData(key: "token").then((value){
                navigateAndFinish(context, const Login());
              });
            }
            else{
              showToast(
                  msg:state.logoutModel.message,
                  state: ToastStates.error);
            }
          }
        },
      builder: (context, state) {
        var model=ShopCubit.get(context).loginModel!.data;
        nameController.text=model!.name!;
        phoneController.text=model.phone!;
        emailController.text=model.email!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel!=null,
          builder:(context) => Scaffold(
            appBar: AppBar(
              title:const Text("Salla",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "PermanentMarker",
                    color: Colors.black
                ),
              ),
            ),
            body:Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(State is UpdateProfileLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 20,),
                      customField(
                        keyboardType: TextInputType.name,
                        labelText: "Name",
                        prefixIcon: Icons.account_circle_outlined,
                        controller: nameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return"name must not be empty";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16,),
                      customField(
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        labelText: "Email",
                        controller: emailController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "email must be not empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16,),
                      customField(
                          keyboardType: TextInputType.phone,
                          labelText: "Phone Number",
                          prefixIcon: Icons.phone,
                          controller: phoneController,
                          validator: (value){
                            if(value!.isEmpty){
                              return"phone number must be not empty";
                            }
                            else{
                              return null;
                            }
                          }
                      ),
                      const SizedBox(height: 16,),
                      customButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateProfileData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text
                          );
                          }
                        },
                        btnName: "update".toUpperCase(),
                        color: Colors.blue
                  ),
                      const SizedBox(height: 16,),
                      customButton(
                          onPressed: () {
                            ShopCubit.get(context).logout();
                          },
                          btnName: "logout".toUpperCase(),
                          color: Colors.blue
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback:(context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
