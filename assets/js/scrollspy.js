/** Stolen from https://jsfiddle.net/mekwall/up4nu/ */

(function () {
  // Cache selectors
  var lastId;
  // How close to the top of the screen the the header has to be
  var topGutter = 85;

  // All list items
  toc = $("#markdown-toc");
  menuItems = toc.find("li");

  menuItems.filter(function() {
    return $(this).find("> ul li a").length;
  }).addClass("has-children");

  // Anchors corresponding to menu items
  var scrollItems = menuItems.map(function () {
    var item = $($(this).find("a").attr("href"));
    if (item.length) {
      return item;
    }
  });

  // Bind to scroll
  $(window).scroll(function () {
    // Get container scroll position
    var fromTop = $(this).scrollTop() + topGutter;

    // Get id of current scroll item
    var cur = scrollItems.map(function () {
      if ($(this).offset().top < fromTop)
        return this;
    });

    // Get the id of the current element
    cur = cur[cur.length - 1];
    var id = cur && cur.length ? cur[0].id : "";

    if (lastId !== id) {
      lastId = id;

      // Remove/set the active class
      menuItems.removeClass("active");
      menuItems.removeClass("child-active");
      var activeItems = menuItems.filter(function() {
        return $(this).find("> a[href='#" + id + "']").length;
      });

      activeItems.addClass("active");

      var el = activeItems[0];
      el = el && el.parentNode;
      while (el && el.id !== 'markdown-toc') {
        if (el.tagName === 'LI') {
          el.className += " child-active";
        }
        el = el.parentNode;
      }
    }
  });
})();