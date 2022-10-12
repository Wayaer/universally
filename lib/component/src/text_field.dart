import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField({Key? key}) : super(key: key);

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 10,
      maxLines: 10,
      minLines: 5,
      // cursorHeight: 10,
      cursorWidth: 4,
      cursorRadius: Radius.circular(4),
      toolbarOptions:
          ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
      decoration: InputDecoration(
          hintText: 'hintText',
          labelText: 'labelText',
          // label: Universal(
          //     // color: Colors.blue,
          //     direction: Axis.horizontal,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       TextDefault('label'),
          //     ]),
          // contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixIcon: Universal(
              color: Colors.blue,
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextDefault('搜索'),
              ]),
          prefixIcon: Universal(
              color: Colors.blue,
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: [
                searchWidget,
              ]),
          prefix: Container(
            color: Colors.red,
            width: 10,
            height: 10,
            child: TextDefault('prefix'),
          )),
    );
  }

  Widget get searchWidget => Icon(UIS.search, size: 20, color: Colors.red);
}
