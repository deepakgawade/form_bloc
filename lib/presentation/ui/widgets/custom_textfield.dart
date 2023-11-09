
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,  this.labelText, this.hintText, required this.icon,this.isObscure=false, this.suffixIcon
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? icon;
  final bool isObscure;
  final Widget? suffixIcon;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30,vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText==null?const SizedBox(): Text(labelText!,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),),
          TextFormField(controller: controller,decoration:  InputDecoration(hintText: hintText??"",contentPadding: EdgeInsets.only(left: 10),alignLabelWithHint: true,border:const OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide(color: Colors.black,)),hintStyle:const TextStyle(fontStyle: FontStyle.italic),prefixIcon: icon,suffixIcon:suffixIcon ),obscureText: isObscure,),
        ],
      ),
    );
  }
}