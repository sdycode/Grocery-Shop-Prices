// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:groceryshopprices/lib.dart';

class CloseCrossButton extends StatelessWidget {
  final bool enforceExit;
  const CloseCrossButton({
    super.key,
    this.enforceExit = true,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          exitOrAttemptExit(context, enforceExit: enforceExit);
        },
        icon: Icon(
          Icons.close,
          color: Colors.red,
        ));
  }
}
