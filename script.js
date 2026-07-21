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
  var form = document.getElementById('hero-form-el');
  var tel = document.getElementById('hf-tel');
  var modal = document.getElementById('modal-overlay');
  var modalClose = document.getElementById('modal-close');
  if (!form) return;

  if (tel) {
    tel.addEventListener('input', function() {
      var v = tel.value.replace(/\D/g, '').slice(0, 11);
      if (v.length >= 7) v = '(' + v.slice(0,2) + ') ' + v.slice(2,7) + '-' + v.slice(7);
      else if (v.length >= 3) v = '(' + v.slice(0,2) + ') ' + v.slice(2);
      else if (v.length) v = '(' + v;
      tel.value = v;
    });
  }

  form.addEventListener('submit', function(e) {
    e.preventDefault();

    var keys = [
      'e3f46224-139f-4764-8608-9b424a80d934',
      'bc6005a5-4631-4432-b20f-58b1b3fe0a76',
      '5b05bb2e-1260-476b-9a11-205f18a00976',
      '038cfd33-9db4-49e6-a125-e84c3361b40d'
    ];

    var btn = form.querySelector('button[type="submit"]');
    if (btn) { btn.disabled = true; btn.textContent = 'Enviando...'; }

    var requests = keys.map(function(key) {
      var fd = new FormData(form);
      fd.set('access_key', key);
      return fetch('https://api.web3forms.com/submit', {
        method: 'POST',
        body: fd
      }).then(function(r) { return r.json(); });
    });

    Promise.all(requests).then(function(results) {
      var success = results.some(function(res) { return res.success; });
      if (btn) { btn.disabled = false; btn.textContent = 'Quero ser manager'; }
      if (success) {
        if (modal) modal.style.display = 'flex';
        form.reset();
      } else {
        alert('Erro ao enviar. Tente novamente.');
      }
    }).catch(function() {
      if (btn) { btn.disabled = false; btn.textContent = 'Quero ser manager'; }
      alert('Erro de conexao. Verifique sua internet e tente novamente.');
    });
  });

  if (modalClose && modal) {
    modalClose.addEventListener('click', function() { modal.style.display = 'none'; });
    modal.addEventListener('click', function(e) {
      if (e.target === modal) modal.style.display = 'none';
    });
  }
})();

