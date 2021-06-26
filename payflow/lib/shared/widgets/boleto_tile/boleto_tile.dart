import 'package:flutter/material.dart';

import '../../../extensions/string_format_extension.dart';
import '../../app_strings.pt_BR.dart';
import '../../models/boleto_model.dart';
import '../../themes/app_text_styles.dart';

class BoletoTileWidget extends StatelessWidget
{
  final BoletoModel data;

  const BoletoTileWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        data.name!,
        style: AppTextStyles.titleListTile,
      ),
      subtitle: Text(
        AppStrings.boletoTileDueDateSubtitle.format(data.dueDate),
        style: AppTextStyles.captionBody,
      ),
      trailing: Text.rich(TextSpan(
        text: "${AppStrings.genericMoneySymbol} ",
        style: AppTextStyles.trailingRegular,
        children: [
          TextSpan(
            text: "${data.value!.toStringAsFixed(2)}",
            style: AppTextStyles.trailingBold,
          ),
        ],
      )),
    );
  }
}
