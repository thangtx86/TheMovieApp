import 'dart:developer';

void logInfo(String tag, String message) {
  log("$tag - INFOR : $message", name: "INFOR");
}

void logError(String tag, String message) {
  log("$tag - ERROR : $message");
  log("$tag", name: "ERROR", error: message);
}