(function initMap() {
  var mapEl = document.getElementById('leaflet-map');
  var titulo = document.getElementById('mapa-estado-nome');
  var lista  = document.getElementById('mapa-cidades-lista');
  if (!mapEl || typeof L === 'undefined') return;

  var cidadesData = {
    SC: [
      { nome: 'Balneário Camboriú', lat: -26.9907, lng: -48.6348 },
      { nome: 'Blumenau',           lat: -26.9195, lng: -49.0661 },
      { nome: 'Florianópolis',      lat: -27.5954, lng: -48.5480 },
      { nome: 'Joinville',          lat: -26.3044, lng: -48.8457 }
    ],
    SP: [
      { nome: 'Bauru',                    lat: -22.3247, lng: -49.0660 },
      { nome: 'Campinas',                 lat: -22.9068, lng: -47.0626 },
      { nome: 'Guarulhos',                lat: -23.4538, lng: -46.5333 },
      { nome: 'Ribeirão Preto',           lat: -21.1691, lng: -47.8103 },
      { nome: 'Santo André',              lat: -23.6639, lng: -46.5383 },
      { nome: 'Santos',                   lat: -23.9608, lng: -46.3337 },
      { nome: 'São José do Rio Preto',    lat: -20.8113, lng: -49.3758 },
      { nome: 'São José dos Campos',      lat: -23.1896, lng: -45.8841 },
      { nome: 'São Paulo - Borba Gato',   lat: -23.5600, lng: -46.6900 },
      { nome: 'São Paulo - Vila Mariana', lat: -23.5884, lng: -46.6352 },
      { nome: 'Sorocaba',                 lat: -23.5015, lng: -47.4526 }
    ],
    PA: [
      { nome: 'Belém',        lat: -1.4558,  lng: -48.4902 },
      { nome: 'Parauapebas',  lat: -6.0676,  lng: -49.9015 }
    ],
    MG: [
      { nome: 'Belo Horizonte', lat: -19.9167, lng: -43.9345 },
      { nome: 'Ipatinga',       lat: -19.4681, lng: -42.5378 },
      { nome: 'Uberlândia',     lat: -18.9186, lng: -48.2772 }
    ],
    DF: [{ nome: 'Brasília',     lat: -15.7801, lng: -47.9292 }],
    MS: [
      { nome: 'Campo Grande', lat: -20.4697, lng: -54.6201 },
      { nome: 'Dourados',     lat: -22.2233, lng: -54.8058 }
    ],
    MT: [{ nome: 'Cuiabá',      lat: -15.6014, lng: -56.0979 }],
    PR: [
      { nome: 'Curitiba',  lat: -25.4294, lng: -49.2713 },
      { nome: 'Londrina',  lat: -23.3045, lng: -51.1696 }
    ],
    CE: [{ nome: 'Fortaleza',   lat: -3.7172,  lng: -38.5431 }],
    GO: [{ nome: 'Goiânia',     lat: -16.6869, lng: -49.2648 }],
    AL: [{ nome: 'Maceió',      lat: -9.6658,  lng: -35.7350 }],
    RS: [{ nome: 'Porto Alegre',lat: -30.0277, lng: -51.2287 }],
    RO: [{ nome: 'Porto Velho', lat: -8.7612,  lng: -63.9004 }],
    RJ: [{ nome: 'Rio de Janeiro', lat: -22.9068, lng: -43.1729 }],
    BA: [{ nome: 'Salvador',    lat: -12.9714, lng: -38.5014 }],
    MA: [{ nome: 'São Luís',    lat: -2.5307,  lng: -44.3068 }],
    PI: [{ nome: 'Teresina',    lat: -5.0892,  lng: -42.8019 }],
    ES: [{ nome: 'Vitória',     lat: -20.3155, lng: -40.3128 }]
  };

  var slims = ['dourados','fortaleza','ipatinga','joinville','maceio','parauapebas',
               'salvador','santo andre','teresina','santos'];

  function normalize(s) {
    return s.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
  }
  function getType(c) {
    return slims.includes(normalize(c)) ? 'Slim' : 'Franquia';
  }

  var map = L.map('leaflet-map', {
    center: [-15.0, -52.0], zoom: 4,
    zoomControl: true, scrollWheelZoom: false
  });

  L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_nolabels/{z}/{x}/{y}{r}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/">CARTO</a>',
    subdomains: 'abcd', maxZoom: 19
  }).addTo(map);

  function makeIcon(color) {
    return L.divIcon({
      className: '',
      html: '<div style="width:12px;height:12px;border-radius:50%;background:' + color + ';border:2px solid rgba(255,255,255,0.6);box-shadow:0 0 8px ' + color + '"></div>',
      iconSize: [12, 12], iconAnchor: [6, 6], popupAnchor: [0, -8]
    });
  }
  var iconFranquia = makeIcon('#9be15d');
  var iconSlim     = makeIcon('#50b4e6');

  var styleNormal  = { fillColor:'#1a201a', fillOpacity:1, color:'#2a342a', weight:1.5 };
  var styleHasCity = { fillColor:'rgba(155,225,93,0.18)', fillOpacity:1, color:'#9be15d', weight:1.5 };
  var styleActive  = { fillColor:'rgba(155,225,93,0.45)', fillOpacity:1, color:'#9be15d', weight:2.5 };
  var styleHover   = { fillColor:'rgba(155,225,93,0.30)', fillOpacity:1, color:'#9be15d', weight:2 };

  var activeLayer = null;

  function showPanel(uf, name) {
    titulo.textContent = name;
    lista.innerHTML = '';
    var cities = cidadesData[uf];
    if (cities && cities.length) {
      cities.forEach(function(c) {
        var li = document.createElement('li');
        var t = getType(c.nome);
        var dotColor = t === 'Slim' ? '#50b4e6' : '#9be15d';
        li.style.display = 'flex';
        li.style.alignItems = 'center';
        var dot = document.createElement('span');
        dot.style.cssText = 'display:inline-block;width:8px;height:8px;border-radius:50%;background:' + dotColor + ';margin-right:8px;flex-shrink:0;box-shadow:0 0 5px ' + dotColor;
        var nome = document.createElement('span');
        nome.textContent = c.nome;
        var tipo = document.createElement('span');
        tipo.className = 'city-type';
        tipo.style.color = dotColor;
        tipo.textContent = ' — ' + t;
        li.appendChild(dot);
        li.appendChild(nome);
        li.appendChild(tipo);
        lista.appendChild(li);
      });
          } else {
        var li = document.createElement('li');
        li.className = 'mapa-vazio';
        li.style.cssText = 'display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 14px; padding: 24px 10px; text-align: center; width: 100%; box-sizing: border-box;';
        
        var text = document.createElement('span');
        text.className = 'mapa-hint';
        text.style.cssText = 'font-size: 13.5px; color: var(--text-dim); font-style: italic;';
        text.textContent = 'Nenhuma unidade ativa neste estado.';
        
        var btn = document.createElement('a');
        btn.href = '#hero';
        btn.className = 'btn-primary';
        btn.style.cssText = 'font-size: 12.5px; padding: 10px 18px; width: auto; justify-content: center; margin-top: 4px; box-shadow: 0 8px 24px -6px rgba(155,225,93,0.5); display: inline-flex; align-items: center; gap: 8px; border-radius: var(--radius-pill); cursor: pointer; text-decoration: none; font-weight: 700; color: var(--green-dark); background: var(--green); transition: transform 0.2s, box-shadow 0.2s;';
        btn.innerHTML = 'Seja o primeiro <svg viewBox="0 0 24 24" style="width:12px;height:12px;fill:none;stroke:currentColor;stroke-width:2.5;"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>';
        
        btn.addEventListener('click', function(e) {
          e.preventDefault();
          var targetEl = document.getElementById('hero');
          if (targetEl) {
            targetEl.scrollIntoView({ behavior: 'smooth', block: 'start' });
            var cityInput = document.getElementsByName('Cidade')[0];
            if (cityInput) {
              cityInput.value = '';
              cityInput.placeholder = 'Sua cidade em ' + name;
              setTimeout(function() { cityInput.focus(); }, 800);
            }
          }
        });

        li.appendChild(text);
        li.appendChild(btn);
        lista.appendChild(li);
      }
  }

  fetch('https://raw.githubusercontent.com/giuliano-macedo/geodata-br-states/main/geojson/br_states.json')
    .then(function(r) { return r.json(); })
    .then(function(data) {
      L.geoJSON(data, {
        style: function(feature) {
          return cidadesData[feature.id] ? styleHasCity : styleNormal;
        },
        onEachFeature: function(feature, layer) {
          var uf   = feature.id;
          var name = feature.properties.name || feature.id;
          layer.on('mouseover', function() { if (layer !== activeLayer) layer.setStyle(styleHover); });
          layer.on('mouseout',  function() { if (layer !== activeLayer) layer.setStyle(cidadesData[uf] ? styleHasCity : styleNormal); });
          layer.on('click', function() {
            if (activeLayer) {
              var prevUF = activeLayer.feature.id;
              activeLayer.setStyle(cidadesData[prevUF] ? styleHasCity : styleNormal);
            }
            layer.setStyle(styleActive);
            activeLayer = layer;
            showPanel(uf, name);
          });
        }
      }).addTo(map);

      Object.entries(cidadesData).forEach(function(entry) {
        var uf = entry[0];
        var cities = entry[1];
        cities.forEach(function(c) {
          var isSlim = slims.includes(normalize(c.nome));
          var icon = isSlim ? iconSlim : iconFranquia;
          var label = isSlim ? 'Slim' : 'Franquia';
          L.marker([c.lat, c.lng], { icon: icon })
            .bindPopup(
              '<div style="font-family:Inter,sans-serif;font-size:13px;line-height:1.5">' +
              '<strong style="color:#f7f9f6">' + c.nome + '</strong><br>' +
              '<span style="color:' + (isSlim ? '#50b4e6' : '#9be15d') + ';font-size:11px;font-weight:600">' + label + '</span>' +
              '</div>',
              { className: 'insp-popup' }
            )
            .addTo(map);
        });
      });
    })
    .catch(function() {
      mapEl.innerHTML = '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#9aa39a;font-size:14px">Mapa indisponível offline</div>';
    });

  var legend = L.control({ position: 'bottomleft' });
  legend.onAdd = function() {
    var d = L.DomUtil.create('div', 'map-legend');
    d.innerHTML =
      '<span style="display:inline-block;width:10px;height:10px;border-radius:50%;background:#9be15d;margin-right:6px;box-shadow:0 0 6px #9be15d"></span>Franquia' +
      '<br>' +
      '<span style="display:inline-block;width:10px;height:10px;border-radius:50%;background:#50b4e6;margin-right:6px;box-shadow:0 0 6px #50b4e6;margin-top:6px"></span>Slim';
    return d;
  };
  legend.addTo(map);
})();



(function initTestimonialsToggle() {
  var cards = document.querySelectorAll('.dep-card');
  cards.forEach(function(card) {
    var author = card.querySelector('.dep-author');
    var curriculo = card.querySelector('.dep-curriculo');
    var btn = card.querySelector('.curr-toggle-btn');
    if (!author || !curriculo || !btn) return;

    author.addEventListener('click', function() {
      var isActive = curriculo.classList.contains('active');
      
      // Fecha os outros minicurrículos abertos para manter o visual limpo
      cards.forEach(function(c) {
        var otherCurr = c.querySelector('.dep-curriculo');
        var otherBtn = c.querySelector('.curr-toggle-btn');
        if (otherCurr && otherCurr !== curriculo) {
          otherCurr.classList.remove('active');
          if (otherBtn) otherBtn.textContent = 'Ver minicurrículo ▾';
        }
      });

      if (isActive) {
        curriculo.classList.remove('active');
        btn.textContent = 'Ver minicurrículo ▾';
      } else {
        curriculo.classList.add('active');
        btn.textContent = 'Ocultar minicurrículo ▴';
      }
    });
  });
})();