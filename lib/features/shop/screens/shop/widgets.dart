import 'package:flutter/material.dart';
class FeaturedBrandHeading extends StatelessWidget {
  final String text;
  final VoidCallback ontab;
  final double fontsize;
  const FeaturedBrandHeading({
    super.key, required this.ontab, required this.text, required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontsize)),
      TextButton(onPressed: ontab,child:const Text("View all",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
      )],);
  }
}