import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/register_bloc/cubit.dart';
import 'package:shopping/bloc/register_bloc/states.dart';
import 'package:shopping/consts/consts.dart';
import 'package:shopping/modules/shop_layout/shop_layout.dart';
import 'package:shopping/network/local/cashe_helper.dart';
import 'package:shopping/shared/components.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  bool hiddenPassword =true;
  bool hiddenConfirmPassword=true;
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            if(state.registerModel.status){
              showToast(
                  msg:state.registerModel.message,
                  state: ToastStates.success);
              CacheHelper.saveData(key: "token", value: state.registerModel.data!.token).then((value){
                token=state.registerModel.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
            }
            else{
              showToast(
                  msg:state.registerModel.message,
                  state: ToastStates.error);
            }
          }
        },
        builder: (context, state) => Scaffold(
            appBar:AppBar(leading: const BackButton(color: Colors.black),),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Register".toUpperCase(),
                              style:Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontFamily: "PermanentMarker",
                                  color: Colors.blue
                              )
                          ),
                          const SizedBox(height: 5,),
                          Text("register now to browse our hot offers",
                            style:Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey
                            ),
                          ),
                          const SizedBox(height: 30,),
                          customField(
                            keyboardType: TextInputType.name,
                            onFieldSubmitted: (value) {
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userLogin(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                              });
                            },
                            labelText: "Name",
                            prefixIcon: Icons.account_circle_outlined,
                            controller: nameController,
                            validator: (value){
                              if(value!.isEmpty){
                                return"please enter your name";
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16,),
                          customField(
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userLogin(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                              });
                            },
                            prefixIcon: Icons.email_outlined,
                            labelText: "Email",
                            controller: emailController,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "please enter your email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16,),
                          customField(
                              keyboardType: TextInputType.phone,
                              onFieldSubmitted:(value) {
                                if(formKey.currentState!.validate()){
                                  RegisterCubit.get(context).userLogin(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              onChanged:(value) {
                                setState(() {
                                });
                              },
                              labelText: "Phone Number",
                              prefixIcon: Icons.phone,
                              controller: phoneController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return"please enter your phone number";
                                }
                                else{
                                  return null;
                                }
                              }
                          ),
                          const SizedBox(height: 16,),
                          customField(
                            keyboardType: TextInputType.visiblePassword,
                            onFieldSubmitted: (value) {
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userLogin(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            obscureText: hiddenPassword,
                            suffixIcon:hiddenPassword?Icons.visibility_off_outlined:Icons.visibility_outlined,
                            onPressed: () {
                              setState(() {
                                hiddenPassword=!hiddenPassword;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                              });
                            },
                            prefixIcon: Icons.lock_outline,
                            labelText: "Password",
                            controller: passwordController,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "please enter your password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16,),
                          customField(
                            keyboardType: TextInputType.visiblePassword,
                            onFieldSubmitted: (value) {
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userLogin(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            obscureText: hiddenConfirmPassword,
                            suffixIcon:hiddenConfirmPassword? Icons.visibility_off_outlined:
                            Icons.visibility_outlined,
                            onPressed: (){
                              setState(() {
                                hiddenConfirmPassword=!hiddenConfirmPassword;
                              });
                            },
                            onChanged: (value){
                            setState(() {

                            });
                          },
                            prefixIcon: Icons.lock_outline,
                            labelText: "Confirm password",

                            controller: confirmPasswordController,
                            validator: (value){
                              if(value!.isEmpty){
                                return"please confirm your password";
                              }
                              else if(passwordController.text!=confirmPasswordController.text){
                                return "Password isn't identical";
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16,),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder:(context) =>customButton(
                                color: passwordController.text.isEmpty||emailController.text.isEmpty||phoneController.text.isEmpty||nameController.text.isEmpty||confirmPasswordController.text.isEmpty?
                                Colors.blue.withOpacity(0.4):Colors.blue,
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    RegisterCubit.get(context).userLogin(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                btnName: "Register"),
                            fallback: (context) => const Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Have an account?",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              customTextButton(context,
                                  onPressed: () {
                                Navigator.pop(context);
                                  },
                                  txtbtnName: "Login."
                              )
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
}
