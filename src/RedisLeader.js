var ip = require("ip");

exports.getIPAdderess = function() {
  return ip.address();
}

exports.getPID = function() {
  return process.pid;
}

exports.ipToNumber = function(i) {
  return ip.toLong(i);
}

exports.numberToIP = function(s) {
  return ip.fromLong(s);
}