// === DADOS DAS CIDADES POR ESTADO ===
const cidadesPorEstado = {
  SC: ['Balneário Camboriú','Blumenau','Florianópolis','Joinville'],
  SP: ['Bauru','Campinas','Guarulhos','Ribeirão Preto','Santo André','Santos','São José do Rio Preto','São José dos Campos','São Paulo - Borba Gato','São Paulo - Vila Mariana','Sorocaba'],
  PA: ['Belém','Parauapebas'],
  MG: ['Belo Horizonte','Ipatinga','Uberlândia'],
  DF: ['Brasília'],
  MS: ['Campo Grande','Dourados'],
  MT: ['Cuiabá'],
  PR: ['Curitiba','Londrina'],
  CE: ['Fortaleza'],
  GO: ['Goiânia'],
  AL: ['Maceió'],
  RS: ['Porto Alegre'],
  RO: ['Porto Velho'],
  RJ: ['Rio de Janeiro'],
  BA: ['Salvador'],
  MA: ['São Luís'],
  PI: ['Teresina'],
  ES: ['Vitória']
};

// === MAPA INTERATIVO ===
const statePaths = document.querySelectorAll('.state-path');
const mapaTitulo = document.getElementById('mapa-estado-nome');
const mapaCidades = document.getElementById('mapa-cidades-lista');

// Marcar estados com unidades
statePaths.forEach(path => {
  const uf = path.getAttribute('data-uf');
  if (cidadesPorEstado[uf]) {
    path.classList.add('has-city');
  }
  path.addEventListener('click', () => {
    statePaths.forEach(p => p.classList.remove('active'));
    path.classList.add('active');
    const name = path.getAttribute('data-name') || uf;
    mapaTitulo.textContent = name;
    mapaCidades.innerHTML = '';
    const cidades = cidadesPorEstado[uf];
    if (cidades && cidades.length > 0) {
      cidades.forEach(c => {
        const li = document.createElement('li');
        li.textContent = c;
        mapaCidades.appendChild(li);
      });
    } else {
      const li = document.createElement('li');
      li.className = 'mapa-hint';
      li.textContent = 'Nenhuma unidade ainda — seja o primeiro!';
      mapaCidades.appendChild(li);
    }
  });
});

// === FIXED BAR ===
const fixedBar = document.getElementById('fixed-bar');
const spacer = document.getElementById('fixed-bar-spacer');
function updateFixedBar() {
  const hero = document.querySelector('.hero-section');
  const heroBottom = hero ? hero.getBoundingClientRect().bottom : 0;
  const show = heroBottom < 0;
  if (fixedBar) {
    fixedBar.classList.toggle('visible', show);
    if (spacer) spacer.style.height = show ? fixedBar.offsetHeight + 'px' : '0';
  }
}
window.addEventListener('scroll', updateFixedBar, { passive: true });
window.addEventListener('resize', updateFixedBar, { passive: true });
updateFixedBar();

// === NAVBAR ===
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
  if (navbar) navbar.style.boxShadow = window.scrollY > 40 ? '0 4px 24px rgba(0,0,0,.3)' : '';
}, { passive: true });

// === SMOOTH SCROLL ===
document.querySelectorAll('a[href^="#"]').forEach(a => {
  a.addEventListener('click', e => {
    const id = a.getAttribute('href').slice(1);
    const el = document.getElementById(id);
    if (el) { e.preventDefault(); el.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
  });
});

// === HERO FORM ===
const heroForm = document.getElementById('hero-form-el');
if (heroForm) {
  const telIn = document.getElementById('hf-tel');
  if (telIn) {
    telIn.addEventListener('input', () => {
      let v = telIn.value.replace(/\D/g, '').slice(0, 11);
      if (v.length >= 7) v = '(' + v.slice(0,2) + ') ' + v.slice(2,7) + '-' + v.slice(7);
      else if (v.length >= 3) v = '(' + v.slice(0,2) + ') ' + v.slice(2);
      else if (v.length) v = '(' + v;
      telIn.value = v;
    });
  }
  heroForm.addEventListener('submit', e => {
    e.preventDefault();
    document.getElementById('modal-overlay').style.display = 'flex';
    heroForm.reset();
  });
}

// === MODAL ===
const modalClose = document.getElementById('modal-close');
const modalOverlay = document.getElementById('modal-overlay');
if (modalClose) modalClose.addEventListener('click', () => { modalOverlay.style.display = 'none'; });
if (modalOverlay) modalOverlay.addEventListener('click', e => { if (e.target === modalOverlay) modalOverlay.style.display = 'none'; });

// === FADE IN ON SCROLL ===
const fadeEls = document.querySelectorAll('.dif-item, .produto-card, .dep-card, .modelo-card, .vant-card, .step-v');
fadeEls.forEach(el => {
  el.style.opacity = '0';
  el.style.transform = 'translateY(20px)';
  el.style.transition = 'opacity .5s ease, transform .5s ease';
});
const io = new IntersectionObserver(entries => {
  entries.forEach((e, i) => {
    if (e.isIntersecting) {
      setTimeout(() => { e.target.style.opacity = '1'; e.target.style.transform = 'none'; }, i * 60);
      io.unobserve(e.target);
    }
  });
}, { threshold: 0.1 });
fadeEls.forEach(el => io.observe(el));