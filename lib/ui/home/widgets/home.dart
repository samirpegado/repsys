import 'package:flutter/material.dart';
import 'package:repsys/ui/home/view_models/home_viewmodel.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.viewModel});
  final HomeViewmodel viewModel;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
