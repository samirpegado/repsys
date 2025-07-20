import 'package:flutter/material.dart';
import 'package:repsys/ui/core/themes/colors.dart';
import 'package:repsys/utils/constants.dart';


class Topbar extends StatelessWidget {
  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= desktopWidth;
    return Material(
      elevation: 3,
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: !isDesktop,
                child: Builder(
                  builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ),
              Text(''),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.help_outline_rounded,
                        color: AppColors.secondaryText,
                      )),
                  const SizedBox(width: 6),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.secondaryText,
                      )),
                  const SizedBox(width: 6),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_rounded,
                        color: AppColors.secondaryText,
                      )),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () {
    
                    },
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá,',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text('Samir Gomes',
                                style: TextStyle(color: AppColors.secondaryText))
                          ],
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.arrow_drop_down,
                            color: AppColors.secondaryText)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
