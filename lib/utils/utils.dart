import 'dart:developer';

void logInfo(String tag, String message) {
  log("${tag.toUpperCase()} - INFOR : $message", name: "INFOR");
}

void logError(String tag, String message) {
  log("${tag.toUpperCase()}", name: "ERROR", error: message);
}
