import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/login_bloc/cubit.dart';
import 'package:shopping/bloc/login_bloc/states.dart';
import 'package:shopping/modules/register_screen.dart';
import 'package:shopping/modules/shop_layout/shop_layout.dart';
import 'package:shopping/network/local/cashe_helper.dart';
import 'package:shopping/shared/components.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey =GlobalKey<FormState>();
  bool hiddenPassword = true;
  TextEditingController emailControl=TextEditingController();
  TextEditingController passwordControl=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state){
          if(state is LoginSuccessState){
            if(state.loginModel.status){
              showToast(
                  msg:state.loginModel.message!,
                  state: ToastStates.success);
              CacheHelper.saveData(key: "token", value: state.loginModel.data!.token).then((value){
                navigateAndFinish(context, const ShopLayout());
              });
            }
            else{
              showToast(
                  msg:state.loginModel.message!,
                  state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar:null,
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("LOGIN",
                                style:Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontFamily: "PermanentMarker",
                                  color: Colors.blue
                                )
                            ),
                            const SizedBox(height: 5,),
                            Text("login now to browse our hot offers",
                              style:Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey
                              ),
                            ),
                            const SizedBox(height: 30,),
                            customField(
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (value) {
                                if(formKey.currentState!.validate()){
                                  LoginCubit.get(context).userLogin(
                                      email: emailControl.text,
                                      password: passwordControl.text
                                  );
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                });
                              },
                              prefixIcon: Icons.email_outlined,
                              labelText: "Email",
                              controller: emailControl,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Please,enter your email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16,),
                            customField(
                              keyboardType: TextInputType.visiblePassword,
                              onFieldSubmitted: (value) {
                                if(formKey.currentState!.validate()){
                                  LoginCubit.get(context).userLogin(
                                      email: emailControl.text,
                                      password: passwordControl.text
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
                              controller: passwordControl,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Please,enter your password";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16,),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder:(context) =>customButton(
                                  color: passwordControl.text.isEmpty||emailControl.text.isEmpty?
                                  Colors.blue.withOpacity(0.4):Colors.blue,
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      LoginCubit.get(context).userLogin(
                                          email: emailControl.text,
                                          password: passwordControl.text
                                      );
                                    }
                                  },
                                  btnName: "Login"),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                customTextButton(context,
                                    onPressed: () {
                                      navigate(context, const Register());
                                    },
                                    txtbtnName: "Register."
                                )
                              ],
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              )
          );
        }
      ),
    );
  }
}


