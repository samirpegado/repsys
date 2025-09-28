import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repsys/app_state/app_state.dart';
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
    final appState = context.watch<AppState>();
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
                  child: feature(appState.menuIndex),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget feature(index) {
  switch (index) {
    case 0:
      return Center(child: Text('Dashboard'));
    case 1:
      return Catalogo();
    case 2:
      return Center(child: Text('Clientes'));
    case 3:
      return Center(child: Text('Serviços'));
    case 4:
      return Center(child: Text('Vendas'));
    case 5:
      return Center(child: Text('Receitas'));
    case 6:
      return Center(child: Text('Despesas'));
    case 7:
      return Center(child: Text('Relatórios'));
    default:
      return Center(child: Text('Dashboard'));
  }
}
