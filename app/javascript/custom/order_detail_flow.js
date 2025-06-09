document.addEventListener("DOMContentLoaded", () => {
  const sizesContainer = document.getElementById("sizes-container");
  const usageSection = document.getElementById("usage-section");
  const colorToneSection = document.getElementById("color-tone-section");
  const moodSection = document.getElementById("mood-section");
  const extraSection = document.getElementById("extra-section");
  const receiveMethodSection = document.getElementById("receive-method-section");

  const usageSelect = document.getElementById("usage-select");
  const colorToneSelect = document.getElementById("color-tone-select");
  const moodSelect = document.getElementById("mood-select");

  // 花の種類カードがクリックされた時の処理
  document.querySelectorAll(".flower-type-card").forEach((card) => {
    card.addEventListener("click", () => {
      const flowerTypeId = card.dataset.flowerTypeId;

      // ラジオボタンをチェック（非表示なのでJSで操作）
      const radio = document.getElementById(`flower_type_${flowerTypeId}`);
      if (radio) radio.checked = true;

      // サイズデータを取得して表示
      fetch(`/flower_types/${flowerTypeId}/sizes`)
        .then(response => response.json())
        .then(sizes => {
          // 初期化（h2は消さないように）
          const existingH2 = sizesContainer.querySelector("h2");
          sizesContainer.innerHTML = "";
          if (existingH2) sizesContainer.appendChild(existingH2);

          sizes.forEach(size => {
            const html = `
              <label style="display: inline-block; margin: 10px;">
                <input type="radio" name="order[size_id]" value="${size.id}" id="size_${size.id}" style="display: none;">
                <div class="size-card" data-size-id="${size.id}" style="cursor: pointer; opacity: 0.5;">
                  ${size.image_url ? `<img src="${size.image_url}" alt="${size.name}" style="width: 200px;">` : ""}
                  <p>${size.name} - ¥${size.price}</p>
                </div>
              </label>
            `;
            sizesContainer.insertAdjacentHTML("beforeend", html);
          });

          sizesContainer.style.display = "block";

          // ラジオボタンの選択で詳細項目を表示 & 見た目変更
          document.querySelectorAll('input[name="order[size_id]"]').forEach(input => {
            input.addEventListener("change", () => {
              document.querySelectorAll(".size-card").forEach(card => {
                card.classList.remove("selected");
                card.style.opacity = 0.5;
              });

              const selectedCard = input.closest("label").querySelector(".size-card");
              if (selectedCard) {
                selectedCard.classList.add("selected");
                selectedCard.style.opacity = 1;
              }

              usageSection.style.display = "block";
              colorToneSection.style.display = "block";
              moodSection.style.display = "block";
              extraSection.style.display = "block";
            });
          });
        });
    });
  });

  // 受け取り方法の表示ロジック
  function checkAndShowReceiveMethod() {
    if (
      usageSelect && colorToneSelect && moodSelect &&
      usageSelect.value && usageSelect.value !== "1" &&
      colorToneSelect.value && colorToneSelect.value !== "1" &&
      moodSelect.value && moodSelect.value !== "1"
    ) {
      if (receiveMethodSection) receiveMethodSection.style.display = "block";
    }
  }

  if (usageSelect) usageSelect.addEventListener("change", checkAndShowReceiveMethod);
  if (colorToneSelect) colorToneSelect.addEventListener("change", checkAndShowReceiveMethod);
  if (moodSelect) moodSelect.addEventListener("change", checkAndShowReceiveMethod);
});