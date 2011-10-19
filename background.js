chrome.browserAction.onClicked.addListener(function(tab) {
  return chrome.tabs.executeScript(null, {
    file: "jquery-1.6.4.min.js"
  }, function() {
    return chrome.tabs.executeScript(null, {
      file: "content_script.js"
    });
  });
});
chrome.extension.onConnect.addListener(function(port) {
  return port.onMessage.addListener(function(info) {
    var lat, ll, lng, param, socket, _ref;
    socket = io.connect('http://localhost:3000');
    if (info.isMap) {
      param = {};
      info.url.split('&').forEach(function(q) {
        var kv;
        kv = q.split('=', 2);
        return param[decodeURIComponent(kv[0])] = decodeURIComponent(kv[1]);
      });
      ll = param['ll'] || param['sll'];
      _ref = ll.split(','), lat = _ref[0], lng = _ref[1];
      return socket.emit('fireEvent:openMap', {
        latitude: lat,
        longitude: lng
      });
    } else {
      return socket.emit('fireEvent:openUrl', {
        title: info.title,
        url: info.url,
        image: info.image
      });
    }
  });
});