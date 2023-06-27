import 'package:dio/dio.dart';
import 'package:flutter_project/shared/data/remote/dio_network_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DioNetworkService dioNetworkService;
  late FakeDio fakeDio;
  setUpAll(() {
    fakeDio = FakeDio();
    dioNetworkService = DioNetworkService(fakeDio);
  });
  final updatedHeader = {
    'token': 'randomString',
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  group('GET request\n', () {
    test(
      'perform GET request successfully',
      () async {
        fakeDio.response = Response(
          statusCode: 200,
          data: {},
          requestOptions: RequestOptions(path: ''),
        );

        final res = await dioNetworkService.post('', data: {});

        expect(res.isRight(), true);
      },
    );
    test(
      'fail GET request',
      () async {
        fakeDio.response = null;

        final res = await dioNetworkService.post('', data: {});

        expect(res.isLeft(), true);
      },
    );
  });
  group('POST request\n', () {
    test(
      'perform POST request successfully',
      () async {
        fakeDio.response = Response(
          statusCode: 200,
          data: {},
          requestOptions: RequestOptions(path: ''),
        );

        final res = await dioNetworkService.post('', data: {});

        expect(res.isRight(), true);
      },
    );
    test(
      'fail POST request',
      () async {
        fakeDio.response = null;

        final res = await dioNetworkService.post('', data: {});

        expect(res.isLeft(), true);
      },
    );
  });
  test(
    'dio base options should have baseUrl and headers',
    () {
      expect(
        dioNetworkService.dioBaseOptions.baseUrl,
        dioNetworkService.baseUrl,
      );
      expect(
        dioNetworkService.dioBaseOptions.headers,
        dioNetworkService.headers,
      );
    },
  );
  test(
    'should update request header',
    () {
      expect(dioNetworkService.updateHeader({'token': 'randomString'}),
          updatedHeader);
    },
  );
}

class FakeDio extends Fake implements Dio {
  Response? _reponse;
  set response(Response? res) {
    _reponse = res;
  }

  @override
  set options(BaseOptions options) {
    this.options = options;
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (_reponse == null) {
      throw DioException(requestOptions: RequestOptions(path: path));
    }
    return _reponse as Response<T>;
  }

  @override
  Future<Response<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    if (_reponse == null) {
      throw DioException(requestOptions: RequestOptions(path: path));
    }
    return _reponse as Response<T>;
  }
}
