$(document).ready(function() {
  $('.typeahead').typeahead({
    name: 'categories',
    remote: '/categories/search.json?q=%QUERY',
    limit: 10,
    valueKey: 'name',
    template: '<a class="redirect" href="/categories/{{id}}"><p><img src="{{icon_prefix}}bg_32{{icon_suffix}}"> <strong>{{name}}</strong></p></a>',
    engine: Hogan
  });
  $('.typeahead').on('typeahead:selected', function(obj, datum) {
    window.location.assign(datum.url);
  });

  $('.hovers').hover(function() {
    $("a[data-category='" + $(this).data('category') + "']").addClass('btn-primary');
  }, function() {
    $("a[data-category='" + $(this).data('category') + "']").removeClass('btn-primary');
  });

});
