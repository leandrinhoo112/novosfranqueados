$p = "C:\Users\Usuario\.gemini\antigravity\playground\polar-newton\franquias-inspirar"
$css = [System.Text.StringBuilder]::new()

[void]$css.AppendLine(@"
/* ===== FONTE AMPLE SOFT PRO ===== */
@font-face{font-family:'AmpleSoftPro';src:url('ample-soft-pro/AmpleSoftPro-Thin.woff2') format('woff2'),url('ample-soft-pro/AmpleSoftPro-Thin.ttf') format('truetype');font-weight:100;font-display:swap}
@font-face{font-family:'AmpleSoftPro';src:url('ample-soft-pro/AmpleSoftPro-Light.woff2') format('woff2'),url('ample-soft-pro/AmpleSoftPro-Light.ttf') format('truetype');font-weight:300;font-display:swap}
@font-face{font-family:'AmpleSoftPro';src:url('ample-soft-pro/AmpleSoftPro-Regular.woff2') format('woff2'),url('ample-soft-pro/AmpleSoftPro-Regular.ttf') format('truetype');font-weight:400;font-display:swap}
@font-face{font-family:'AmpleSoftPro';src:url('ample-soft-pro/AmpleSoftPro-Medium.woff2') format('woff2'),url('ample-soft-pro/AmpleSoftPro-Medium.ttf') format('truetype');font-weight:500;font-display:swap}
@font-face{font-family:'AmpleSoftPro';src:url('ample-soft-pro/AmpleSoftPro-Bold.woff2') format('woff2'),url('ample-soft-pro/AmpleSoftPro-Bold.ttf') format('truetype');font-weight:700;font-display:swap}

/* ===== VARIABLES ===== */
:root{
  --blue:#02a8e7;--blue-dark:#0189c4;--blue-light:#33bbf0;
  --blue-glow:rgba(2,168,231,0.3);--blue-subtle:rgba(2,168,231,0.08);
  --black:#0a0a0a;--black-soft:#111111;--black-border:#222222;
  --gray-dark:#2a2a2a;--gray-mid:#555555;--gray-light:#888888;--gray-lighter:#bbbbbb;
  --white:#ffffff;--white-soft:#f8f8f8;
  --font:'AmpleSoftPro','Outfit',sans-serif;
  --radius-sm:8px;--radius-md:16px;--radius-lg:24px;--radius-xl:32px;--radius-pill:999px;
  --shadow-sm:0 2px 8px rgba(0,0,0,0.12);--shadow-md:0 8px 32px rgba(0,0,0,0.16);
  --shadow-lg:0 20px 60px rgba(0,0,0,0.22);--shadow-blue:0 8px 32px rgba(2,168,231,0.25);
  --transition:0.3s cubic-bezier(0.4,0,0.2,1);--topbar-h:64px;
}

/* ===== RESET ===== */
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth;font-size:16px}
body{font-family:var(--font);background:var(--white);color:var(--black);overflow-x:hidden;line-height:1.6}
img{max-width:100%;height:auto;display:block}
a{text-decoration:none;color:inherit}
ul{list-style:none}
button{border:none;cursor:pointer;font-family:inherit}
input,select,textarea{font-family:inherit}

