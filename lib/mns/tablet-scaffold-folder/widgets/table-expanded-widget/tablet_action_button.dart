import 'package:flutter/material.dart';

class TabletActionButton extends StatelessWidget {
  TabletActionButton({
    Key? key,
    this.onPressed,
    required this.child,
    required this.heroTag,

  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              minimumSize: Size(140, 80)
          ),
          child: Container(
            width: MediaQuery.of(context).size.width*0.35,
            child: child,
          ),
          onPressed: onPressed

      ),
    );
  }
}
