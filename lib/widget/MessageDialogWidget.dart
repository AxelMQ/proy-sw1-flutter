import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MessageDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? textConfirm;
  final VoidCallback? onConfirm;

  const MessageDialogWidget({
    super.key,
    required this.title,
    required this.message,
    this.textConfirm,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.titilliumWeb(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              title == 'Error' ? 'assets/error.json' : 'assets/good.json',
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.titilliumWeb(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (onConfirm != null) {
              onConfirm!();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: title == 'Error'
              ? Text(
                  'Reintentar',
                  style: GoogleFonts.titilliumWeb(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  textConfirm ?? 'OK',
                  style: GoogleFonts.titilliumWeb(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }
}
