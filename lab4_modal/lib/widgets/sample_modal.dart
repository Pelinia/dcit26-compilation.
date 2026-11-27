/*

Lab 4 - Modal and Scrolling
Angelo_Monterroyo
Jaojao_Paredes
Karl_Pelinia
BSCS3-1

*/


import 'package:flutter/material.dart';

/// Reusable modal dialog: image on top, scrollable long text, CLOSE button.
class SampleModal extends StatelessWidget {
  const SampleModal({super.key});

  static const Color _green = Color(0xFF23704A);

  static const List<String> _paragraphs = [
    'The missile knows where it is at all times. It knows this because it knows where it isn\'t.'
        'By subtracting where it is from where it isn\'t, or where it isn\'t from where it is '
        '(whichever is greater), it obtains a difference, or deviation. The guidance subsystem '
        'uses deviations to generate corrective commands to drive the missile from a position '
        'where it is to a position where it isn\'t, and arriving at a position where it wasn\'t, '
        'it now is. Consequently, the position where it is, is now the position that it wasn\'t, '
        'and it follows that the position that it was, is now the position that it isn\'t.',

    'In the event that the position that it is in is not the position that it wasn\'t, the system '
        'has acquired a variation, the variation being the difference between where the missile is, '
        'and where it wasn\'t. If variation is considered to be a significant factor, it too may be '
        'corrected by the GEA. However, the missile must also know where it was.The missile '
        'guidance computer scenario works as follows. Because a variation has modified some of the '
        'information the missile has obtained, it is not sure just where it is. However, it is sure '
        'where it isn\'t, within reason, and it knows where it was. It now subtracts where it should '
        'be from where it wasn\'t, or vice-versa, and by differentiating this from the algebraic sum '
        'of where it shouldn\'t be, and where it was, it is able to obtain the deviation and its '
        'variation, which is called error.',

    'A dialog is a small window that appears on top of the current screen and '
        'asks for the user\'s attention. A modal dialog blocks interaction '
        'with the rest of the app until it is dismissed, which makes it '
        'useful for confirmations, alerts, and short forms.',

    'When content is taller than the space available, wrapping it in a '
        'scrollable widget such as SingleChildScrollView lets users reach '
        'every part of it without causing an overflow error. Placing the '
        'scrollable area inside an Expanded or Flexible widget keeps it '
        'bounded so the image above and the button below stay visible.',

    'In this exercise the dialog is defined in its own Dart file under '
        'lib/widgets, so it can be reused anywhere in the app. The main '
        'screen simply imports it and opens it with showDialog() when the '
        'button is pressed.',

    'Keep scrolling to confirm that this text moves independently of the '
        'image and the CLOSE button. When you are done reading, press CLOSE '
        'to dismiss the dialog and return to the first screen.',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title bar
            Container(
              color: _green,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const Text(
                'SampleModal',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Image at the top
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/sample_modal_image.png',
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Bounded scrollable text
            Flexible(
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final text in _paragraphs)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            text,
                            style: const TextStyle(fontSize: 14, height: 1.4),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // CLOSE button beneath the text
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'CLOSE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
