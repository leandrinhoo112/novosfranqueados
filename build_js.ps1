$p = "C:\Users\Usuario\.gemini\antigravity\playground\polar-newton\franquias-inspirar"
$js = [System.Text.StringBuilder]::new()

[void]$js.AppendLine(@"
// ===== NAVBAR SCROLL =====
const navbar = document.getElementById('navbar');
const floatingCta = document.getElementById('floating-cta');
let lastScrollY = 0;

window.addEventListener('scroll', () => {
  const currentScrollY = window.scrollY;
  if (currentScrollY > 80) {
    navbar.classList.add('scrolled');
    floatingCta.classList.add('visible');
  } else {
    navbar.classList.remove('scrolled');
    floatingCta.classList.remove('visible');
  }
  lastScrollY = currentScrollY;
});

// ===== HAMBURGER =====
const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('nav-links');
hamburger.addEventListener('click', () => {
  const isOpen = navLinks.classList.toggle('open');
  hamburger.classList.toggle('open');
  hamburger.setAttribute('aria-expanded', isOpen.toString());
});
navLinks.querySelectorAll('a').forEach(link => {
  link.addEventListener('click', () => {
    navLinks.classList.remove('open');
    hamburger.classList.remove('open');
    hamburger.setAttribute('aria-expanded', 'false');
  });
});
document.addEventListener('click', (e) => {
  if (!navbar.contains(e.target)) {
    navLinks.classList.remove('open');
    hamburger.classList.remove('open');
    hamburger.setAttribute('aria-expanded', 'false');
  }
});

// ===== ACCORDION / FAQ =====
const accordionTriggers = document.querySelectorAll('.accordion-trigger');
accordionTriggers.forEach(trigger => {
  trigger.addEventListener('click', () => {
    const content = document.getElementById(trigger.getAttribute('aria-controls'));
    const isExpanded = trigger.getAttribute('aria-expanded') === 'true';
    // Close all
    accordionTriggers.forEach(t => {
      t.setAttribute('aria-expanded', 'false');
      const c = document.getElementById(t.getAttribute('aria-controls'));
      if (c) c.classList.remove('open');
    });
    // Open clicked if it was closed
    if (!isExpanded) {
      trigger.setAttribute('aria-expanded', 'true');
      if (content) content.classList.add('open');
    }
  });
});

// ===== FADE UP ANIMATIONS =====
const fadeElements = document.querySelectorAll('.bento-card, .plan-card, .testimonial-card, .step-item, .accordion-item, .sobre-badges, .hero-stat, .logo-wall-item, .contato-feature');
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('fade-up', 'visible');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });
fadeElements.forEach((el, i) => {
  el.classList.add('fade-up');
  el.style.transitionDelay = (i % 5) * 0.08 + 's';
  observer.observe(el);
});

// ===== SMOOTH ACTIVE NAV =====
const sections = document.querySelectorAll('section[id]');
const navItems = document.querySelectorAll('.nav-links a');
const sectionObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      navItems.forEach(item => {
        item.style.color = '';
        item.style.background = '';
      });
      const activeLink = document.querySelector('.nav-links a[href="#' + entry.target.id + '"]');
      if (activeLink) {
        activeLink.style.color = 'var(--blue)';
      }
    }
  });
}, { threshold: 0.3 });
sections.forEach(section => sectionObserver.observe(section));

// ===== COUNTER ANIMATION =====
function animateCounter(el, target, suffix) {
  let current = 0;
  const step = Math.ceil(target / 50);
  const timer = setInterval(() => {
    current += step;
    if (current >= target) { current = target; clearInterval(timer); }
    el.textContent = current + suffix;
  }, 40);
}
const counterObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const target = parseInt(entry.target.dataset.target);
      if (!isNaN(target)) {
        animateCounter(entry.target, target, '+');
      }
      counterObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.5 });
document.querySelectorAll('[data-target]').forEach(el => counterObserver.observe(el));

// ===== FORM SUBMIT =====
const form = document.getElementById('contato-form');
const modalOverlay = document.getElementById('modal-overlay');
const modalClose = document.getElementById('modal-close');

if (form) {
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const nome = document.getElementById('input-nome').value.trim();
    const email = document.getElementById('input-email').value.trim();
    const telefone = document.getElementById('input-telefone').value.trim();
    const cidade = document.getElementById('input-cidade').value.trim();
    const termos = document.getElementById('input-termos').checked;
    
    if (!nome || !email || !telefone || !cidade) {
      alert('Por favor, preencha todos os campos obrigatorios.');
      return;
    }
    if (!termos) {
      alert('Por favor, aceite a Politica de Privacidade para continuar.');
      return;
    }
    // Show success modal
    if (modalOverlay) {
      modalOverlay.style.display = 'flex';
      document.body.style.overflow = 'hidden';
    }
    form.reset();
  });
}

if (modalClose) {
  modalClose.addEventListener('click', () => {
    modalOverlay.style.display = 'none';
    document.body.style.overflow = '';
  });
}
if (modalOverlay) {
  modalOverlay.addEventListener('click', (e) => {
    if (e.target === modalOverlay) {
      modalOverlay.style.display = 'none';
      document.body.style.overflow = '';
    }
  });
}

// ===== PLAN BUTTONS SET MODELO =====
document.querySelectorAll('[id^="btn-plan-"]').forEach(btn => {
  btn.addEventListener('click', (e) => {
    const modeloMap = { 'btn-plan-polo': 'polo-ead', 'btn-plan-unidade': 'unidade-presencial', 'btn-plan-semi': 'semipresencial' };
    const select = document.getElementById('input-modelo');
    if (select && modeloMap[btn.id]) select.value = modeloMap[btn.id];
  });
});

// ===== LOGO WALL AUTO SCROLL (CSS approach backup) =====
console.log('Faculdade Inspirar - Site de Franquias carregado com sucesso!');
"@)

[System.IO.File]::WriteAllText("$p\script.js", $js.ToString(), [System.Text.Encoding]::UTF8)
Write-Host "JS written: $([System.IO.File]::ReadAllBytes("$p\script.js").Length) bytes"
