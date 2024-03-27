// THIS CODE DICOMOT DARI PROJECT SEBELUMNYA
// Buat http pake yang dari sebelumnya aja udah bagus

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/response.dart';


class ConnectivityWrapper {
  ConnectivityWrapper(this.onReceivedCallback) : super();

  final Function(ConnectivityResult) onReceivedCallback;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void listen() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    var result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) {
    //   return Future.value(null);
    // }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        onReceivedCallback(result);
        break;
      default:
        onReceivedCallback(result);
        break;
    }
  }

}

Future<HTTPResponse> get(url, {Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    var connectivity = ConnectivityResult.none;
    var monde = ConnectivityWrapper((e) => connectivity = e);
    await monde.initConnectivity();
    monde.listen();

    log(connectivity.toString());
    if (connectivity == ConnectivityResult.none) {
      log('$connectivity, no Internet, trying in 10 seconds');
      await Future.delayed(const Duration(seconds: 10));
      if (connectivity == ConnectivityResult.none) {
        log('$connectivity, second try still no internet');
        return HTTPResponse(
            status: HTTPResponseStatus.noInternet,
            userMessage: 'Anda tidak terhubung ke Internet',
            errorCode: '0000'
        );
      }
    }
    log('$connectivity, finally have internet');
    final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }
    ).timeout(timeoutDuration);

    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(
        status: HTTPResponseStatus.timeout,
        userMessage: 'Timeout, Coba periksa koneksi anda',
        errorCode: '0000'
    );
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(
        status: HTTPResponseStatus.error,
        userMessage: 'Terjadi kesalahan',
        errorCode: '0000'
    );
  }
}

Future<HTTPResponse> post(url, {Object? body, Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    var connectivity = ConnectivityResult.none;
    var monde = ConnectivityWrapper((e) => connectivity = e);
    await monde.initConnectivity();
    monde.listen();

    log(connectivity.toString());
    if (connectivity == ConnectivityResult.none) {
      log('$connectivity, no Internet, trying in 10 seconds');
      await Future.delayed(const Duration(seconds: 10));
      if (connectivity == ConnectivityResult.none) {
        log('$connectivity, second try still no internet');
        return HTTPResponse(
            status: HTTPResponseStatus.noInternet,
            userMessage: 'Anda tidak terhubung ke Internet',
            errorCode: '0000'
        );
      }
    }
    log('$connectivity, finally have internet');
    final response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body)
    ).timeout(timeoutDuration);
    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(
        status: HTTPResponseStatus.timeout,
        userMessage: 'Timeout, Coba periksa koneksi anda',
        errorCode: '0000'
    );
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(
        status: HTTPResponseStatus.error,
        userMessage: 'Terjadi kesalahan',
        errorCode: '0000'
    );
  }
}

Future<HTTPResponse> put(url, {Object? body, Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    var connectivity = ConnectivityResult.none;
    var monde = ConnectivityWrapper((e) => connectivity = e);
    await monde.initConnectivity();
    monde.listen();

    log(connectivity.toString());
    if (connectivity == ConnectivityResult.none) {
      log('$connectivity, no Internet, trying in 10 seconds');
      await Future.delayed(const Duration(seconds: 10));
      if (connectivity == ConnectivityResult.none) {
        log('$connectivity, second try still no internet');
        return HTTPResponse(
            status: HTTPResponseStatus.noInternet,
            userMessage: 'Anda tidak terhubung ke Internet',
            errorCode: '0000'
        );
      }
    }
    log('$connectivity, finally have internet');
    final response = await http.put(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body)
    ).timeout(timeoutDuration);

    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(
        status: HTTPResponseStatus.timeout,
        userMessage: 'Timeout, Coba periksa koneksi anda',
        errorCode: '0000'
    );
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(
        status: HTTPResponseStatus.error,
        userMessage: 'Terjadi kesalahan',
        errorCode: '0000'
    );
  }
}

Future<HTTPResponse> delete(url, {Object? body, Duration timeoutDuration = const Duration(seconds: 20)}) async {
  try {
    var connectivity = ConnectivityResult.none;
    var monde = ConnectivityWrapper((e) => connectivity = e);
    await monde.initConnectivity();
    monde.listen();

    log(connectivity.toString());
    if (connectivity == ConnectivityResult.none) {
      log('$connectivity, no Internet, trying in 10 seconds');
      await Future.delayed(const Duration(seconds: 10));
      if (connectivity == ConnectivityResult.none) {
        log('$connectivity, second try still no internet');
        return HTTPResponse(
            status: HTTPResponseStatus.noInternet,
            userMessage: 'Anda tidak terhubung ke Internet',
            errorCode: '0000'
        );
      }
    }
    log('$connectivity, finally have internet');
    final response = await http.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body)
    ).timeout(timeoutDuration);

    return responseCheck(response);
  } on TimeoutException catch(e) {
    log(e.toString());
    return HTTPResponse(
        status: HTTPResponseStatus.timeout,
        userMessage: 'Timeout, Coba periksa koneksi anda',
        errorCode: '0000'
    );
  } on Exception catch(e) {
    log(e.toString());
    return HTTPResponse(
        status: HTTPResponseStatus.error,
        userMessage: 'Terjadi kesalahan',
        errorCode: '0000'
    );
  }
}

HTTPResponse responseCheck(Response response) {
  log(response.body);
  var result = jsonDecode(response.body);
  if ([200, 201].contains(response.statusCode)) {
    if ([200, 201].contains(response.statusCode)) {
      return HTTPResponse(
          status: HTTPResponseStatus.success,
          statusCode: response.statusCode,
          data: result['data'],
          userMessage:result['userMessage'] ?? result['message'] ??  'Berhasil',
          errorCode: '0000'
      );
    } else {
      return HTTPResponse(status: HTTPResponseStatus.failed,
          statusCode: result['data']['status'] ?? 500,
          data: result['data'],
          additionalData: result,
          userMessage: result['userMessage'] ?? result['message'] ??  'Terjadi kesalahan pada server',
          errorCode: '0000'
      );
    }
  } else {
    return HTTPResponse(
        status: HTTPResponseStatus.error,
        statusCode: response.statusCode,
        errorCode: result['errorCode'] ?? '0000',
        data: result['data'],
        userMessage: result['userMessage'] ?? result['message'] ??  'Terjadi kesalahan pada server'
    );
  }
}