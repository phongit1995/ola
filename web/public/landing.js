(function () {
  var measurementId = 'G-BK44FYX684';
  window.dataLayer = window.dataLayer || [];
  function gtag() {
    window.dataLayer.push(arguments);
  }
  gtag('js', new Date());
  gtag('config', measurementId);

  var loader = document.createElement('script');
  loader.async = true;
  loader.src = 'https://www.googletagmanager.com/gtag/js?id=' + measurementId;
  document.head.appendChild(loader);

  document.addEventListener('click', function (event) {
    var link = event.target instanceof Element ? event.target.closest('[data-track]') : null;
    if (!link) return;
    gtag('event', link.getAttribute('data-track'), {
      store: link.getAttribute('data-store') || undefined,
      cta: link.getAttribute('data-cta') || undefined,
      source: 'landing',
      page_path: location.pathname,
    });
  });
})();
