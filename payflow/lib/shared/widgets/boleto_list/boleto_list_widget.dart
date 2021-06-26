import 'package:flutter/material.dart';

import '../../models/boleto_model.dart';
import '../boleto_tile/boleto_tile.dart';
import 'boleto_list_controller.dart';

class BoletoListWidget extends StatefulWidget
{
  final BoletoListController boletoListController;

  const BoletoListWidget({
    Key? key,
    required this.boletoListController,
  }) : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return ValueListenableBuilder<List<BoletoModel>>(
        valueListenable: widget.boletoListController.boletosNotifier,
        builder: (_, boletos, __) => Column(
          children: widget.boletoListController.boletos.map(
            (e) => BoletoTileWidget(data: e)
          ).toList(),
        ),
    );
  }
}
