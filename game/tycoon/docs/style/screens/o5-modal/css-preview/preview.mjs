const examples={
  confirm:{file:'01-confirm',title:'Thoát game',kicker:'XÁC NHẬN',body:'Bạn muốn thoát Cờ Tỷ Phú?',ok:'Thoát',cancel:'Hủy',icon:'check'},
  danger:{file:'02-danger',title:'Bỏ cuộc',kicker:'HÀNH ĐỘNG QUAN TRỌNG',body:'Bạn sẽ bị tính phá sản và rời ván.\nBạn có chắc muốn bỏ cuộc?',ok:'Bỏ cuộc',cancel:'Hủy',icon:'warning'},
  notice:{file:'03-notice',title:'Bạn đã rời bàn',kicker:'THÔNG BÁO',body:'Chủ bàn đã mời bạn ra khỏi bàn.\nBạn có thể chọn bàn khác tại sảnh.',ok:'Về sảnh',icon:'info'},
  error:{file:'04-error',title:'Mất kết nối',kicker:'CÓ LỖI',body:'Chưa thể kết nối vào bàn.\nKiểm tra mạng rồi thử lại nhé.',ok:'Thử lại',cancel:'Để sau',icon:'wifi'},
};
const card=document.querySelector('#css-modal'),frame=document.querySelector('#css-frame');
const reference=document.querySelector('#reference-image'),overlay=document.querySelector('#overlay-reference');
let timer;
function makeButton(text,tone,action){return `<button type="button" class="art-button" data-tone="${tone}" data-action="${action}"><span class="button-spinner" aria-hidden="true"></span><span class="label">${text}</span></button>`;}
function selectCase(id){
  const c=examples[id];if(!c)return;clearTimeout(timer);card.dataset.case=id;
  card.innerHTML=`<div class="modal-heading"><div class="modal-badge" aria-hidden="true"><span class="css-glyph glyph-${c.icon}">${c.icon==='wifi'?'<span class="arc"></span><span class="arc"></span><span class="arc"></span>':''}</span></div><div class="heading-copy"><p class="modal-kicker">${c.kicker}</p><h2 class="modal-title" id="modal-title">${c.title}</h2></div></div><p class="modal-body"></p><div class="modal-actions">${c.cancel?makeButton(c.cancel,'paper','cancel'):''}${makeButton(c.ok,id==='danger'?'danger':'gold','ok')}</div>`;
  card.querySelector('.modal-body').textContent=c.body;
  reference.src=overlay.src=`../examples/${c.file}.webp`;reference.alt=`Ảnh mẫu modal ${c.title}`;
  document.querySelectorAll('[data-case]').forEach(el=>{if(el.tagName==='BUTTON')el.setAttribute('aria-pressed',String(el.dataset.case===id));});
  document.querySelector('#feedback').textContent='Dùng chuột hoặc Tab để thử nút. Chưa ghép vào game.';
}
document.querySelector('.cases').addEventListener('click',e=>{const b=e.target.closest('button[data-case]');if(b)selectCase(b.dataset.case);});
const mode=document.querySelector('#view-mode');
function updateView(){document.querySelector('#comparison').dataset.view=mode.value;document.querySelector('#opacity-control').hidden=mode.value!=='overlay';}
mode.addEventListener('change',updateView);
document.querySelector('#opacity').addEventListener('input',e=>{frame.style.setProperty('--reference-opacity',Number(e.target.value)/100);document.querySelector('#opacity-value').textContent=`${e.target.value}%`;});
new ResizeObserver(()=>{if(frame.clientWidth)frame.style.setProperty('--board-scale',frame.clientWidth/390);}).observe(frame);
card.addEventListener('click',e=>{
  const button=e.target.closest('button');if(!button||button.disabled||button.getAttribute('aria-busy')==='true')return;
  if(button.dataset.action==='cancel'){document.querySelector('#feedback').textContent='Đã bấm nút phụ · giữ hộp để bạn tiếp tục so sánh.';return;}
  button.setAttribute('aria-busy','true');button.setAttribute('aria-disabled','true');const cancel=card.querySelector('[data-action=cancel]');if(cancel)cancel.disabled=true;
  document.querySelector('#feedback').textContent='Đang thử trạng thái xử lý…';
  timer=setTimeout(()=>{button.removeAttribute('aria-busy');button.removeAttribute('aria-disabled');if(cancel)cancel.disabled=false;document.querySelector('#feedback').textContent='Đã bấm thử thành công · không thay đổi dữ liệu game.';},1200);
});
if(matchMedia('(max-width:700px)').matches)mode.value='css';
selectCase('confirm');updateView();
Promise.all([document.fonts.ready,reference.decode(),new Promise((resolve,reject)=>{const image=new Image();image.onload=resolve;image.onerror=reject;image.src='../../s2-lobby/concept-s2-lobby-pixel-16bit.png';})]).then(()=>{document.documentElement.dataset.ready='true';});
