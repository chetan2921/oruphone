import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://40.90.224.241:5000';

  // Helper function to handle HTTP requests
  Future<dynamic> _makeRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    String method = 'GET',
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final defaultHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    http.Response response;
    if (method == 'POST') {
      response = await http.post(
        url,
        headers: defaultHeaders,
        body: jsonEncode(body),
      );
    } else {
      response = await http.get(url, headers: defaultHeaders);
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  // Generate OTP
  Future<dynamic> generateOtp(int countryCode, int mobileNumber) async {
    final endpoint = 'login/otpCreate';
    final body = {
      'countryCode': countryCode,
      'mobileNumber': mobileNumber,
    };
    return await _makeRequest(endpoint, body: body, method: 'POST');
  }

  // Validate OTP
  Future<dynamic> validateOtp(
      int countryCode, int mobileNumber, int otp) async {
    final endpoint = 'login/otpValidate';
    final body = {
      'countryCode': countryCode,
      'mobileNumber': mobileNumber,
      'otp': otp,
    };
    return await _makeRequest(endpoint, body: body, method: 'POST');
  }

  // Check if user is logged in
  Future<dynamic> isLoggedIn() async {
    final endpoint = 'isLoggedIn';
    return await _makeRequest(endpoint);
  }

  // Logout
  Future<dynamic> logout(String csrfToken) async {
    final endpoint = 'logout';
    final headers = {'X-Csrf-Token': csrfToken};
    return await _makeRequest(endpoint, headers: headers);
  }

  // Update user name
  Future<dynamic> updateUser(
      int countryCode, String userName, String csrfToken) async {
    final endpoint = 'update';
    final body = {
      'countryCode': countryCode,
      'userName': userName,
    };
    final headers = {'X-Csrf-Token': csrfToken};
    return await _makeRequest(endpoint,
        body: body, method: 'POST', headers: headers);
  }

  // Fetch FAQs
  Future<dynamic> fetchFaqs() async {
    final endpoint = 'faq';
    return await _makeRequest(endpoint);
  }

  // Fetch products with filters
  Future<dynamic> fetchProducts(Map<String, dynamic> filters) async {
    final endpoint = 'filter';
    return await _makeRequest(endpoint, body: filters, method: 'POST');
  }

  // Like a product
  Future<dynamic> likeProduct(
      String listingId, bool isFav, String csrfToken) async {
    final endpoint = 'favs';
    final body = {
      'listingId': listingId,
      'isFav': isFav,
    };
    final headers = {'X-Csrf-Token': csrfToken};
    return await _makeRequest(endpoint,
        body: body, method: 'POST', headers: headers);
  }

  // Fetch brands with images
  Future<dynamic> fetchBrands() async {
    final endpoint = 'makeWithImages';
    return await _makeRequest(endpoint);
  }

  // Fetch search filters
  Future<dynamic> fetchFilters() async {
    final endpoint = 'showSearchFilters';
    return await _makeRequest(endpoint);
  }
}
