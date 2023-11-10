import 'package:flutter/material.dart';

class SelectedBox extends StatefulWidget {
  const SelectedBox({
    super.key,
    required this.activeColor,
    required this.selected,
  });

  final Color activeColor;
  final bool selected;

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
          color: widget.selected ? widget.activeColor : Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: widget.selected ? Colors.transparent : Colors.black,
            width: 2,
          )),
      child: widget.selected ? Center(child: icon) : null,
    );
  }
}
