import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:frenzi_app/core/widgets/layout/spaced_column.dart';
import 'package:frenzi_app/gen/colors.gen.dart';
import 'package:frenzi_app/generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart';

class Dialogs {
  static Future<void> showErrorDialog({
    required BuildContext context,
    String message = '',
    required String title,
    Function(DismissType)? onDismissCallback,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          onDismissCallback: onDismissCallback,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          title: title,
          desc: message.isNotEmpty
              ? message
              : S.of(context).oopsSomethingWentWrongPleaseTryAgainLater,
          descTextStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
          ),
        ).show();
      },
    );
  }

  static Future<void> showSuccessDialog({
    required BuildContext context,
    String title = '',
    String desc = '',
    String buttonText = '',
    Function()? btnOkOnPress,
    Function(DismissType)? onDismissCallback,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        AwesomeDialog(
          context: context,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.success,
          onDismissCallback: onDismissCallback,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          title: title,
          desc: desc,
          descTextStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
          ),
          btnOkText: buttonText,
          btnOkOnPress: btnOkOnPress,
        ).show();
      },
    );
  }

  static Future<void> showLoadingDialog({
    required BuildContext context,
    required double dialogHeight,
    Function(DismissType)? onDismissCallback,
    String message = '',
  }) async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          onDismissCallback: onDismissCallback,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: dialogHeight,
              child: SpacedColumn(
                spacing: 30,
                children: [
                  const SizedBox(
                    width: 45.0,
                    height: 45.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorName.black,
                      ),
                      strokeWidth: 3.0,
                    ),
                  ),
                  if (message.isNotEmpty) ...[
                    Text(
                      message,
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ).show();
      },
    );
  }

  
}
