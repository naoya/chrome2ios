var link, og, pageInfo;
pageInfo = {
  url: document.location.href,
  title: document.title,
  selection: window.getSelection().toString(),
  isMap: false,
  image: null
};
if (pageInfo.url.match(/^http[s]?:\/\/maps\.google\./)) {
  link = document.getElementById('link');
  if (link && link.href) {
    pageInfo.url = link.href;
    pageInfo.isMap = true;
  }
}
og = {};
$('meta[property^="og:"]').each(function() {
  return og[$(this).attr('property').match(/og:(.+)$/)[1]] = $(this).attr('content');
});
if (og.image) {
  pageInfo.image = og.image;
}
chrome.extension.connect().postMessage(pageInfo);