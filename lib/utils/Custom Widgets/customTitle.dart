import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';

/*  **Definition**

  * This widget used for main titles of the pages.
  * It takes title and subtitle(if exists) as parameters


*/

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.withDivider = true,
  });

  final String title;
  final String? subtitle;
  final bool withDivider;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    var divider = const Divider(
      thickness: 3,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10,
      ),
      child: SizedBox(
        width: _screenWidth * 0.5,
        child: subtitle == null
            ?
            // if subtitle equals null
            Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Visibility(
                    visible: withDivider,
                    child: divider,
                  )
                ],
              )
            // if there is subtitle
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello $title",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    subtitle!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 20, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.start,
                  ),
                  // if withDivider is true show put divider else don't put divider.
                  Visibility(
                    visible: withDivider,
                    child: divider,
                  )
                ],
              ),
      ),
    );
  }
}