/* ===== UTILITIES ===== */
.container{max-width:1200px;margin:0 auto;padding:0 24px}
.section-eyebrow{display:inline-block;font-family:var(--font);font-size:0.75rem;font-weight:700;letter-spacing:0.15em;text-transform:uppercase;color:var(--blue);margin-bottom:12px}
.eyebrow-light{color:var(--blue-light)}
.section-title{font-family:var(--font);font-size:clamp(1.8rem,3.5vw,2.8rem);font-weight:700;line-height:1.15;color:var(--black);margin-bottom:16px}
.title-light{color:var(--white)}
.section-subtitle{font-size:1.05rem;color:var(--gray-mid);max-width:560px;line-height:1.7}
.section-header{text-align:center;margin-bottom:56px}
.section-header .section-subtitle{margin:0 auto}
.gradient-text{background:linear-gradient(135deg,var(--blue),#00d4ff,var(--blue));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}

/* ===== BUTTONS ===== */
.btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;font-family:var(--font);font-weight:700;font-size:0.95rem;padding:12px 28px;border-radius:var(--radius-pill);transition:var(--transition);letter-spacing:0.02em;white-space:nowrap;cursor:pointer}
.btn-primary{background:linear-gradient(135deg,var(--blue),var(--blue-dark));color:var(--white);border:2px solid transparent;box-shadow:var(--shadow-blue)}
.btn-primary:hover{background:linear-gradient(135deg,var(--blue-light),var(--blue));transform:translateY(-2px);box-shadow:0 12px 40px rgba(2,168,231,0.4)}
.btn-outline{background:transparent;color:var(--blue);border:2px solid var(--blue)}
.btn-outline:hover{background:var(--blue-subtle);transform:translateY(-2px)}
.btn-white{background:var(--white);color:var(--black);border:2px solid transparent}
.btn-white:hover{background:rgba(255,255,255,0.9);transform:translateY(-2px)}
.btn-lg{padding:16px 36px;font-size:1.05rem}
.btn-sm{padding:8px 20px;font-size:0.85rem}
.btn-full{width:100%}
.btn-arrow{font-size:1.1em;transition:transform var(--transition)}
.btn:hover .btn-arrow{transform:translateX(4px)}

/* ===== TOPBAR ===== */
.topbar{position:fixed;top:0;left:0;right:0;z-index:1000;height:var(--topbar-h);background:var(--black);border-bottom:1px solid rgba(255,255,255,0.08);transition:var(--transition)}
.topbar.scrolled{box-shadow:var(--shadow-md)}
.topbar-inner{max-width:1200px;margin:0 auto;padding:0 24px;height:100%;display:flex;align-items:center;justify-content:space-between}
.topbar-logo{height:36px;width:auto;object-fit:contain}

/* ===== HERO ===== */
.hero{position:relative;min-height:100vh;display:flex;align-items:center;padding-top:var(--topbar-h);overflow:hidden}
.hero-bg{position:absolute;inset:0}
.hero-img{width:100%;height:100%;object-fit:cover;object-position:center}
.hero-overlay{position:absolute;inset:0;background:linear-gradient(135deg,rgba(0,0,0,0.87) 0%,rgba(0,0,0,0.55) 55%,rgba(2,168,231,0.12) 100%)}
.hero-content{position:relative;z-index:1;padding:60px 40px 80px;max-width:800px;margin:0 auto 0 5vw}
.hero-tags{display:flex;flex-wrap:wrap;gap:10px;margin-bottom:28px}
.tag{display:inline-flex;align-items:center;gap:6px;padding:6px 16px;border-radius:var(--radius-pill);font-family:var(--font);font-size:0.8rem;font-weight:600}
.tag-blue{background:rgba(2,168,231,0.2);color:var(--blue-light);border:1px solid rgba(2,168,231,0.3);backdrop-filter:blur(8px)}
.tag-dark{background:rgba(255,255,255,0.1);color:rgba(255,255,255,0.85);border:1px solid rgba(255,255,255,0.15);backdrop-filter:blur(8px)}
.hero-title{font-family:var(--font);font-size:clamp(2.2rem,5vw,4rem);font-weight:700;line-height:1.1;color:var(--white);margin-bottom:20px;letter-spacing:-0.01em}
.hero-subtitle{font-size:clamp(1rem,1.5vw,1.15rem);color:rgba(255,255,255,0.75);max-width:560px;line-height:1.75;margin-bottom:40px}
.hero-stats{display:flex;flex-wrap:wrap;align-items:center;margin-bottom:40px;background:rgba(255,255,255,0.05);backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,0.1);border-radius:var(--radius-lg);padding:20px 28px;width:fit-content;gap:0}
.hero-stat{display:flex;flex-direction:column;align-items:center;text-align:center;padding:0 24px}
.hero-stat-divider{width:1px;height:44px;background:rgba(255,255,255,0.15)}
.stat-number{font-family:var(--font);font-size:1.8rem;font-weight:700;color:var(--white);line-height:1}
.stat-plus{color:var(--blue)}
.stat-label{font-size:0.72rem;color:rgba(255,255,255,0.6);margin-top:4px;max-width:72px;line-height:1.3}
.hero-cta{margin-top:8px}
.hero-scroll-indicator{position:absolute;bottom:28px;left:50%;transform:translateX(-50%)}
.scroll-dot{width:24px;height:40px;border:2px solid rgba(255,255,255,0.3);border-radius:12px;position:relative}
.scroll-dot::after{content:'';position:absolute;top:6px;left:50%;transform:translateX(-50%);width:4px;height:8px;background:var(--blue);border-radius:2px;animation:scrollBounce 2s infinite}
@keyframes scrollBounce{0%,100%{transform:translateX(-50%) translateY(0);opacity:1}70%{transform:translateX(-50%) translateY(12px);opacity:0}}

