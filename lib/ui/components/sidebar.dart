import 'package:flutter/material.dart';
import 'package:repsys/ui/components/menu_itens.dart';
import 'package:repsys/ui/core/themes/colors.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        color: AppColors.primaryText,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Image.network(
                      'https://api.repsys.sognolabs.org/storage/v1/object/public/assets//logo_low_bg_dark.png',
                      width: 160,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.whiteTransparent),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('iTech Assistant Support',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(height: 8),
                                Text('Premium',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.settings_rounded,
                              color: AppColors.secondaryText, size: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.whiteTransparent),
            Padding(padding: EdgeInsets.all(16.0), child: const MenuItens(),),
          ],
        ));
  }
}
