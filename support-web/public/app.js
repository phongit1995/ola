(function(){
  var supported=['vi','en'];
  function apply(lang){
    if(supported.indexOf(lang)<0)lang='vi';
    document.documentElement.lang=lang;
    document.documentElement.classList.add('js-ready');
    document.querySelectorAll('[data-lang]').forEach(function(el){
      el.classList.toggle('is-active',el.getAttribute('data-lang')===lang);
    });
    document.querySelectorAll('.langs button').forEach(function(btn){
      btn.setAttribute('aria-pressed',String(btn.dataset.setLang===lang));
    });
    var title=document.querySelector('[data-lang].is-active [data-title]');
    if(title)document.title=title.getAttribute('data-title');
    try{localStorage.setItem('ola-legal-lang',lang)}catch(e){}
  }
  var param=new URLSearchParams(location.search).get('lang');
  var stored=null;
  try{stored=localStorage.getItem('ola-legal-lang')}catch(e){}
  apply(param||stored||(navigator.language||'vi').slice(0,2));
  document.querySelectorAll('.langs button').forEach(function(btn){
    btn.addEventListener('click',function(){apply(btn.dataset.setLang)});
  });
})();


(function(){
  var MESSAGES={"vi":{"errUsername":"Vui lòng nhập tên đăng nhập hợp lệ.","errEmail":"Vui lòng nhập email hợp lệ.","errConfirm":"Vui lòng xác nhận bạn hiểu việc xoá là vĩnh viễn."},"en":{"errUsername":"Please enter a valid username.","errEmail":"Please enter a valid email address.","errConfirm":"Please confirm that you understand deletion is permanent."}};
  var USERNAME=/^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$/;
  var EMAIL=/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
  document.querySelectorAll('.deletion-form').forEach(function(form){
    var text=MESSAGES[form.dataset.langCode];
    var errorBox=form.querySelector('.form-error');
    var success=form.parentElement.querySelector('.form-success');
    function fail(message){errorBox.textContent=message;errorBox.hidden=false}
    form.addEventListener('submit',function(event){
      event.preventDefault();
      errorBox.hidden=true;
      var username=form.username.value.trim();
      var email=form.email.value.trim();
      if(!USERNAME.test(username))return fail(text.errUsername);
      if(!EMAIL.test(email))return fail(text.errEmail);
      if(!form.confirm.checked)return fail(text.errConfirm);
      form.hidden=true;
      success.hidden=false;
      success.scrollIntoView({block:'center',behavior:'smooth'});
    });
  });
})();