/* ===== KOP SECTIONS (2 colunas alternadas) ===== */
.kop-section{padding:0}
.kop-row{display:grid;grid-template-columns:1fr 1fr;min-height:520px}
.kop-row-reverse{direction:rtl}
.kop-row-reverse>*{direction:ltr}
.kop-col-img{overflow:hidden}
.kop-side-img{width:100%;height:100%;object-fit:cover;object-position:center top;display:block}
.kop-col-text{display:flex;flex-direction:column;justify-content:center;padding:64px 56px}
.kop-about .kop-col-text{background:var(--white-soft)}
.kop-support .kop-col-text{background:var(--black)}
.kop-text{font-size:1rem;color:var(--gray-mid);line-height:1.8;margin-bottom:14px}
.kop-text-light{color:rgba(255,255,255,0.65)}
.kop-badges{display:flex;flex-wrap:wrap;gap:8px;margin:20px 0 28px}
.badge{display:inline-flex;align-items:center;gap:6px;padding:7px 14px;border-radius:var(--radius-pill);font-family:var(--font);font-size:0.82rem;font-weight:600;background:var(--blue-subtle);color:var(--blue);border:1px solid rgba(2,168,231,0.2);transition:var(--transition)}
.badge:hover{background:var(--blue);color:var(--white)}
.kop-checklist{display:flex;flex-direction:column;gap:12px;margin:20px 0 28px}
.kop-checklist li{display:flex;align-items:center;gap:12px;font-size:0.97rem;color:rgba(255,255,255,0.8)}
.kop-check{color:var(--blue);font-weight:700;font-size:1.1rem;flex-shrink:0}

/* ===== STATS BAR ===== */
.stats-bar{background:var(--blue);padding:32px 24px}
.stats-bar-inner{max-width:1100px;margin:0 auto;display:flex;align-items:center;justify-content:center;flex-wrap:wrap;gap:0}
.stat-item{display:flex;flex-direction:column;align-items:center;text-align:center;padding:0 36px}
.stat-bar-div{width:1px;height:52px;background:rgba(255,255,255,0.25)}
.sbi-number{font-family:var(--font);font-size:2.2rem;font-weight:700;color:var(--white);line-height:1}
.sbi-plus{color:rgba(255,255,255,0.7);font-size:1.4rem}
.sbi-unit{font-size:1rem;color:rgba(255,255,255,0.7);margin-left:2px}
.sbi-label{font-size:0.8rem;color:rgba(255,255,255,0.75);margin-top:4px;font-weight:500;letter-spacing:0.03em}

