import 'package:flutter/material.dart';

class SelectedBox extends StatefulWidget {
  const SelectedBox({
    super.key,
    required this.activeColor,
    required this.active,
  });

  final Color activeColor;
  final bool active;

  @override
  State<SelectedBox> createState() => _SelectedBoxState();
}

class _SelectedBoxState extends State<SelectedBox> {
  @override
  Widget build(BuildContext context) {
    const double side = 20;

    final icon = Icon(Icons.done, size: 16);


    return Container(
      width: side,
      height: side,
      decoration: BoxDecoration(
          color: widget.active ? widget.activeColor : Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: widget.active ? Colors.transparent : Colors.black,
            width: 2,
          )),
      child: widget.active ? Center(child: icon) : null,
    );
  }
}
