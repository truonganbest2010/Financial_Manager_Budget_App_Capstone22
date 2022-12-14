// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class ListViewHeaderText extends StatelessWidget {
  final String listViewTitle;

  ListViewHeaderText({required this.listViewTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        listViewTitle,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
