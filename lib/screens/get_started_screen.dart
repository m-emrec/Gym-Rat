import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_rat_v2/provider/user_provider.dart';
import 'package:provider/provider.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  static const routeName = "get-started-page";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onDoubleTap: Provider.of<UserProvider>(context, listen: false).logOut,
        child: Text("Get Started"),
      ),
    );
  }
}
