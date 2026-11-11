import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_webrtc/src/native/rtc_rtp_receiver_impl.dart';

void main() {
  Map<dynamic, dynamic> receiverMap(Map<dynamic, dynamic> track) {
    return <dynamic, dynamic>{
      'receiverId': 'receiver-1',
      'track': track,
      'rtpParameters': <dynamic, dynamic>{
        'transactionId': '',
        'codecs': <dynamic>[],
        'headerExtensions': <dynamic>[],
        'encodings': <dynamic>[],
        'rtcp': <dynamic, dynamic>{'cname': 'cname', 'reducedSize': false},
      },
    };
  }

  // The desktop plugin serializes a receiver without a track, for example the
  // receiver of a stopped transceiver, with an empty track map.
  test('fromMap accepts a receiver without a track', () {
    final receiver = RTCRtpReceiverNative.fromMap(
        receiverMap(<dynamic, dynamic>{}),
        peerConnectionId: 'pc-1');

    expect(receiver.receiverId, 'receiver-1');
    expect(receiver.track, isNull);
  });

  test('fromMap keeps the track of a receiver that has one', () {
    final receiver = RTCRtpReceiverNative.fromMap(
        receiverMap(<dynamic, dynamic>{
          'id': 'track-1',
          'label': 'audio',
          'kind': 'audio',
          'enabled': true,
        }),
        peerConnectionId: 'pc-1');

    expect(receiver.track?.id, 'track-1');
    expect(receiver.track?.kind, 'audio');
  });
}
