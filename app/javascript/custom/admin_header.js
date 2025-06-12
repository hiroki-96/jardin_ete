document.addEventListener("turbo:load", function() {
  const btn = document.getElementById("admin-hamburger-btn");
  const nav = document.getElementById("admin-nav-menu");
  const closeBtn = document.getElementById("admin-nav-close-btn");
  if (!btn || !nav) return;

  // 既存のイベントリスナーを一旦解除（念のため）
  btn.replaceWith(btn.cloneNode(true));
  const newBtn = document.getElementById("admin-hamburger-btn");
  newBtn.addEventListener("click", function() {
    nav.classList.toggle("open");
    newBtn.classList.toggle("open");
  });

  if (closeBtn) {
    closeBtn.onclick = function() {
      nav.classList.remove("open");
      newBtn.classList.remove("open");
    };
  }
}); 