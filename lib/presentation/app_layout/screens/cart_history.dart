import 'package:flutter/material.dart';

import '../../widgets/primary_text.dart';
class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: PrimaryText(text: 'Cart history screen',),);
  }
}
