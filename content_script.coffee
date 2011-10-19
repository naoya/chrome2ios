pageInfo =
  url: document.location.href
  title: document.title
  selection: window.getSelection().toString()
  isMap: false
  image: null

## Google Maps
if pageInfo.url.match /^http[s]?:\/\/maps\.google\./
  link = document.getElementById('link')
  if link and link.href
    pageInfo.url = link.href
    pageInfo.isMap = true

## Open Graph Protocol
og = {}
$('meta[property^="og:"]').each () ->
  og[ $(@).attr('property').match(/og:(.+)$/)[1] ] = $(@).attr 'content'

if og.image
  pageInfo.image = og.image

chrome.extension.connect().postMessage pageInfo