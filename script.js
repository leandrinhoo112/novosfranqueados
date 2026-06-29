// ===== NAVBAR SCROLL =====
const navbar = document.getElementById('navbar');
const floatingCta = document.getElementById('floating-cta');

window.addEventListener('scroll', () => {
  if (window.scrollY > 80) {
    navbar.classList.add('scrolled');
    floatingCta.classList.add('visible');
  } else {
    navbar.classList.remove('scrolled');
    floatingCta.classList.remove('visible');
  }
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
    accordionTriggers.forEach(t => {
      t.setAttribute('aria-expanded', 'false');
      const c = document.getElementById(t.getAttribute('aria-controls'));
      if (c) c.classList.remove('open');
    });
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
      navItems.forEach(item => { item.style.color = ''; });
      const activeLink = document.querySelector('.nav-links a[href="#' + entry.target.id + '"]');
      if (activeLink) activeLink.style.color = 'var(--blue)';
    }
  });
}, { threshold: 0.3 });
sections.forEach(section => sectionObserver.observe(section));

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
    const investimento = document.getElementById('input-investimento').value;
    const cidade = document.getElementById('input-cidade').value.trim();
    const termos = document.getElementById('input-termos').checked;
    if (!nome || !email || !telefone || !investimento || !cidade) {
      alert('Por favor, preencha todos os campos obrigat\u00f3rios.');
      return;
    }
    if (!termos) {
      alert('Por favor, aceite a Pol\u00edtica de Privacidade para continuar.');
      return;
    }
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

console.log('Faculdade Inspirar - Site de Franquias carregado!');
