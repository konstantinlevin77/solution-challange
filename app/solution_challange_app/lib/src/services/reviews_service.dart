import 'dart:convert';

import 'package:solution_challange_app/src/models/review.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ReviewsService {
  final String baseUrl;

  ReviewsService({required this.baseUrl});

  Future<List<Review>> getReviewsByMenuId(String menuId) async {
    String jwtToken = await SecureStorageService().readSecureData("token");

    final response = await http.get(
        Uri.parse("$baseUrl/protected/userReviews/getByMenuId/$menuId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        });

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Review> reviewList =
          jsonList.map((e) => Review.fromJson(e)).toList();

      return reviewList;
    } else {
      throw Exception(
          "Something went wrong while getting reviews with menu id.");
    }
  }

  Future<bool> addReview(Review review) async {
    String jwtToken = await SecureStorageService().readSecureData("token");

    String reviewJSON = jsonEncode(review.toJson());

    final response = await http.post(
        Uri.parse("$baseUrl/protected/userReviews/add"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
        body: reviewJSON);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Review> getReviewById(String id) async {
    String jwtToken = await SecureStorageService().readSecureData("token");

    final response = await http
        .get(Uri.parse("$baseUrl/protected/userReviews/getById/$id"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      Review review = Review.fromJson(json);
      return review;
    } else {
      // TODO: A better error handling system is needed across all services for sure!
      throw Exception(
          "Failed to find the user review with given id or something went wrong.");
    }
  }

  Future<List<Review>> getReviewsByUserId(String userId) async {
    String jwtToken = await SecureStorageService().readSecureData("token");

    final response = await http.get(
        Uri.parse("$baseUrl/protected/userReviews/getByUserId/$userId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        });

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Review> reviewList =
          jsonList.map((e) => Review.fromJson(e)).toList();

      return reviewList;
    } else {
      throw Exception(
          "Failed to find the reviews with given user id or something went wrong.");
    }
  }
}