/* ===== BENTO GRID ===== */
.diferenciais{padding:100px 0;background:var(--white-soft)}
.bento-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px}
.bento-card{background:var(--white);border:1px solid rgba(0,0,0,0.07);border-radius:var(--radius-xl);padding:28px;transition:var(--transition);position:relative;overflow:hidden}
.bento-card:hover{border-color:rgba(2,168,231,0.25);box-shadow:0 8px 32px rgba(2,168,231,0.1);transform:translateY(-3px)}
.bento-large{grid-column:span 2;grid-row:span 2;min-height:280px}
.bento-tall{grid-column:span 1;grid-row:span 2}
.bento-wide{grid-column:span 2;grid-row:span 1}
.bento-medium{grid-column:span 1;grid-row:span 1}
.bento-blue{background:linear-gradient(135deg,var(--blue),var(--blue-dark));border-color:transparent}
.bento-blue h3{color:var(--white)}
.bento-blue p{color:rgba(255,255,255,0.85)}
.bento-card-dark{background:#0a0a0a !important;border-color:rgba(2,168,231,0.3) !important}
.bento-card-dark h3{color:#ffffff !important}
.bento-card-dark p{color:rgba(255,255,255,0.8) !important}
.bento-card-dark:hover{background:#111 !important}
.bento-icon{font-size:2rem;margin-bottom:16px}
.bento-card h3{font-family:var(--font);font-size:1.15rem;font-weight:700;color:var(--black);margin-bottom:10px;line-height:1.3}
.bento-card p{font-size:0.92rem;color:var(--gray-mid);line-height:1.6}
.bento-list{margin-top:16px;display:flex;flex-direction:column;gap:8px}
.bento-list li{font-size:0.88rem;font-weight:500;color:var(--gray-mid)}
.bento-tags{display:flex;flex-wrap:wrap;gap:6px;margin-top:14px}
.mini-tag{padding:4px 10px;border-radius:var(--radius-pill);font-size:0.75rem;font-weight:600;background:var(--blue-subtle);color:var(--blue);border:1px solid rgba(2,168,231,0.15)}
.bento-metric{margin-top:20px}
.metric-number{display:block;font-family:var(--font);font-size:2.8rem;font-weight:700;color:var(--white);line-height:1}
.metric-label{font-size:0.85rem;color:rgba(255,255,255,0.75);font-weight:500}
.bento-cities{display:flex;flex-wrap:wrap;gap:8px;margin-top:16px}
.bento-cities span{padding:4px 12px;background:var(--blue-subtle);border-radius:var(--radius-pill);font-size:0.8rem;font-weight:600;color:var(--blue);border:1px solid rgba(2,168,231,0.15)}

/* ===== STEPS HORIZONTAL ===== */
.como-funciona{padding:100px 0;background:var(--black);position:relative;overflow:hidden}
.como-funciona::before{content:'';position:absolute;top:-200px;right:-200px;width:600px;height:600px;background:radial-gradient(circle,rgba(2,168,231,0.07) 0%,transparent 70%)}
.como-funciona .section-eyebrow{color:var(--blue)}
.como-funciona .section-title{color:var(--white)}
.steps-horizontal{display:flex;align-items:flex-start;justify-content:center;gap:0;margin-top:8px}
.step-h{display:flex;flex-direction:column;align-items:center;text-align:center;max-width:168px;flex:1}
.step-h-number{font-family:var(--font);font-size:2.4rem;font-weight:700;color:var(--blue);opacity:0.35;line-height:1;margin-bottom:10px}
.step-h:hover .step-h-number{opacity:1}
.step-h-icon{font-size:2rem;margin-bottom:14px}
.step-h-title{font-family:var(--font);font-size:0.95rem;font-weight:700;color:var(--white);margin-bottom:8px;line-height:1.3}
.step-h-text{font-size:0.82rem;color:rgba(255,255,255,0.5);line-height:1.6}
.step-h-connector{flex:0 0 auto;display:flex;align-items:flex-start;padding-top:54px}
.step-h-line{width:40px;height:2px;background:linear-gradient(to right,var(--blue),rgba(2,168,231,0.2))}

/* ===== TESTIMONIALS (3 colunas) ===== */
.depoimentos{padding:100px 0;background:var(--white-soft)}
.testimonials-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px}
.testimonial-card{background:var(--white);border:1px solid rgba(0,0,0,0.07);border-radius:var(--radius-xl);padding:32px;transition:var(--transition);display:flex;flex-direction:column;justify-content:space-between}
.testimonial-card:hover{border-color:rgba(2,168,231,0.2);box-shadow:0 8px 32px rgba(2,168,231,0.08);transform:translateY(-2px)}
.testimonial-featured{background:linear-gradient(135deg,var(--black),#111);border-color:rgba(2,168,231,0.2)}
.testimonial-quote{font-family:Georgia,serif;font-size:4rem;line-height:0.8;color:var(--blue);opacity:0.35;margin-bottom:14px}
.testimonial-featured .testimonial-quote{opacity:0.6}
.testimonial-text{font-size:0.95rem;color:var(--gray-mid);line-height:1.75;margin-bottom:24px;flex:1}
.testimonial-featured .testimonial-text{color:rgba(255,255,255,0.75)}
.testimonial-author{display:flex;align-items:center;gap:14px}
.avatar{width:48px;height:48px;border-radius:50%;object-fit:cover;border:2px solid var(--blue);flex-shrink:0}
.author-info{display:flex;flex-direction:column;gap:2px}
.author-info strong{font-family:var(--font);font-size:0.95rem;font-weight:700;color:var(--black)}
.testimonial-featured .author-info strong{color:var(--white)}
.author-info span{font-size:0.8rem;color:var(--gray-light)}
.testimonial-featured .author-info span{color:rgba(255,255,255,0.5)}
.stars{color:#FFB800;font-size:0.85rem;margin-top:2px}

/* ===== FAQ ===== */
.faq{padding:100px 0;background:var(--white)}
.faq-layout{display:grid;grid-template-columns:320px 1fr;gap:80px;align-items:start}
.faq-header-col{position:sticky;top:calc(var(--topbar-h) + 24px)}
.faq-desc{font-size:0.95rem;color:var(--gray-mid);line-height:1.7;margin-bottom:28px}
.accordion-item{border-bottom:1px solid rgba(0,0,0,0.08)}
.accordion-trigger{width:100%;display:flex;align-items:center;justify-content:space-between;gap:16px;padding:20px 0;background:none;font-family:var(--font);font-size:1rem;font-weight:700;color:var(--black);cursor:pointer;text-align:left;transition:var(--transition)}
.accordion-trigger:hover{color:var(--blue)}
.accordion-trigger[aria-expanded="true"]{color:var(--blue)}
.accordion-icon{flex-shrink:0;font-size:1.4rem;color:var(--blue);transition:transform var(--transition);width:24px;height:24px;display:flex;align-items:center;justify-content:center}
.accordion-trigger[aria-expanded="true"] .accordion-icon{transform:rotate(45deg)}
.accordion-content{max-height:0;overflow:hidden;transition:max-height 0.4s cubic-bezier(0.4,0,0.2,1)}
.accordion-content.open{max-height:300px}
.accordion-content p{padding:0 0 20px;font-size:0.95rem;color:var(--gray-mid);line-height:1.75}

/* ===== CTA BANNER ===== */
.cta-banner{background:linear-gradient(135deg,var(--blue),var(--blue-dark));padding:64px 24px}
.cta-banner-inner{max-width:1100px;margin:0 auto;display:flex;align-items:center;justify-content:space-between;gap:32px;flex-wrap:wrap}
.cta-banner-title{font-family:var(--font);font-size:clamp(1.5rem,3vw,2.2rem);font-weight:700;color:var(--white);margin-bottom:8px;line-height:1.2}
.cta-banner-sub{font-size:1rem;color:rgba(255,255,255,0.8);line-height:1.6}

/* ===== CONTACT ===== */
.contato{padding:100px 0;background:var(--black);position:relative;overflow:hidden}
.contato-bg{position:absolute;inset:0;background:radial-gradient(ellipse at 30% 50%,rgba(2,168,231,0.1) 0%,transparent 60%)}
.contato-layout{position:relative;z-index:1;display:grid;grid-template-columns:1fr 1fr;gap:64px;align-items:start}
.contato-info .section-title{margin-bottom:16px;max-width:400px}
.contato-desc{font-size:1rem;color:rgba(255,255,255,0.6);line-height:1.75;margin-bottom:40px}
.contato-features{display:flex;flex-direction:column;gap:20px}
.contato-feature{display:flex;align-items:center;gap:16px}
.cf-icon{font-size:1.5rem;width:44px;height:44px;background:rgba(2,168,231,0.1);border:1px solid rgba(2,168,231,0.2);border-radius:var(--radius-md);display:flex;align-items:center;justify-content:center;flex-shrink:0}
.contato-feature strong{font-family:var(--font);font-size:0.95rem;font-weight:700;color:var(--white);display:block}
.contato-feature span{font-size:0.82rem;color:rgba(255,255,255,0.5)}
.contato-form-wrapper{background:var(--white);border-radius:var(--radius-xl);padding:40px;border:1px solid rgba(2,168,231,0.15)}
.form-title{font-family:var(--font);font-size:1.4rem;font-weight:700;color:var(--black);margin-bottom:28px}
.form-group{display:flex;flex-direction:column;gap:6px;margin-bottom:16px}
.form-group label{font-family:var(--font);font-size:0.78rem;font-weight:700;color:var(--gray-mid);text-transform:uppercase;letter-spacing:0.06em}
.form-group input,.form-group select{padding:12px 16px;border:1.5px solid rgba(0,0,0,0.1);border-radius:var(--radius-md);font-family:var(--font);font-size:0.95rem;color:var(--black);background:var(--white-soft);transition:var(--transition);outline:none}
.form-group input:focus,.form-group select:focus{border-color:var(--blue);background:var(--white);box-shadow:0 0 0 3px var(--blue-glow)}
.form-group input::placeholder{color:var(--gray-lighter)}
.form-check{display:flex;align-items:flex-start;gap:10px;margin-bottom:20px}
.form-check input[type="checkbox"]{width:18px;height:18px;margin-top:2px;flex-shrink:0;accent-color:var(--blue);cursor:pointer}
.form-check label{font-size:0.85rem;color:var(--gray-mid);line-height:1.5;cursor:pointer}
.form-check a{color:var(--blue);text-decoration:underline}
.form-disclaimer{text-align:center;font-size:0.8rem;color:var(--gray-lighter);margin-top:12px}

/* ===== FOOTER ===== */
.footer{background:var(--black-soft,#111);border-top:1px solid var(--black-border,#222);padding:60px 0 24px}
.footer-top{display:grid;grid-template-columns:280px 1fr;gap:60px;margin-bottom:48px}
.footer-logo{margin-bottom:14px}
.footer-logo-img-white{height:32px;width:auto;object-fit:contain}
.footer-tagline{font-size:0.9rem;color:rgba(255,255,255,0.4);line-height:1.6;margin-bottom:20px}
.footer-social{display:flex;gap:10px}
.social-link{width:40px;height:40px;background:rgba(255,255,255,0.07);border:1px solid rgba(255,255,255,0.1);border-radius:var(--radius-md);display:flex;align-items:center;justify-content:center;font-size:1.1rem;transition:var(--transition)}
.social-link:hover{background:var(--blue);border-color:var(--blue)}
.footer-links{display:grid;grid-template-columns:repeat(3,1fr);gap:40px}
.footer-col h4{font-family:var(--font);font-size:0.78rem;font-weight:700;letter-spacing:0.12em;text-transform:uppercase;color:rgba(255,255,255,0.35);margin-bottom:16px}
.footer-col ul{display:flex;flex-direction:column;gap:10px}
.footer-col a{font-size:0.9rem;color:rgba(255,255,255,0.55);transition:var(--transition)}
.footer-col a:hover{color:var(--blue)}
.footer-bottom{display:flex;align-items:center;justify-content:space-between;padding-top:24px;border-top:1px solid rgba(255,255,255,0.07);flex-wrap:wrap;gap:12px}
.footer-bottom p{font-size:0.85rem;color:rgba(255,255,255,0.3)}
.footer-privacy{font-size:0.85rem;color:rgba(255,255,255,0.35);transition:var(--transition)}
.footer-privacy:hover{color:var(--blue)}

/* ===== FLOATING CTA ===== */
.floating-cta{position:fixed;bottom:28px;right:28px;z-index:999;opacity:0;transform:translateY(20px);transition:var(--transition);pointer-events:none}
.floating-cta.visible{opacity:1;transform:translateY(0);pointer-events:all}

/* ===== MODAL ===== */
.modal-overlay{position:fixed;inset:0;z-index:2000;background:rgba(0,0,0,0.7);display:flex;align-items:center;justify-content:center;backdrop-filter:blur(8px);padding:24px}
.modal-box{background:var(--white);border-radius:var(--radius-xl);padding:48px;text-align:center;max-width:420px;width:100%;box-shadow:var(--shadow-lg);animation:modalIn 0.3s cubic-bezier(0.4,0,0.2,1)}
@keyframes modalIn{from{opacity:0;transform:scale(0.9)}to{opacity:1;transform:scale(1)}}
.modal-icon{font-size:3.5rem;margin-bottom:16px}
.modal-box h3{font-family:var(--font);font-size:1.5rem;font-weight:700;margin-bottom:12px}
.modal-box p{color:var(--gray-mid);line-height:1.7;margin-bottom:24px}

/* ===== ANIMATIONS ===== */
.fade-up{opacity:0;transform:translateY(28px);transition:opacity 0.6s ease,transform 0.6s ease}
.fade-up.visible{opacity:1;transform:translateY(0)}

/* ===== RESPONSIVE ===== */
@media(max-width:1024px){
  .bento-grid{grid-template-columns:repeat(2,1fr)}
  .bento-large{grid-column:span 2;grid-row:span 1;min-height:auto}
  .bento-tall{grid-column:span 1;grid-row:span 1}
  .bento-wide{grid-column:span 2}
  .contato-layout{grid-template-columns:1fr}
  .faq-layout{grid-template-columns:1fr;gap:40px}
  .faq-header-col{position:static}
  .footer-top{grid-template-columns:1fr}
  .steps-horizontal{flex-wrap:wrap;gap:32px}
  .step-h-connector{display:none}
  .step-h{max-width:160px}
  .cta-banner-inner{flex-direction:column;text-align:center}
}
@media(max-width:768px){
  .kop-row{grid-template-columns:1fr;min-height:auto}
  .kop-row-reverse{direction:ltr}
  .kop-col-img{height:300px}
  .kop-col-text{padding:48px 24px}
  .testimonials-grid{grid-template-columns:1fr}
  .hero-stats{flex-direction:column;align-items:flex-start;gap:16px}
  .hero-stat-divider{display:none}
  .hero-stat{align-items:flex-start;padding:0}
  .hero-content{padding:40px 24px 60px;margin:0 auto}
  .bento-grid{grid-template-columns:1fr}
  .bento-large,.bento-wide{grid-column:span 1}
  .stats-bar-inner{gap:24px}
  .stat-bar-div{display:none}
  .footer-links{grid-template-columns:1fr 1fr}
  .footer-bottom{flex-direction:column;text-align:center}
  .floating-cta{bottom:16px;right:16px}
}
@media(max-width:480px){
  .hero-title{font-size:2rem}
  .topbar-logo{height:28px}
  .steps-horizontal{gap:24px}
  .step-h{max-width:100%}
  .footer-links{grid-template-columns:1fr}
  .kop-col-img{height:240px}
}
"@)

[System.IO.File]::WriteAllText("$p\styles.css", $css.ToString(), [System.Text.Encoding]::UTF8)
Write-Host "CSS: $([System.IO.File]::ReadAllBytes("$p\styles.css").Length) bytes"
