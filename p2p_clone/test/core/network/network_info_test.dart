import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:p2p_clone/core/network/network_info.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;
  late NetworkInfoImpl networkInfoImpl;
  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(
      connectivity: mockConnectivity,
    );
  });

  test('should return true when connected to Internet', () async {
    // arrange
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.wifi);
    // act
    final result = await networkInfoImpl.isConnected;
    // assert
    expect(result, true);
    verify(() => mockConnectivity.checkConnectivity());
  });
}
