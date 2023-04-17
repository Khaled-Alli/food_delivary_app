import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:flutter/material.dart';

import '../../utiles/colors.dart';
import '../../utiles/constants.dart';

class BuildProfilItem extends StatelessWidget {
  IconData icon;
  String text;
  Color backgroungColor;

   BuildProfilItem({Key? key,required this.text,required this.icon,required this.backgroungColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .5,
      child: Container(color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: Dimensions.p10),
        child: Row(children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.p15),
            child: Center(child:
            CircleAvatar(
              backgroundColor:backgroungColor,
              radius: Dimensions.p20,
              child: Icon(icon,color: Colors.white,size: Dimensions.p20,),
            ),
            ),
          ),
          PrimaryText(text: text,),
        ],),),
    );
  }
}
