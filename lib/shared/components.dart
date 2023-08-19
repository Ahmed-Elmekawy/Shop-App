import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping/consts/consts.dart';
import 'package:shopping/models/poduct_data/product_data.dart';

Widget customField({
  TextInputType? keyboardType,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  bool obscureText = false,
  void Function()? onPressed,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required String labelText,
  required TextEditingController controller,
  required String? Function(String?) validator,
}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: TextFormField(
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      onChanged:onChanged,
      obscureText: obscureText ,
      decoration: InputDecoration(
        border:  const OutlineInputBorder(),
        prefixIcon:Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed:onPressed,
          icon:Icon(suffixIcon),
        ),
        labelText:labelText,
      ),
      controller: controller,
      validator:validator,
    ),
  );
}

Widget customButton({
  Color color = Colors.blue,
  required void Function() onPressed,
  required String btnName,
}
    ){
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: color
    ),
    child: MaterialButton(
      onPressed:onPressed,
      child: Text(btnName,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}

Widget customTextButton(context,{
  required void Function() onPressed,
  required String txtbtnName,
}
    ){
  return TextButton(
    onPressed:onPressed,
    child:Text(txtbtnName,
      style:Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      )
    ),
  );
}

void showToast({
  required String msg,
  required ToastStates state,
}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastStates{success,error,warning}

Color toastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.success:
      color=Colors.green;
      break;
    case ToastStates.error:
      color=Colors.red;
      break;
    case ToastStates.warning:
      color=Colors.amber;
      break;
}
return color;
}

void navigate(context,Widget widget){
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => widget,
  )
  );
}

void navigateAndFinish(context,Widget widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) => widget,
  ),
    (route) => false,
  );
}

Widget builderProduct(cubit,{required ProductData productData,bool isFavourite=true}){
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Image(image: NetworkImage(
                productData.image
            ),
              height: 100,
              width: 100,
            ),
            if(productData.discount!=0&&isFavourite)
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text("discount".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white
                    ),
                  )
              )
          ],
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              child: Text(
               productData.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.5,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${productData.price.round()}",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    fontFamily: "PermanentMarker"
                  ),
                ),
                const SizedBox(width: 5,),
                const Text("L.E",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    fontFamily: "PermanentMarker"

                  ),
                ),
                const SizedBox(width: 15,),
                if(productData.discount!=0&&isFavourite)
                  Text("${productData.oldPrice.round()}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontFamily: "PermanentMarker",
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              cubit.addOrRemoveFavouritesData(productId:productData.id);
            },
            icon:favorites[productData.id]==true?const Icon(
              Icons.favorite_outlined,
              color: Colors.red,
            ):const Icon(Icons.favorite_border_outlined)
        ),
      ],
    ),
  );
}