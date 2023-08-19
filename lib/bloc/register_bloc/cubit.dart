import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/register_bloc/states.dart';
import 'package:shopping/models/register_model.dart';
import 'package:shopping/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(context){
    return BlocProvider.of(context);
  }
  late RegisterModel registerModel;
  void userLogin({
    required String name,
    required String email,
    required String password,
    required String phone,
  })async{
    emit(RegisterLoadingState());
    try{
      Response response=await DioHelper.postData(url: "register", data: {
        "name":name,
        "email": email,
        "password": password,
        "phone":phone,
      });
      registerModel=RegisterModel.fromJson(response.data);
      emit(RegisterSuccessState(registerModel));
    }
    catch(e){
      emit(RegisterErrorState());
    }
  }
}