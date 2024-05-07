import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
export '../widgets/date_picker.dart';

class DatePicker extends StatefulWidget{
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 11, 5),
    end: DateTime(2022, 12, 24),
  );

  @override
  Widget build(BuildContext context){
    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), 
                      side: const BorderSide(width: 1, color: Colors.black),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 253, 246),
                    foregroundColor: Colors.black,
                  ),
                  
                  child: Text('${start.year}/${start.month}/${start.day}', style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.black
              ),), 
                  onPressed: () {}),
                
                ),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(child: Text('${end.year}/${end.month}/${end.day}', style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.black
              ),), 
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), 
                      side: BorderSide(width: 1, color: Colors.black),
                    ),
                    backgroundColor: Color.fromARGB(255, 255, 253, 246),
                    foregroundColor: Colors.black,
                  ),
                onPressed: () {}),),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickDateRange, 
              child: 
              Text('Pick Date Range', style: GoogleFonts.rubik(
                fontSize: 18,
                color: Colors.black
              ),),
              style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), 
                      side: BorderSide(width: 1, color: Colors.black),
                    ),
                    backgroundColor: Color.fromARGB(255, 255, 253, 246),
                    foregroundColor: Colors.black,
                  ),
            )
          ],)
        )
      );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(context: context, initialDateRange: dateRange, firstDate: DateTime(1900), lastDate: DateTime(2100));

    if(newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }
}