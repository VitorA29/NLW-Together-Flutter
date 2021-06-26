import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

import '../../shared/app_strings.pt_BR.dart';
import '../../shared/models/boleto_model.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/boleto_info/boleto_info_widget.dart';
import '../../shared/widgets/boleto_list/boleto_list_controller.dart';
import '../../shared/widgets/boleto_list/boleto_list_widget.dart';

class MyBoletosPage extends StatefulWidget
{
  const MyBoletosPage({ Key? key }) : super(key: key);

  @override
  _MyBoletosPageState createState() => _MyBoletosPageState();
}

class _MyBoletosPageState extends State<MyBoletosPage>
{
  final boletoListController = BoletoListController();

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.primary,
                height: 40,
                width: double.maxFinite,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: ValueListenableBuilder<List<BoletoModel>>(
                  valueListenable: boletoListController.boletosNotifier,
                  builder: (_, boletos, __) =>
                    AnimatedCard(
                      direction: AnimatedCardDirection.top,
                      child: BoletoInfoWidget(size: boletos.length)
                    ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
            ),
            child: Row(
              children: [
                Text(
                  AppStrings.myBoletoPageTitle,
                  style: AppTextStyles.titleBoldHeading,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 24,
            ),
            child: Divider(
              thickness: 1,
              height: 1,
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: AnimatedCard(
              direction: AnimatedCardDirection.bottom,
              child: BoletoListWidget(
                boletoListController: boletoListController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
