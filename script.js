(function initNavbar() {
  const navbar = document.querySelector('.navbar__inner');
  if (!navbar) return;
  window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 40);
  }, { passive: true });
})();

(function initSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const id = a.getAttribute('href').slice(1);
      const el = document.getElementById(id);
      if (el) { e.preventDefault(); el.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
    });
  });
})();

(function initReveal() {
  const els = document.querySelectorAll('[data-reveal]');
  if (!els.length) return;
  const io = new IntersectionObserver(entries => {
    entries.forEach((entry, i) => {
      if (entry.isIntersecting) {
        setTimeout(() => entry.target.classList.add('revealed'), i * 80);
        io.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });
  els.forEach(el => io.observe(el));
})();

(function initFixedBar() {
  const bar = document.getElementById('fixed-bar');
  const spacer = document.getElementById('fixed-bar-spacer');
  if (!bar) return;
  const hero = document.querySelector('.hero-section');
  function update() {
    const show = hero ? hero.getBoundingClientRect().bottom < 0 : window.scrollY > 100;
    bar.classList.toggle('visible', show);
    if (spacer) spacer.style.height = show ? bar.offsetHeight + 'px' : '0';
  }
  window.addEventListener('scroll', update, { passive: true });
  update();
})();

(function initForm() {
  const form = document.getElementById('hero-form-el');
  const tel = document.getElementById('hf-tel');
  const modal = document.getElementById('modal-overlay');
  const modalClose = document.getElementById('modal-close');
  if (!form) return;

  if (tel) {
    tel.addEventListener('input', () => {
      let v = tel.value.replace(/\D/g, '').slice(0, 11);
      if (v.length >= 7) v = '(' + v.slice(0,2) + ') ' + v.slice(2,7) + '-' + v.slice(7);
      else if (v.length >= 3) v = '(' + v.slice(0,2) + ') ' + v.slice(2);
      else if (v.length) v = '(' + v;
      tel.value = v;
    });
  }
  form.addEventListener('submit', e => {
    e.preventDefault();
    if (modal) modal.style.display = 'flex';
    form.reset();
  });
  if (modalClose && modal) {
    modalClose.addEventListener('click', () => modal.style.display = 'none');
    modal.addEventListener('click', e => { if (e.target === modal) modal.style.display = 'none'; });
  }
})();

(function initMap() {
  const statePaths = document.querySelectorAll('.state-path');
  const titulo = document.getElementById('mapa-estado-nome');
  const lista = document.getElementById('mapa-cidades-lista');
  if (!statePaths.length) return;

  const cidades = {
    SC: ['Balneário Camboriú','Blumenau','Florianópolis','Joinville'],
    SP: ['Bauru','Campinas','Guarulhos','Ribeirão Preto','Santo André','Santos','São José do Rio Preto','São José dos Campos','São Paulo - Borba Gato','São Paulo - Vila Mariana','Sorocaba'],
    PA: ['Belém','Parauapebas'],
    MG: ['Belo Horizonte','Ipatinga','Uberlândia'],
    DF: ['Brasília'],
    MS: ['Campo Grande','Dourados'],
    MT: ['Cuiabá'], PR: ['Curitiba','Londrina'],
    CE: ['Fortaleza'], GO: ['Goiânia'], AL: ['Maceió'],
    RS: ['Porto Alegre'], RO: ['Porto Velho'], RJ: ['Rio de Janeiro'],
    BA: ['Salvador'], MA: ['São Luís'], PI: ['Teresina'], ES: ['Vitória']
  };
  const slims = ['dourados','fortaleza','ipatinga','joinville','maceio','maceió','parauapebas','salvador','santo andre','santo andré','teresina','santos'];

  function normalize(s) { return s.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g,""); }
  function getType(city) { return slims.includes(normalize(city)) ? 'Licença Slim' : 'Franquia'; }

  statePaths.forEach(path => {
    const uf = path.getAttribute('data-uf');
    if (cidades[uf]) path.classList.add('has-city');

    path.addEventListener('click', () => {
      statePaths.forEach(p => p.classList.remove('active'));
      path.classList.add('active');
      titulo.textContent = path.getAttribute('data-name') || uf;
      lista.innerHTML = '';
      const list = cidades[uf];
      if (list && list.length) {
        list.forEach(c => {
          const li = document.createElement('li');
          li.textContent = c;
          const span = document.createElement('span');
          span.className = 'city-type';
          span.textContent = ' — ' + getType(c);
          li.appendChild(span);
          lista.appendChild(li);
        });
      } else {
        const li = document.createElement('li');
        li.className = 'mapa-hint';
        li.textContent = 'Nenhuma unidade ainda — seja o primeiro!';
        lista.appendChild(li);
      }
    });
  });
})();