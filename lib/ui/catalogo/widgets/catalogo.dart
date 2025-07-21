import 'package:flutter/material.dart';
import 'package:repsys/ui/core/themes/colors.dart';
import 'package:repsys/ui/core/ui/input_decorations.dart';

class Catalogo extends StatefulWidget {
  const Catalogo({super.key});

  @override
  State<Catalogo> createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Catálogo',
                  style: Theme.of(context).textTheme.headlineLarge),
              Row(children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8.0),
                  child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(0, 50)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list, color: AppColors.primaryText),
                          SizedBox(width: 8),
                          Text('Filtros',
                              style: TextStyle(
                                  color: AppColors.primaryText, fontSize: 14)),
                        ],
                      )),
                ),
                SizedBox(width: 16),
                Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: TextFormField(
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    decoration: AppInputDecorations.normal(
                      label: 'Pesquisar',
                      icon: Icons.search_rounded,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8.0),
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size(0, 50)),
                      backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: AppColors.secondary),
                        SizedBox(width: 8),
                        Text('Adicionar',
                            style: TextStyle(
                                color: AppColors.secondary, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ])
            ],
          )
        ],
      ),
    );
  }
}
