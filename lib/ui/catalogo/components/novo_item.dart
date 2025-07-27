import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repsys/ui/core/themes/colors.dart';
import 'package:repsys/ui/core/ui/input_decorations.dart';
import 'package:repsys/ui/core/ui/validators.dart';
import 'package:repsys/utils/constants.dart';

class NovoItem extends StatefulWidget {
  const NovoItem({super.key});

  @override
  State<NovoItem> createState() => _NovoItemState();
}

class _NovoItemState extends State<NovoItem> {
  final _formKey = GlobalKey<FormState>();
  String? _tipo;
  final _quantidadeController = TextEditingController(text: '1');
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _marcaController = TextEditingController();
  final _codigoController = TextEditingController();
  final _numeroSerieController = TextEditingController();
  final _imeiController = TextEditingController();
  final _valorCompraController = TextEditingController();
  final _valorVendaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
     
      constraints: BoxConstraints(maxWidth: 1024),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// header do modal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Novo item',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close_rounded, color: AppColors.primaryText),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(
              height: 1,
              color: AppColors.borderColor,
            ),

            /// Formulário para adicionar novo item
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _tipo,
                              items: tipoCatalogo
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                              style: TextStyle(
                                height: 1.6,
                                color: AppColors.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: AppInputDecorations.normal(
                                label: 'Tipo',
                                icon: Icons.category,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _quantidadeController,
                              keyboardType: TextInputType.number,
                              decoration: AppInputDecorations.normal(
                                label: 'Quantidade',
                                icon: Icons.numbers,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _nomeController,
                        textCapitalization: TextCapitalization.words,
                        validator: AppValidators.nome(),
                        decoration: AppInputDecorations.normal(
                          label: 'Nome',
                          icon: Icons.label,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _descricaoController,
                        decoration: AppInputDecorations.normal(
                          label: 'Descrição',
                          icon: Icons.description,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _marcaController,
                              validator: AppValidators.nome(),
                              decoration: AppInputDecorations.normal(
                                label: 'Marca',
                                icon: Icons.business,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _codigoController,
                              decoration: AppInputDecorations.normal(
                                label: 'Código',
                                icon: Icons.qr_code,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _numeroSerieController,
                              decoration: AppInputDecorations.normal(
                                label: 'Número de Série',
                                icon: Icons.confirmation_number,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _imeiController,
                              decoration: AppInputDecorations.normal(
                                label: 'Imei',
                                icon: Icons.smartphone,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _valorCompraController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                RealInputFormatter(moeda: true),
                              ],
                              decoration: AppInputDecorations.normal(
                                label: 'Valor de compra (un)',
                                icon: Icons.shopping_cart,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _valorVendaController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                RealInputFormatter(moeda: true),
                              ],
                              validator: AppValidators.nome(),
                              decoration: AppInputDecorations.normal(
                                label: 'Valor de venda (un)',
                                icon: Icons.attach_money,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Divider(
              height: 1,
              color: AppColors.borderColor,
            ),

            /// Ações do modal
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(0, 50)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Cancelar',
                            style: TextStyle(
                                color: AppColors.primaryText, fontSize: 14)),
                      )),
                ),
                SizedBox(width: 16),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8.0),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                      }
                    },
                    style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size(0, 50)),
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.primary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Salvar',
                          style: TextStyle(
                              color: AppColors.secondary, fontSize: 14)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
