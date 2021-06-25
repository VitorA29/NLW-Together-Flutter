import 'package:flutter/material.dart';
import 'package:payflow/shared/app_strings.pt_BR.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class InsertBoletoPage extends StatelessWidget
{
  const InsertBoletoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 93,
              vertical: 24,
            ),
            child: Text(
              AppStrings.insertBoletoTypeData,
              style: AppTextStyles.titleBoldHeading,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
