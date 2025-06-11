document.addEventListener("turbo:load", () => {
  const fromConfirm = sessionStorage.getItem("fromConfirm");
  const receiveMethod = document.querySelector('input[name="order[receive_method]"]:checked')?.value;

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
  const receiveTimeSelect = document.getElementById("order_receive_time");

  if (receiveTimeSelect) {
    receiveTimeSelect.required = false;
    receiveTimeSelect.disabled = true;
  }

  function updateReceiveTimeField() {
    const receiveMethod = document.querySelector('input[name="order[receive_method]"]:checked')?.value;
    if (!receiveTimeSelect) return;

    deliveryTimeSection.style.display = "none";
    deliveryFields.style.display = "none";
    if (deliveryAddressInput) deliveryAddressInput.value = "";
    if (deliveryNameInput) deliveryNameInput.value = "";
    receiveTimeSelect.required = false;
    receiveTimeSelect.disabled = true;

    receiveDateSection.style.display = "block";

    if (receiveMethod === "delivery") {
      deliveryTimeSection.style.display = "block";
      deliveryFields.style.display = "block";
      receiveTimeSelect.disabled = false;
      receiveTimeSelect.required = true;
    }
  }

  if (fromConfirm === "true") {
    const sections = [
      "sizes-container", "usage-section", "color-tone-section", "mood-section",
      "extra-section", "receive-method-section", "receive-date-section",
      "guest-info-section", "submit-section"
    ];
    if (receiveMethod === "delivery") {
      sections.push("delivery-time-section");
    }
    sections.forEach(id => {
      const el = document.getElementById(id);
      if (el) el.style.display = "block";
    });

    updateReceiveTimeField();
    sessionStorage.removeItem("fromConfirm");
  }

  const selectedFlowerTypeId = document.querySelector('input[name="selected_flower_type_id"]')?.value;
  if (selectedFlowerTypeId) {
    const card = document.querySelector(`[data-flower-type-id="${selectedFlowerTypeId}"]`);
    if (card) card.click();
  }

  document.querySelectorAll(".flower-type-card").forEach((card) => {
    card.addEventListener("click", () => {
      const flowerTypeId = card.dataset.flowerTypeId;
      const radio = document.getElementById(`flower_type_${flowerTypeId}`);
      if (radio) radio.checked = true;

      fetch(`/flower_types/${flowerTypeId}/sizes`)
        .then(response => response.json())
        .then(sizes => {
          const h2 = sizesContainer.querySelector("h2");
          const customPriceSection = document.getElementById("custom-price-section");

          const keepElements = [h2, customPriceSection];
          sizesContainer.innerHTML = "";
          keepElements.forEach(el => {
            if (el) sizesContainer.appendChild(el);
          });

          sizes.forEach(size => {
            const html = `
              <div class="size-card" data-size-id="${size.id}" style="margin: 10px;">
                ${size.image_url ? `<img src="${size.image_url}" alt="参考画像" style="width: 200px;">` : ""}
                <p>参考価格：¥${size.price}</p>
              </div>
            `;
            sizesContainer.insertAdjacentHTML("beforeend", html);
          });

          sizesContainer.style.display = "block";

          const customPriceInput = document.getElementById("order_custom_price");
          if (customPriceInput) {
            customPriceInput.addEventListener("input", () => {
              if (customPriceInput.value.trim() !== "") {
                usageSection.style.display = "block";
                colorToneSection.style.display = "block";
                moodSection.style.display = "block";
                extraSection.style.display = "block";
              }
            });
          }
        });
    });
  });

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

  document.getElementById("pickup")?.addEventListener("change", updateReceiveTimeField);
  document.getElementById("delivery")?.addEventListener("change", updateReceiveTimeField);

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