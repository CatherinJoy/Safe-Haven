// google_map_page.dart
import 'package:background_sms/background_sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miniproject/cpd.dart';
import 'package:miniproject/provider/location_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
//import 'package:safe_haven/provider/location_provider.dart';
//import 'package:safe_haven/cpd.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Interpreter? interpreter;
  GoogleMapController? mapController; // Add this line
  String alertMessage = ''; // Add this line
  Color iconColor = Colors.green; // Add this line

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _loadModel();
  }

  Future<void> _requestLocationPermission() async {
    try {
      var status = await Permission.location.request();
      if (status.isGranted) {
        Provider.of<LocationProvider>(context, listen: false).getUserLocation();
      } else {
        // Handle permission denied
        print('Location permission denied');
      }
    } catch (e) {
      // Handle exceptions
      print('Error while requesting location permission: $e');
    }
  }

  Future<void> _loadModel() async {
    try {
      var interpreter =
          await Interpreter.fromAsset('assets/crime_detector.tflite');
      setState(() {
        this.interpreter = interpreter;
      });
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  void _handleLocationUpdate(LatLng userLocation) async {
    var prediction =
        await _makePrediction(userLocation.latitude, userLocation.longitude);
    // Use the prediction value as needed (e.g., display it in the UI)
    print(prediction);
    Provider.of<LocationProvider>(context, listen: false)
        .buildMap(mapController!, prediction);
    setState(() {
      if (prediction == "High Risk Area") {
        alertMessage = "High Risk Area: Take Caution!";
        iconColor = Colors.red;
      } else if (prediction == "Low Risk Area") {
        alertMessage = "Low Risk Area: Safe Zone!";
        iconColor = Colors.green;
      } else {
        alertMessage = "Moderate Risk Area: Stay Vigilant!";
        iconColor = Colors.yellow;
      }
    });
  }

  Future<String> _makePrediction(double latitude, double longitude) async {
    try {
      // Call the makePrediction function from cpd.dart
      String prediction = await makePrediction(latitude, longitude);

      return prediction;
    } catch (error, stackTrace) {
      // Handle exceptions
      print('Error while making prediction: $error\n$stackTrace');
      return ''; // Return a default value or handle the error accordingly
    }
  }

  List<double> preprocessInput(double latitude, double longitude) {
    // Add any preprocessing steps here
    return [latitude, longitude];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Location Tracking"),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          if (alertMessage.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: iconColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    alertMessage,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Consumer<LocationProvider>(
              builder: (BuildContext context, LocationProvider locationProvider,
                  child) {
                var userLocation = locationProvider.userLocation;
                if (userLocation != null) {
                  _handleLocationUpdate(userLocation);
                }
                return _buildMap(userLocation, locationProvider.markers);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          onPressed: () {
            // Handle panic button press
            _handlePanicButton(context);
          },
          backgroundColor: Colors.pink,
          child: Center(
            child: Text(
              'Panic Button',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMap(LatLng? userLocation, Map<MarkerId, Marker> markers) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: userLocation ?? const LatLng(0.0, 0.0),
        zoom: 18,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController controller) {
        Provider.of<LocationProvider>(context, listen: false)
            .buildMap(controller, '');
        mapController = controller;
      },
    );
  }
}

void _handlePanicButton(BuildContext context) async {
  print('Panic button pressed');
  String emergencyNumber =
      await _getEmergencyContactNumber(); // Store the emergency number here
  LatLng? userLocation = Provider.of<LocationProvider>(context, listen: false)
      .userLocation; // Store the user location here
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Emergency'),
        content: const Text(
            'Are you sure you want to send an emergency message and call?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Send'),
            onPressed: () async {
              Navigator.of(context).pop();
              if (emergencyNumber.isNotEmpty) {
                _sendEmergencyMessage(context, emergencyNumber,
                    userLocation); // Use the stored emergency number and user location here
                await _makeEmergencyCall(emergencyNumber);
              } else {
                // Handle case when emergency contact number is empty or not available
              }
            },
          ),
        ],
      );
    },
  );
}

/*
void _handlePanicButton(BuildContext context) async {
  print('Panic button pressed');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Emergency'),
        content: const Text(
            'Are you sure you want to send an emergency message and call?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Send'),
            onPressed: () async {
              Navigator.of(context).pop();
              String emergencyNumber = await _getEmergencyContactNumber();
              if (emergencyNumber.isNotEmpty) {
                _sendEmergencyMessage(context, emergencyNumber);
                await _makeEmergencyCall(emergencyNumber);
              } else {
                // Handle case when emergency contact number is empty or not available
              }
            },
          ),
        ],
      );
    },
  );
}
*/

Future<void> _sendEmergencyMessage(
    BuildContext context, String emergencyNumber, LatLng? userLocation) async {
  debugPrint('Sending emergency message to $emergencyNumber');
  const String message = 'Emergency: Help me!';
  final PermissionStatus status = await Permission.sms.status;

  if (status.isGranted) {
    if (userLocation != null) {
      _sendSMS(message, [emergencyNumber], userLocation);
    } else {
      // Handle case when user location is not available
    }
  } else {
    await Permission.sms.request();
    if (await Permission.sms.isGranted) {
      if (userLocation != null) {
        _sendSMS(message, [emergencyNumber], userLocation);
      } else {
        // Handle case when user location is not available
      }
    } else {
      // Handle permission denied
    }
  }
}

/*
Future<void> _sendEmergencyMessage(
    BuildContext context, String emergencyNumber, LatLng? userLocation) async {
      print('Sending emergency message to $emergencyNumber');
  const String message = 'Emergency: Help me!';
  final PermissionStatus status = await Permission.sms.status;

  if (status.isGranted) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final userLocation = locationProvider.userLocation;
    _sendSMS(message, [emergencyNumber], userLocation);
  } else {
    await Permission.sms.request();
    if (await Permission.sms.isGranted) {
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      final userLocation = locationProvider.userLocation;
      _sendSMS(message, [emergencyNumber], userLocation);
    } else {
      // Handle permission denied
    }
  }
}
*/

void _sendSMS(String message, List<String> recipients, LatLng? userLocation) {
  String formattedMessage = message;

  if (userLocation != null) {
    formattedMessage +=
        '\nLocation: ${userLocation.latitude}, ${userLocation.longitude}';
  }

  for (String recipient in recipients) {
    BackgroundSms.sendMessage(
      message: formattedMessage,
      phoneNumber: recipient,
    ).then((value) {
      print('SMS sent successfully to $recipient!');
    }).catchError((error) {
      print('Failed to send SMS to $recipient: $error');
    });
  }
}

Future<String> _getEmergencyContactNumber() async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      print('User UID: $uid');
      final DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('Emergency_Contact_Table')
          .doc(uid)
          .get();
      debugPrint(docSnapshot.data().toString());

      if (docSnapshot.exists) {
        // Access the 'EPhn' field from the document data
        final emergencyNumber = docSnapshot.get('EPhn');
        return emergencyNumber;
      } else {
        // Document with the UID does not exist
        print('Emergency contact document does not exist for UID: $uid');
        return 'default_emergency_number'; // Return a default value or handle the absence of the document
      }
    }
  } catch (e) {
    // Handle exceptions
    print('Error while fetching emergency contact number: $e');
  }

  return 'default_emergency_number'; // Return a default value or handle the error accordingly
}

Future<void> _makeEmergencyCall(String emergencyNumber) async {
  print('Making emergency call to $emergencyNumber');
  await FlutterPhoneDirectCaller.callNumber(emergencyNumber);
}
