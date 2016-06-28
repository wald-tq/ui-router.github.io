/** Stolen from https://jsfiddle.net/mekwall/up4nu/ */

(function () {
  // Cache selectors
  var lastId;
  // How close to the top of the screen the the header has to be
  var topGutter = 85;

  // All list items
  menuItems = $("nav.toc").find("a");

  // Anchors corresponding to menu items
  var scrollItems = menuItems.map(function () {
    var item = $($(this).attr("href"));
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
      // Set/remove active class
      console.log(menuItems.length)
      menuItems.removeClass("active")
        .filter("[href='#" + id + "']")
        .addClass("active");
      // menuItems
      //   .parent().removeClass("active")
      //   .end().filter("[href='#" + id + "']").parent().addClass("active");
    }
  });
})();