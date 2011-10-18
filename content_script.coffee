pageInfo =
  url: document.location.href
  title: document.title
  selection: window.getSelection().toString()
  isMap: false

if pageInfo.url.match /^http[s]?:\/\/maps\.google\./
  link = document.getElementById('link')
  if link and link.href
    pageInfo.url = link.href
    pageInfo.isMap = true

 chrome.extension.connect().postMessage pageInfo