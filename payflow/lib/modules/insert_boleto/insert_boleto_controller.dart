import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../extensions/string_format_extension.dart';
import '../../shared/app_strings.pt_BR.dart';

class InsertBoletoController
{
  final formKey = GlobalKey<FormState>();
  BoletoModel model = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? AppStrings.genericFieldIsEmpty.format(AppStrings.insertBoletoFormFieldName) : null;
  String? validateDueDate(String? value) =>
      value?.isEmpty ?? true ? AppStrings.genericFieldIsEmpty.format(AppStrings.insertBoletoFormFieldDueDate) : null;
  String? validateValue(double value) =>
      value <= 0 ? AppStrings.genericFieldIsNotPositive.format(AppStrings.insertBoletoFormFieldValue) : null;
  String? validateBarcode(String? value) =>
      value?.isEmpty ?? true ? AppStrings.genericFieldIsEmpty.format(AppStrings.insertBoletoFormFieldBarcode) : null;

  void onChange({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  })
  {
    model = model.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }

  Future<void> registerBoleto() async
  {
    final form = formKey.currentState;
    if (form!.validate())
    {
      return await saveBoleto();
    }
  }

  Future<void> saveBoleto() async
  {
    final instance = await SharedPreferences.getInstance();
    final boletos = instance.getStringList("boletos") ?? <String>[];
    boletos.add(model.toJson());
    await instance.setStringList("boletos", boletos);
    return;
  }
}
