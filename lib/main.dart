import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String title = 'Hello wolds';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body:  Center(
          child: Text(title),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon( Icons.pending ),
          onPressed: () async{
            try{
             final instance = InternetConnectionCheckerPlus.createInstance(
                checkInterval: Duration( minutes: 4),
                checkTimeout: Duration( seconds: 4 ),
                addresses: [
                  AddressCheckOptions(
                    Uri.parse('https://google.com'),
                    headers: {
                      'Content-Type': 'application/json',
                      'Accept': 'application/json',
                    },
                    timeout: const Duration(seconds: 5),
                  )
                ],
              );

              bool result = await instance.hasConnection;
              if(result == true) {
                setState(() {
                  title = 'YAY! Free cute dog pics!';
                });
                print('YAY! Free cute dog pics!');
                instance.statusController.onCancel;
              } else {
                setState(() {
                  title = 'No internet :( Reason:';
                });
                print('No internet :( Reason:');
                instance.statusController.onCancel;
                // print(InternetConnectionCheckerPlus());
              }

            }
            catch(e){
              print('Sucedio un error $e');
            }
//           final checker = InetConnectivityChecker(
//             endpoint: const InetEndpoint(host: 'google.com', port: 443),
//             // optional timeout. if unspecified the operating system 
//             // default connect timeout will be used instead (~120s).
//             timeout: const Duration(seconds: 10),
//           );

// // tired of waiting?
// // checker.cancel();

//           final isConnected = await checker.cancelableOperation.value;
//           print( isConnected );


          },
        ),
      ),
    );
  }
}