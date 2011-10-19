chrome.browserAction.onClicked.addListener (tab) ->
  chrome.tabs.executeScript null, file: "jquery-1.6.4.min.js", ->
    chrome.tabs.executeScript null, file: "content_script.js"

chrome.extension.onConnect.addListener (port) ->
  port.onMessage.addListener (info) ->
    socket = io.connect 'http://localhost:3000'
    if info.isMap
      param = {}
      info.url.split('&').forEach (q) ->
        kv = q.split '=', 2
        param[decodeURIComponent kv[0]] = decodeURIComponent kv[1]
      ll = param['ll'] || param['sll']
      [lat, lng] = ll.split ','
      socket.emit 'fireEvent:openMap'
        latitude: lat
        longitude: lng
    else
      socket.emit 'fireEvent:openUrl'
        title: info.title
        url: info.url
        image: info.image
