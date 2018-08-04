import 'dart:async';
import 'dart:convert';
import 'dart:io';

final _httpClient = HttpClient();

Future<String> getRequest(Uri uri) async {
  var request = await _httpClient.getUrl(uri);
  var response = await request.close();

  ensureSuccessStatusCode(response.statusCode);
  return response.transform(utf8.decoder).join();
}

Future<String> postRequest(Uri uri, Map<String, dynamic> data) async {
  var request = await _httpClient.postUrl(uri)
    ..headers.contentType = ContentType.json
    ..write(jsonEncode(data));
  var response = await request.close();
  ensureSuccessStatusCode(response.statusCode);
  return response.transform(utf8.decoder).join();
}

void ensureSuccessStatusCode(int statusCode) {
  if (isSuccessStatusCode(statusCode)) return;
  throw new HttpException("Request failed ($statusCode)");
}

bool isSuccessStatusCode(int statusCode) {
  return statusCode >= 200 && statusCode <= 299;
}
