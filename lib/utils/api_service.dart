// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:developer';

import 'package:clean_api/clean_api.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import 'custom_log.dart';

class ApiService {
  ApiService._();

  static final ApiService instance = ApiService._();

  Map<String, String>? _token;
  late String _baseUrl;
  late bool _enableDialogue;
  late bool _showLogs;
  Box? _cacheBox;
  late Client client;

  void enableCache(Box box) => _cacheBox = box;

  KLog log = KLog();

  void setup(
      {required String baseUrl,
      bool showLogs = false,
      bool enableDialogue = true}) {
    log.init();
    client = Client();
    _baseUrl = baseUrl;
    _showLogs = showLogs;
    _enableDialogue = enableDialogue;
  }

  void setToken(Map<String, String> token) => _token = token;

  Map<String, String> header(bool withToken) {
    if (withToken) {
      return {
        'Content-Type': 'application/json',
        'Content': 'application/json',
        'Accept': 'application/json',
        if (_token != null) ..._token!
      };
    } else {
      return {
        'Content-Type': 'application/json',
        'Content': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  Future<Either<CleanFailure, T>> get<T>(
      {required T Function(Map<String, dynamic> data) fromData,
      required String endPoint,
      bool? showLogs,
      bool withToken = true,
      Either<CleanFailure, T> Function(
              int statusCode, Map<String, dynamic> responseBody)?
          failureHandler}) async {
    final bool canPrint = showLogs ?? _showLogs;

    final Map<String, String> _header = header(withToken);

    try {
      final Response _response = await client.get(
        Uri.parse("$_baseUrl$endPoint"),
        headers: _header,
      );

      log.printInfo(info: "GET: $_baseUrl$endPoint", canPrint: canPrint);
      log.printInfo(info: "Header: $_header", canPrint: canPrint);
      log.printInfo(info: "Response: ${_response.body}", canPrint: canPrint);

      return _handleResponse<T>(
          response: _response,
          endPoint: endPoint,
          fromData: fromData,
          failureHandler: failureHandler,
          canPrint: canPrint);
    } catch (e) {
      log.printError(error: "header: $_header", canPrint: canPrint);

      log.printError(
          error: "1st try error: ${e.toString()}", canPrint: canPrint);
      return left(CleanFailure.withData(
          statusCode: -1,
          enableDialogue: _enableDialogue,
          tag: endPoint,
          method: 'GET',
          url: "$_baseUrl$endPoint",
          header: _header,
          body: const {},
          error: e.toString()));
    }
  }

  Future<Either<CleanFailure, T>> post<T>(
      {required T Function(dynamic data) fromData,
      required Map<String, dynamic> body,
      bool? showLogs,
      required String endPoint,
      bool withToken = true,
      Either<CleanFailure, T> Function(
              int statusCode, Map<String, dynamic> responseBody)?
          failureHandler}) async {
    final bool canPrint = showLogs ?? _showLogs;

    Logger.i("body: $body");

    final Map<String, String> _header = header(withToken);

    try {
      final Response _response = await client.post(
        Uri.http("$_baseUrl$endPoint"),
        body: jsonEncode(body),
        headers: _header,
      );
      Logger.json(_response.body);

      if (_response.statusCode >= 200 && _response.statusCode <= 299) {
        final Map<String, dynamic> _regResponse = jsonDecode(_response.body);

        try {
          final T _typedResponse = fromData(_regResponse);
          log.printSuccess(
              msg: "parsed data: $_typedResponse", canPrint: canPrint);
          return right(_typedResponse);
        } catch (e) {
          Logger.i("error: ${e.toString()}");
          if (failureHandler != null) {
            return failureHandler(
              _response.statusCode,
              jsonDecode(_response.body),
            );
          } else {
            log.printWarning(
                warn: "header: ${_response.request?.headers}",
                canPrint: canPrint);
            log.printWarning(
                warn: "request: ${_response.request}", canPrint: canPrint);

            log.printWarning(
                warn: "body: ${_response.body}", canPrint: canPrint);
            log.printWarning(
                warn: "status code: ${_response.statusCode}",
                canPrint: canPrint);
            return left(CleanFailure.withData(
                statusCode: _response.statusCode,
                enableDialogue: _enableDialogue,
                tag: endPoint,
                method: _response.request!.method,
                url: "$_baseUrl$endPoint",
                header: _response.request?.headers ?? {},
                body: body,
                error: cleanJsonDecode(_response.body)));
          }
        }
      } else {
        Logger.i("else: ${_response.toString()}");
        if (failureHandler != null) {
          return failureHandler(
            _response.statusCode,
            cleanJsonDecode(_response.body),
          );
        } else {
          log.printWarning(
              warn: "header: ${_response.request?.headers}",
              canPrint: canPrint);
          log.printWarning(
              warn: "request: ${_response.request}", canPrint: canPrint);

          log.printWarning(warn: "body: ${_response.body}", canPrint: canPrint);
          log.printWarning(
              warn: "status code: ${_response.statusCode}", canPrint: canPrint);
          return left(CleanFailure.withData(
              statusCode: _response.statusCode,
              tag: endPoint,
              method: _response.request!.method,
              url: "$_baseUrl$endPoint",
              header: _response.request?.headers ?? {},
              body: body,
              error: cleanJsonDecode(_response.body)));
        }
      }
    } catch (e) {
      log.printError(error: "header: $_header", canPrint: canPrint);

      log.printError(
          error: "1st try error: ${e.toString()}", canPrint: canPrint);

      return left(CleanFailure.withData(
          statusCode: -1,
          enableDialogue: _enableDialogue,
          tag: endPoint,
          method: 'POST',
          url: "$_baseUrl$endPoint",
          header: _header,
          body: body,
          error: e.toString()));
    }
  }

  Future<Either<CleanFailure, T>> delete<T>({
    required T Function(dynamic data) fromData,
    required String endPoint,
    Map<String, dynamic>? body,
    bool? showLogs,
    Either<CleanFailure, T> Function(
            int statusCode, Map<String, dynamic> responseBody)?
        failureHandler,
    bool withToken = true,
  }) async {
    final bool canPrint = showLogs ?? _showLogs;
    if (body != null) {
      log.printInfo(info: "body: $body", canPrint: canPrint);
    }
    final Map<String, String> _header = header(withToken);
    try {
      final Response _response = await client.delete(
        Uri.parse("$_baseUrl$endPoint"),
        body: body != null ? jsonEncode(body) : null,
        headers: _header,
      );

      return _handleResponse<T>(
          response: _response,
          endPoint: endPoint,
          fromData: fromData,
          failureHandler: failureHandler,
          canPrint: canPrint);
    } catch (e) {
      log.printError(error: "header: $_header", canPrint: canPrint);
      log.printError(
          error: "1s try error: ${e.toString()}", canPrint: canPrint);
      return left(CleanFailure.withData(
          statusCode: -1,
          enableDialogue: _enableDialogue,
          tag: endPoint,
          method: 'DELETE',
          url: "$_baseUrl$endPoint",
          header: _header,
          body: body ?? {},
          error: e.toString()));
    }
  }

  Future<Either<CleanFailure, Response>> getResponse({
    required String endPoint,
    bool? showLogs,
    bool withToken = true,
  }) async {
    final bool canPrint = showLogs ?? _showLogs;

    final Map<String, String> _header = header(withToken);

    try {
      final Response _response = await client.get(
        Uri.parse("$_baseUrl$endPoint"),
        headers: _header,
      );

      log.printInfo(info: "request: ${_response.request}", canPrint: canPrint);
      log.printResponse(json: _response.body, canPrint: canPrint);

      if (_response.statusCode >= 200 && _response.statusCode <= 299) {
        log.printSuccess(
            msg: "response body: ${_response.body}", canPrint: canPrint);
        return right(_response);
      } else {
        log.printWarning(warn: "header: $_header", canPrint: canPrint);
        log.printWarning(
            warn: "request: ${_response.request}", canPrint: canPrint);

        log.printWarning(warn: "body: ${_response.body}", canPrint: canPrint);
        log.printWarning(
            warn: "status code: ${_response.statusCode}", canPrint: canPrint);

        return left(CleanFailure.withData(
            statusCode: _response.statusCode,
            tag: 'Response',
            method: 'GET',
            enableDialogue: _enableDialogue,
            url: "$_baseUrl$endPoint",
            header: _header,
            body: const {},
            error: cleanJsonDecode(_response.body)));
      }
    } catch (e) {
      log.printError(error: "header: $_header", canPrint: canPrint);

      log.printError(error: "error: ${e.toString()}", canPrint: canPrint);
      return left(CleanFailure.withData(
          statusCode: -1,
          enableDialogue: _enableDialogue,
          tag: 'Response',
          method: 'GET',
          url: "$_baseUrl$endPoint",
          header: _header,
          body: const {},
          error: e.toString()));
    }
  }

  Either<CleanFailure, T> _handleResponse<T>(
      {required Response response,
      required String endPoint,
      Map<String, dynamic>? body,
      required T Function(Map<String, dynamic> data) fromData,
      required Either<CleanFailure, T> Function(
              int statusCode, Map<String, dynamic> responseBody)?
          failureHandler,
      required bool canPrint}) {
    // log.printInfo(info: "request: ${response.request}", canPrint: canPrint);
    // log.printInfo(
    //     info: "status code: ${response.statusCode}", canPrint: canPrint);
    log.printResponse(json: response.body, canPrint: canPrint);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final Map<String, dynamic> _regResponse = jsonDecode(response.body);

      try {
        final T _typedResponse = fromData(_regResponse);
        log.printSuccess(
            msg: "parsed data: $_typedResponse", canPrint: canPrint);
        return right(_typedResponse);
      } catch (e) {
        Logger.i("error: ${e.toString()}");
        if (failureHandler != null) {
          return failureHandler(
            response.statusCode,
            jsonDecode(response.body),
          );
        } else {
          log.printWarning(
              warn: "header: ${response.request?.headers}", canPrint: canPrint);
          log.printWarning(
              warn: "request: ${response.request}", canPrint: canPrint);

          log.printWarning(warn: "body: ${response.body}", canPrint: canPrint);
          log.printWarning(
              warn: "status code: ${response.statusCode}", canPrint: canPrint);
          return left(CleanFailure.withData(
              statusCode: response.statusCode,
              enableDialogue: _enableDialogue,
              tag: endPoint,
              method: response.request!.method,
              url: "$_baseUrl$endPoint",
              header: response.request?.headers ?? {},
              body: body ?? {},
              error: cleanJsonDecode(response.body)));
        }
      }
    } else {
      Logger.i("else: ${response.toString()}");
      if (failureHandler != null) {
        return failureHandler(
          response.statusCode,
          cleanJsonDecode(response.body),
        );
      } else {
        log.printWarning(
            warn: "header: ${response.request?.headers}", canPrint: canPrint);
        log.printWarning(
            warn: "request: ${response.request}", canPrint: canPrint);

        log.printWarning(warn: "body: ${response.body}", canPrint: canPrint);
        log.printWarning(
            warn: "status code: ${response.statusCode}", canPrint: canPrint);
        return left(CleanFailure.withData(
            statusCode: response.statusCode,
            tag: endPoint,
            method: response.request!.method,
            url: "$_baseUrl$endPoint",
            header: response.request?.headers ?? {},
            body: body ?? {},
            error: cleanJsonDecode(response.body)));
      }
    }
  }

  cleanJsonDecode(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      throw body;
    }
  }

  void saveInCache<T>(
      {required Map<String, dynamic> data,
      required String endPoint,
      bool? showLogs}) {
    final bool canPrint = showLogs ?? _showLogs;

    try {
      _cacheBox!.put(endPoint, jsonEncode(data));
      log.printSuccess(msg: "saved data: $data", canPrint: canPrint);
    } catch (e) {
      log.printError(error: "error: ${e.toString()}", canPrint: canPrint);
    }
  }

  Either<CleanFailure, T> getFromCache<T>(
      {required T Function(dynamic data) fromData,
      bool? showLogs,
      required String endPoint}) {
    final bool canPrint = showLogs ?? _showLogs;
    try {
      String? body = _cacheBox?.get(endPoint) as String?;
      if (body != null && body.isNotEmpty) {
        log.printInfo(info: "body: $body", canPrint: canPrint);
        final Map<String, dynamic> _regResponse =
            cleanJsonDecode(body) as Map<String, dynamic>;
        final T _typedResponse = fromData(_regResponse);
        log.printSuccess(
            msg: "parsed data: $_typedResponse", canPrint: canPrint);

        return right(_typedResponse);
      } else {
        log.printError(error: 'No cache available', canPrint: canPrint);
        return left(CleanFailure.withData(
            statusCode: -1,
            enableDialogue: _enableDialogue,
            method: 'getFromCache',
            tag: endPoint,
            url: "$_baseUrl$endPoint",
            header: const {},
            body: const {},
            error: 'No cache available'));
      }
    } catch (e) {
      log.printError(error: "error: ${e.toString()}", canPrint: canPrint);
      return left(CleanFailure.withData(
          statusCode: -1,
          enableDialogue: _enableDialogue,
          method: 'getFromCache',
          tag: endPoint,
          url: "$_baseUrl$endPoint",
          header: const {},
          body: const {},
          error: e.toString()));
    }
  }
}
