import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

import '../../shared/app_strings.pt_BR.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import '../../shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget
{
  const BarcodeScannerPage({ Key? key }) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage>
{
  final barcodeScannerController = BarcodeScannerController();

  @override
  void initState()
  {
    barcodeScannerController.getAvailableCameras();
    barcodeScannerController.statusNotifier.addListener(() {
      if (barcodeScannerController.status.hasBarcode)
      {
        Navigator.pushReplacementNamed(context, "/insert_boleto");
      }
    });
    super.initState();
  }

  @override
  void dispose()
  {
    barcodeScannerController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: barcodeScannerController.statusNotifier,
            builder: (_, status, __)
            {
              if (status.showCamera)
              {
                return Container(
                  child: status.cameraController!.buildPreview(),
                );
              }
              return Container();
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  AppStrings.barcodeScannerAppBarTitle,
                  style: AppTextStyles.buttonBackground,
                ),
                centerTitle: true,
                backgroundColor: Colors.black,
                leading: BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: AppStrings.barcodeScannerInsertCode,
                primaryOnPressed: () {},
                secondaryLabel: AppStrings.barcodeScannerAddFromGallery,
                secondaryOnPressed: () {},
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: barcodeScannerController.statusNotifier,
            builder: (_, status, __)
            {
              if (status.hasError)
              {
                return BottomSheetWidget(
                  title: AppStrings.barcodeScannerErrorReadingCode,
                  subtitle: AppStrings.barcodeScannerErrorTryAgainMsg,
                  primaryLabel: AppStrings.barcodeScannerTryAgain,
                  primaryOnPressed: () {
                    barcodeScannerController.getAvailableCameras();
                  },
                  secondaryLabel: AppStrings.barcodeScannerTypeCode,
                  secondaryOnPressed: () {},
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
