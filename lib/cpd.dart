// cpd.dart
import 'package:tflite_flutter/tflite_flutter.dart';

Future<String> makePrediction(double latitude, double longitude) async {
  // Load the TFLite model
  final interpreter =
      await Interpreter.fromAsset('assets/crime_detector.tflite');

  // Preprocess the input data (latitude and longitude) according to the model's requirements
  var inputData = [latitude, longitude];

  // Run the model inference
  var input = inputData.reshape([1, inputData.length]);
  var output = List.filled(1, List.filled(2, 0.0));

  interpreter.run(input, output);

  // Postprocess the output and determine the risk level
  var predictionIndex =
      output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));
  var riskLevels = ['High Risk Area', 'Moderate Risk Area', 'Low Risk Area'];

  var prediction = riskLevels[predictionIndex];

  // Clean up resources
  interpreter.close();

  return prediction;
}