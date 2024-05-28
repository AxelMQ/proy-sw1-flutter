import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FechaSelectWidget extends StatefulWidget {
  final TextEditingController fechaNacController;
  final DateTime? selectedDate;
  final String? Function(String?)? validator;

  const FechaSelectWidget({
    super.key,
    required this.fechaNacController,
    this.selectedDate,
    this.validator,
  });

  @override
  State<FechaSelectWidget> createState() => _FechaSelectWidgetState();
}

class _FechaSelectWidgetState extends State<FechaSelectWidget> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.fechaNacController.text.isNotEmpty) {
      _selectedDate =
          DateFormat('dd-MM-yyyy').parse(widget.fechaNacController.text);
    } else if (widget.selectedDate != null) {
      _selectedDate = widget.selectedDate;
      widget.fechaNacController.text = DateFormat('dd-MM-yyyy').format(widget.selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
        validator: widget.validator,
        builder: (FormFieldState<String> state) {
          return InkWell(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1900),
                maxTime: DateTime.now(),
                onConfirm: (date) {
                  setState(() {
                    _selectedDate = date;
                    widget.fechaNacController.text =
                        DateFormat('dd-MM-yyyy').format(date);
                  });
                  state.didChange(widget.fechaNacController.text);
                },
                currentTime: _selectedDate ?? DateTime.now(),
              );
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento',
                labelStyle: GoogleFonts.dosis(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.orange,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                errorText: state.errorText,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Selecciona una fecha'
                        : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                    style: GoogleFonts.dosis(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  const Icon(Icons.calendar_today_rounded),
                ],
              ),
            ),
          );
        });
  }
}
