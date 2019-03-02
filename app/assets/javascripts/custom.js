function filterLinks() {
  var url = window.location.href.split('q=')[0]
  if ($('#q').val() !== '') {
    if (url.includes('?') && url[url.length - 1] == '?') {
      window.location.replace(url+'q='+$('#q').val())
    } else if (url.includes('?') && url[url.length - 1] !== '?' && url[url.length - 1] !== '&') {
      window.location.replace(url+'&q='+$('#q').val())
    } else if (url[url.length - 1] == '&') {
      window.location.replace(url+'q='+$('#q').val())
    } else {
      window.location.replace(url+'?q='+$('#q').val())
    }
  } else {
    window.location.replace(url)
  }
}

$(document).ready(function() {
  $('.dropdown-menu').on('click', function(e) {
    e.stopPropagation();
  });
})
