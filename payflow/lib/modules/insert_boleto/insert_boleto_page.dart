import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/app_strings.pt_BR.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/input_text/input_text_widget.dart';
import '../../shared/widgets/set_label_buttons/set_label_buttons.dart';
import 'insert_boleto_controller.dart';

class InsertBoletoPage extends StatefulWidget
{
  final String? barcode;
  const InsertBoletoPage({
    Key? key,
    this.barcode,
  }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage>
{
  final boletoController = InsertBoletoController();

  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: AppStrings.genericMoneySymbol,
    decimalSeparator: AppStrings.genericDecimalSeparator,
  );

  final dueDateInputTextController = MaskedTextController(
    mask: AppStrings.genericDateMask,
  );

  final barcodeInputTextController = TextEditingController();

  @override
  void initState()
  {
    if (widget.barcode != null)
    {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 65,
                ),
                child: Text(
                  AppStrings.insertBoletoTypeDataTitle,
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: boletoController.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: AppStrings.insertBoletoFormFieldName,
                      icon: Icons.description_outlined,
                      validator: boletoController.validateName,
                      onChanged: (value) {
                        boletoController.onChange(name: value);
                      },
                    ),
                    InputTextWidget(
                      label: AppStrings.insertBoletoFormFieldDueDate,
                      icon: FontAwesomeIcons.timesCircle,
                      validator: boletoController.validateDueDate,
                      controller: dueDateInputTextController,
                      onChanged: (value) {
                        boletoController.onChange(dueDate: value);
                      },
                    ),
                    InputTextWidget(
                      label: AppStrings.insertBoletoFormFieldValue,
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => boletoController.validateValue(moneyInputTextController.numberValue),
                      controller: moneyInputTextController,
                      onChanged: (value) {
                        boletoController.onChange(value: moneyInputTextController.numberValue);
                      },
                    ),
                    InputTextWidget(
                      label: AppStrings.insertBoletoFormFieldBarcode,
                      icon: FontAwesomeIcons.barcode,
                      validator: boletoController.validateBarcode,
                      controller: barcodeInputTextController,
                      onChanged: (value) {
                        boletoController.onChange(barcode: value);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: AppStrings.genericTextCancel,
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: AppStrings.insertBoletoFormFieldConfirm,
        secondaryOnPressed: () async {
          await boletoController.registerBoleto();
          Navigator.popUntil(context, ModalRoute.withName("/home"));
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
