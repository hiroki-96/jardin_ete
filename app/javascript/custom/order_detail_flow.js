document.addEventListener("DOMContentLoaded", () => {
  // ========================
  // 要素の取得
  // ========================
  const sizesContainer = document.getElementById("sizes-container");
  const usageSection = document.getElementById("usage-section");
  const colorToneSection = document.getElementById("color-tone-section");
  const moodSection = document.getElementById("mood-section");
  const extraSection = document.getElementById("extra-section");
  const receiveMethodSection = document.getElementById("receive-method-section");
  const receiveDateSection = document.getElementById("receive-date-section");
  const deliveryTimeSection = document.getElementById("delivery-time-section");
  const guestInfoSection = document.getElementById("guest-info-section");
  const submitSection = document.getElementById("submit-section");
  const deliveryFields = document.getElementById("delivery-fields");

  const usageSelect = document.getElementById("usage-select");
  const colorToneSelect = document.getElementById("color-tone-select");
  const moodSelect = document.getElementById("mood-select");

  const deliveryAddressInput = document.getElementById("order_delivery_address");
  const deliveryNameInput = document.getElementById("order_delivery_name");

  // ========================
  // ① メニュー選択 → サイズ取得
  // ========================
  document.querySelectorAll(".flower-type-card").forEach((card) => {
    card.addEventListener("click", () => {
      const flowerTypeId = card.dataset.flowerTypeId;
      const radio = document.getElementById(`flower_type_${flowerTypeId}`);
      if (radio) radio.checked = true;

      fetch(`/flower_types/${flowerTypeId}/sizes`)
        .then(response => response.json())
        .then(sizes => {
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

          document.querySelectorAll('input[name="order[size_id]"]').forEach(input => {
            input.addEventListener("change", () => {
              document.querySelectorAll(".size-card").forEach(card => card.style.opacity = 0.5);
              const selectedCard = input.closest("label").querySelector(".size-card");
              if (selectedCard) selectedCard.style.opacity = 1;

              usageSection.style.display = "block";
              colorToneSection.style.display = "block";
              moodSection.style.display = "block";
              extraSection.style.display = "block";
            });
          });
        });
    });
  });

  // ========================
  // ②③④選択後 → 受け取り方法表示
  // ========================
  function checkAndShowReceiveMethod() {
    if (
      usageSelect?.value && usageSelect.value !== "1" &&
      colorToneSelect?.value && colorToneSelect.value !== "1" &&
      moodSelect?.value && moodSelect.value !== "1"
    ) {
      receiveMethodSection.style.display = "block";
    }
  }

  usageSelect?.addEventListener("change", checkAndShowReceiveMethod);
  colorToneSelect?.addEventListener("change", checkAndShowReceiveMethod);
  moodSelect?.addEventListener("change", checkAndShowReceiveMethod);

  // ========================
  // ④ 受け取り方法選択 → ⑤ 日付欄表示
  // ========================
  document.getElementById("pickup")?.addEventListener("change", () => {
    deliveryTimeSection.style.display = "none";
    receiveDateSection.style.display = "block";

    // 🟡 配達フィールドを非表示＋値をリセット
    deliveryFields.style.display = "none";
    if (deliveryAddressInput) deliveryAddressInput.value = "";
    if (deliveryNameInput) deliveryNameInput.value = "";
  });

  document.getElementById("delivery")?.addEventListener("change", () => {
    deliveryTimeSection.style.display = "block";
    receiveDateSection.style.display = "block";

    // 🟢 配達フィールドを表示
    deliveryFields.style.display = "block";
  });

  // ========================
  // ⑤ 日付入力後 → ⑥ ご連絡先と送信ボタン表示
  // ========================
  const dateInputs = document.querySelectorAll("input[name='order[receive_date]']");
  dateInputs.forEach(input => {
    input.addEventListener("change", () => {
      guestInfoSection.style.display = "block";
      submitSection.style.display = "block";

      const isDelivery = document.getElementById("delivery")?.checked;
      if (isDelivery) {
        deliveryFields.style.display = "block";
      } else {
        deliveryFields.style.display = "none";
        if (deliveryAddressInput) deliveryAddressInput.value = "";
        if (deliveryNameInput) deliveryNameInput.value = "";
      }
    });
  });
});