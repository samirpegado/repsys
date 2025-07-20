import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repsys/app_state/app_state.dart';
import 'package:repsys/ui/core/themes/colors.dart';

class MenuItens extends StatefulWidget {
  const MenuItens({super.key});

  @override
  State<MenuItens> createState() => _MenuItensState();
}

class _MenuItensState extends State<MenuItens> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Column(
      children: [
        buildMenuItem(
          title: 'Dashboard',
          icon: Icons.space_dashboard, // ícone mais específico
          index: 0,
          appState: appState,
          onPressed: () {
            appState.setMenuIndex(0);
            Scaffold.of(context).closeDrawer();
          },
        ),
        const SizedBox(height: 8),
        buildMenuItem(
          title: 'Catálogo',
          icon: Icons.inventory_2, // ícone de catálogo/estoque
          index: 1,
          appState: appState,
          onPressed: () {
            appState.setMenuIndex(1);
            Scaffold.of(context).closeDrawer();
          },
        ),
        const SizedBox(height: 8),
        buildMenuItem(
          title: 'Clientes',
          icon: Icons.people_alt, // ícone de pessoas/clientes
          index: 2,
          appState: appState,
          onPressed: () {
            appState.setMenuIndex(2);
            Scaffold.of(context).closeDrawer();
          },
        ),
        const SizedBox(height: 8),
        buildMenuItem(
          title: 'Serviços',
          icon: Icons.build_circle, // ícone de serviços/técnico
          index: 3,
          appState: appState,
          onPressed: () {
            appState.setMenuIndex(3);
            Scaffold.of(context).closeDrawer();
          },
        ),
        const SizedBox(height: 8),
        buildMenuItem(
          title: 'Vendas',
          icon: Icons.point_of_sale, // ícone de vendas
          index: 4,
          appState: appState,
          onPressed: () {
            appState.setMenuIndex(4);
            Scaffold.of(context).closeDrawer();
          },
        ),
        const SizedBox(height: 8),
        buildMenuItem(
          title: 'Receitas',
          icon: Icons.trending_up, // ícone de receitas (ganhos)
          index: 5,
          appState: appState,
          onPressed: () {
            appState.setMenuIndex(5);
            Scaffold.of(context).closeDrawer();
          },
        ),
        const SizedBox(height: 8),
        buildMenuItem(
          title: 'Despesas',
          icon: Icons.trending_down, // ícone de despesas (perdas)
          index: 6,
          appState: appState,
          onPressed: () {
            appState.setMenuIndex(6);
            Scaffold.of(context).closeDrawer();
          },
        ),
        const SizedBox(height: 8),
        buildMenuItem(
          title: 'Relatórios',
          icon: Icons.bar_chart, // ícone de relatórios
          index: 7,
          appState: appState,
          onPressed: () {
            appState.setMenuIndex(7);
            Scaffold.of(context).closeDrawer();
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

Widget buildMenuItem(
    {required String title,
    required IconData icon,
    required int index,
    required AppState appState,
    required void Function()? onPressed}) {
  final isSelected = appState.menuIndex == index;
  return TextButton(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(4, 50)),
      padding:
          WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.whiteTransparent;
          }
          return null;
        },
      ),
    ),
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.secondary : AppColors.secondaryText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(
          icon,
          size: 20,
          color: isSelected ? AppColors.secondary : AppColors.secondaryText,
        ),
      ],
    ),
  );
}
