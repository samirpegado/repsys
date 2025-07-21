import 'package:flutter/material.dart';
import 'package:repsys/ui/catalogo/widgets/catalogo.dart';
import 'package:repsys/ui/components/sidebar.dart';
import 'package:repsys/ui/components/topbar.dart';
import 'package:repsys/ui/main/view_models/main_layout_viewmodel.dart';
import 'package:repsys/utils/constants.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.viewModel});
  final MainLayoutViewmodel viewModel;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= desktopWidth;

    return Scaffold(
      drawer: isDesktop ? null : const Drawer(child: Sidebar()),
      body: Row(
        children: [
          if (isDesktop) const Sidebar(),
          Expanded(
            child: Column(
              children: [
                const Topbar(),
                Expanded(
                  child: Catalogo(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
