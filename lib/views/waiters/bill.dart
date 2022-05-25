import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

// import 'package:pdf_test/PdfPreviewScreen.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'dart:io';
// ignore: camel_case_types




class Pdfview extends StatefulWidget {
  const Pdfview({ Key? key }) : super(key: key);
  

  @override
  State<Pdfview> createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {




  @override
  Widget build(BuildContext context) {
    final pdf = pw.Document();
    
      writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text("Easy Approach Document")),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Header(level: 1, child: pw.Text("Second Heading")),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        ];
      },
    ));
  }
   Future savePdf() async {
    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String documentPath = documentDirectory.path;
    File file = File("Bill.pdf");
    file.writeAsBytesSync(await pdf.save());
  }
writeOnPdf();
          savePdf();

    return Scaffold(
      appBar: AppBar(
        title: Text("Table"),
        centerTitle: true,
      ),

      body: Container(
        
      ),
    );
  }
}

// class PDFcreate extends StatelessWidget {
//   final pdf = pw.Document();

//   writeOnPdf() {
//     pdf.addPage(pw.MultiPage(
//       pageFormat: PdfPageFormat.a5,
//       margin: pw.EdgeInsets.all(32),
//       build: (pw.Context context) {
//         return <pw.Widget>[
//           pw.Header(level: 0, child: pw.Text("Easy Approach Document")),
//           pw.Paragraph(
//               text:
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
//           pw.Paragraph(
//               text:
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
//           pw.Header(level: 1, child: pw.Text("Second Heading")),
//           pw.Paragraph(
//               text:
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
//           pw.Paragraph(
//               text:
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
//           pw.Paragraph(
//               text:
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
//         ];
//       },
//     ));
//   }

//   Future savePdf() async {
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String documentPath = documentDirectory.path;
//     File file = File("$documentPath/Bill.pdf");
//     file.writeAsBytesSync(await pdf.save());
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("PDF Flutter"),
//       ),

//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "PDF TUTORIAL",
//               style: TextStyle(fontSize: 34),
//             )
//           ],
//         ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           writeOnPdf();
//           await savePdf();

//           Directory documentDirectory =
//               await getApplicationDocumentsDirectory();

//           String documentPath = documentDirectory.path;

//           String fullPath = "$documentPath/Bill.pdf";

//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return PDF(
//               enableSwipe: true,
//               swipeHorizontal: true,
//               autoSpacing: false,
//               pageFling: false,
//               onError: (error) {
//                 print(error.toString());
//               },
//               onPageError: (page, error) {
//                 print('$page: ${error.toString()}');
//               },
//             ).fromAsset('assets/pdf/file-example.pdf');
//           }));
//         },
//         child: Icon(Icons.save),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

class billwidget extends StatefulWidget {
  const billwidget({Key? key}) : super(key: key);

  @override
  State<billwidget> createState() => _billwidgetState();
}

// ignore: camel_case_types
class _billwidgetState extends State<billwidget> {
  int indexes = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height/1.1,
        child: Row(
      children: [
        Flexible(
            flex: 1,
            child: Container(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: ((context, index) {
                    return Container(
                      color: index == indexes ? Colors.white : Colors.teal,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            indexes = index;
                          });
                        },
                        child: Text(
                          'Table ${index + 1}',
                          style: TextStyle(
                            color:
                                index == indexes ? Colors.black : Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  })),
            )),
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.white,
            )),
        Flexible(
          flex: 4,
          child: Container(
            margin: EdgeInsets.all(10),
            color: Colors.grey,
            child: Pdfview(),
          ),
        ),
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.white,
              
            )),
      ],
    ));
  }
}
