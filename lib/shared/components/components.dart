

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../cubit/cubit.dart';

Widget defultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required String text,
  required VoidCallback function,

}) =>
    Container(
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.blue,),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
    );

TextFormField defualtTextfiled({
  required TextEditingController controller,
   TextInputType? type,
   void Function(String)? onSubmit,
   String? label,
   IconData? prefix,
   String? Function(String?)? validate,
   void Function(String)? onChange,
  bool isPassword = false,
   IconData? suffix,
   void Function()? suffixPress,
   void Function()? onTap,
}) =>
    TextFormField(
      onTap: onTap,
        controller: controller,
        keyboardType: type,
        validator: validate,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(prefix),
          suffixIcon: suffix!=null?IconButton(
              onPressed: suffixPress,
              icon: Icon(suffix)):null,
        ));
Widget defualtStack({
  required String text,
   required String Text1,
})=>Stack(
  children: [
    Image(image: AssetImage('images/Vector.png'),color:Colors.blue[800] ,),
    Container(width:double.infinity,
      padding: EdgeInsetsDirectional.only(start: 90,top: 50,bottom: 20),

      child:
      Text(
        text,style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800]),),


    ),
    SizedBox(height: 20,),
    Container(width:double.infinity,
      padding: EdgeInsetsDirectional.only(start: 110,top: 130,bottom: 10),

      child:
      Text(
        Text1,style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800]),),


    ),


  ],
);

Widget ItemsNewTaskScreen(Map model,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40,
        child: Text(
            '${model['time']}'
        ),
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model['title']}',style:TextStyle(fontSize: 30),),
            Text(
              '${model['date']}',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey),),
          ],),
      ),
      SizedBox(width: 20,),
      IconButton(
          onPressed: (){
            AppCubit.get(context).UpdateDatabase(status:'done',id:model['id']);
          },
          icon: Icon(Icons.check_box),color:Colors.red,),
      IconButton(
        onPressed: (){
          AppCubit.get(context).UpdateDatabase(status: 'alert', id: model['id']);
        },
        icon: Icon(Icons.archive),color:Colors.green),

    ],
  ),
);

//  Widget buildArticleItem(article,context)=> InkWell(
//    onTap: (){
//      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(article['url'])));
//    },
//    child: Padding(
//
//     padding: const EdgeInsets.all(16.0),
//
//     child: Row(
//
//       children: [
//
//         Container(
//
//           width: 120.0,
//
//           height: 120.0,
//
//           decoration: BoxDecoration(
//
//               borderRadius:BorderRadius.circular(10),
//
//
//
//               image: DecorationImage(image: NetworkImage('${article['urlToImage']}'),
//
//                   fit: BoxFit.cover)
//
//           ),
//
//         ),
//
//         SizedBox(width: 20,),
//
//         Expanded(
//
//           child: Container(height: 120,
//
//             child: Column(mainAxisAlignment: MainAxisAlignment.start,
//
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//
//
//               children: [
//
//                 Expanded(
//
//                   child: Text('${article['title']}',
//
//                     style: Theme.of(context).textTheme.bodyText1,
//
//                     maxLines: 3,
//
//                     overflow: TextOverflow.ellipsis,),
//
//                 ),
//
//                 Text("${article['publishedAt']}",
//
//                   style: TextStyle(
//
//                       color: Colors.grey
//
//                   ),)
//
//
//
//               ],
//
//             ),
//
//           ),
//
//         )
//
//       ],
//
//     ),
//
// ),
//  );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);