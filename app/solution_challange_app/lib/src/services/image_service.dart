import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:googleapis/storage/v1.dart' as gcs;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class ImageService {
  Future<String> uploadImage(File imageFile, String bucketName) async {
    // Load the service account key JSON file
    final serviceAccountCredentials = auth.ServiceAccountCredentials.fromJson(
        jsonDecode(
            await rootBundle.loadString("assets/storage-credentials.json")));

    // Define the scopes
    final scopes = [gcs.StorageApi.devstorageReadWriteScope];

    // Get an authenticated HTTP client
    final client =
        await auth.clientViaServiceAccount(serviceAccountCredentials, scopes);

    // Get a reference to the Google Cloud Storage API
    final storage = gcs.StorageApi(client);

    // Create a unique file name for the upload
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Upload the file
    final media = http.ByteStream(Stream.castFrom(imageFile.openRead()));
    final length = await imageFile.length();
    final gcs.Media mediaContent = gcs.Media(media, length);
    final gcs.Object object = await storage.objects.insert(
        gcs.Object()..name = fileName, bucketName,
        uploadMedia: mediaContent);

    // Get the public URL
    String downloadURL =
        'https://storage.googleapis.com/${bucketName}/${object.name}';

    return downloadURL;
  }
}
