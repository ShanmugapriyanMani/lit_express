import 'package:flutter/material.dart';

class TListViewBuilderLayout extends StatelessWidget {
  const TListViewBuilderLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
  });

  final int itemCount;
  final Widget? Function(BuildContext context, int) itemBuilder;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller,
      padding: EdgeInsets.zero,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }
}

