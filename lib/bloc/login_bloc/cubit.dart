import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/login_bloc/states.dart';
import 'package:shopping/models/login_model.dart';
import 'package:shopping/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context){
    return BlocProvider.of(context);
  }
  late LoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
})async{
    emit(LoginLoadingState());
    try{
      Response response=await DioHelper.postData(url: "login", data: {
      "email": email,
      "password": password
      });
      loginModel=LoginModel.fromJson(response.data);
      emit(LoginSuccessState(loginModel));
    }
    catch(e){
      emit(LoginErrorState());
    }
  }
}