import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSL {
  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<SecurityContext> get globalContext async {
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);

    try {
      final sslCert = await rootBundle.load('assets/certificates.pem');

      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    } catch (e) {
      securityContext
          .setTrustedCertificatesBytes(utf8.encode(_certificatedString));
    }

    return securityContext;
  }

  static Future<http.Client> getSSLPinningClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }

  static Future<void> init() async {
    _clientInstance = await getSSLPinningClient();
  }

  static const _certificatedString = """-----BEGIN CERTIFICATE-----
MIIF3TCCBMWgAwIBAgIQBU5k858wCe81ZBbaQSKT6jANBgkqhkiG9w0BAQsFADA8
MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRwwGgYDVQQDExNBbWF6b24g
UlNBIDIwNDggTTAzMB4XDTIzMDgyMDAwMDAwMFoXDTI0MDkxNzIzNTk1OVowGzEZ
MBcGA1UEAwwQKi50aGVtb3ZpZWRiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAM4RDA/7fITKEVjDJVHh4nujsIWGxJTOci40BPZ5hiCZIKH82Vgd
O0G7CjG2ovJtma6oHjoZNP06/l4k9nSYJWDt0XskYXXsmb8n99hVqFbWJBcu04kG
lM3ixS+qtC0Fn6HoMdA83oZ6LNYEUUX5yDnYrla0yHuIxSGfk8aFeTaynPMEIhPd
ftrAxmkVQXo/vDYOmH95SJ0BDTn9qlBQunDdLwuUZYTElvLuLrMV1SmrNO1esPmQ
NFbu5sQqDiIvmAhrib9MgStdtgDVauv26Ez9CSBXNARLERqda68kExphK6Ao/PsQ
tmocJ8M/r3rECaiXYfmtMsxlPYG+JlqEtZcCAwEAAaOCAvowggL2MB8GA1UdIwQY
MBaAFFXZGF/SHMwB4Vi0vqvZVUIB1y4CMB0GA1UdDgQWBBQIF55AezZ7WHylf3Nd
Nqjmj9XLETArBgNVHREEJDAighAqLnRoZW1vdmllZGIub3Jngg50aGVtb3ZpZWRi
Lm9yZzAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUF
BwMCMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9jcmwucjJtMDMuYW1hem9udHJ1
c3QuY29tL3IybTAzLmNybDATBgNVHSAEDDAKMAgGBmeBDAECATB1BggrBgEFBQcB
AQRpMGcwLQYIKwYBBQUHMAGGIWh0dHA6Ly9vY3NwLnIybTAzLmFtYXpvbnRydXN0
LmNvbTA2BggrBgEFBQcwAoYqaHR0cDovL2NydC5yMm0wMy5hbWF6b250cnVzdC5j
b20vcjJtMDMuY2VyMAwGA1UdEwEB/wQCMAAwggF/BgorBgEEAdZ5AgQCBIIBbwSC
AWsBaQB2AHb/iD8KtvuVUcJhzPWHujS0pM27KdxoQgqf5mdMWjp0AAABihFTZZYA
AAQDAEcwRQIgHeP/gyKgSNQFyaQ8ZdislEo+t3Qowj0g6mYwltXSQiMCIQDbsz2C
ijIOgg9m+8ijbDwJqshtO48nBCebTfLvq3Hu5gB2AEiw42vapkc0D+VqAvqdMOsc
UgHLVt0sgdm7v6s52IRzAAABihFTZUMAAAQDAEcwRQIgdA370M+F0slfnSu1Pde3
utHpyKNzP+RL83ByCosCvuYCIQDQmzz9cNYJ90KIuqv9DEd7GuTpU6aR8YJKDPJf
E5/+zAB3ANq2v2s/tbYin5vCu1xr6HCRcWy7UYSFNL2kPTBI1/urAAABihFTZWwA
AAQDAEgwRgIhANE+WQc6cF18gSTGVLvIE5cqOqNVqubih0693oOJrFnXAiEAkDoB
sWzu68f4ZsMhOX/wiUhBijmfQBttJu1sHZQj6kcwDQYJKoZIhvcNAQELBQADggEB
AFhtX8sPyAO6PvFPo2G5ByymhZeabvWWb9pr+8wky0tAktiE4v0kS/iNOjZOj1o5
Gjf1xRRC/4PUy+x97r/Ym5MoERZ+SUxIg3+Xa1oUw/Drvp/17ke8n20NhPx1uWcG
nxJoMNWxk0jc4N1XE0a1wDjXETp5y+rkHxgk/EtWIYOv/MKMGVhuFa6pJCN8sOLp
YM/fSs46iwbYs0S+H6m+FuPIugEwh5yrOaaFWzU2vGYit3Wwbwmh98a6KAEwWdWC
+RInnRJ0qSgg39WWQOoQ+CH0DtO0nBRZPfiH2Goks5oqJlR9HFIHfOPjJDen6vA6
0quekhMPfQ9lD1GDOcKFGlE=
-----END CERTIFICATE-----""";
}
