# Flutter Network Troubleshooting Guide

## Common Network Issues

You're experiencing network connectivity issues with Flutter that may be caused by:

1. Corporate firewall or proxy blocking connections
2. Network permission issues
3. DNS resolution problems
4. SSL/TLS certificate validation issues

## Quick Solutions

### Run the Provided Scripts

1. Run the PowerShell script as Administrator:
   ```
   Right-click on fix_network.ps1 and select "Run as Administrator"
   ```

2. If the PowerShell script doesn't work, try the batch file:
   ```
   Right-click on fix_network.bat and select "Run as Administrator"
   ```

### Manual Steps

If the scripts don't solve your issue, try these steps manually:

1. Set environment variables to skip connectivity checks:
   ```
   $env:FLUTTER_DOCTOR_NO_CONNECTIVITY = "true"
   ```

2. Try running Flutter with the `--offline` flag:
   ```
   flutter pub get --offline
   ```

3. Bypass dependency checking when building:
   ```
   flutter build apk --debug --no-pub
   ```

4. Repair Flutter:
   ```
   flutter clean
   flutter pub cache repair
   ```

## Firewall/Proxy Settings

If you're behind a corporate firewall or proxy, you may need to configure Flutter to use it:

1. Set proxy environment variables:
   ```
   $env:HTTP_PROXY = "http://your-proxy-server:port"
   $env:HTTPS_PROXY = "http://your-proxy-server:port"
   ```

2. Allow these domains in your firewall:
   - maven.google.com
   - cocoapods.org
   - pub.dev
   - storage.googleapis.com
   - github.com
   - api.flutter.dev

## Alternative Package Sources

If you can't access the default package repositories, you can use alternative mirrors:

1. For Pub packages:
   ```
   $env:PUB_HOSTED_URL = "https://pub.flutter-io.cn"
   $env:FLUTTER_STORAGE_BASE_URL = "https://storage.flutter-io.cn"
   ```

## Last Resort

If nothing else works:

1. Download dependencies on a different network
2. Manually transfer them to your development machine
3. Place them in the appropriate Flutter cache directories 