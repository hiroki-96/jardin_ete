document.addEventListener("DOMContentLoaded", () => {
  const flowerRadios = document.querySelectorAll('input[type="radio"][name="order[flower_type_id]"]');
  const sizesContainer = document.getElementById("sizes-container");

  flowerRadios.forEach(radio => {
    radio.addEventListener("change", async (e) => {
      const flowerTypeId = e.target.value;
      const res = await fetch(`/flower_types/${flowerTypeId}/sizes`);
      const sizes = await res.json();

      sizesContainer.innerHTML = "<p>サイズを選んでください:</p>";
      sizes.forEach(size => {
        sizesContainer.innerHTML += `
          <label style="display:block; margin-bottom: 10px;">
            <input type="radio" name="order[size_id]" value="${size.id}">
            ${size.name}（¥${size.price.toLocaleString()}）<br>
            ${size.image_url ? `<img src="${size.image_url}" style="max-width: 200px;">` : ""}
          </label>
        `;
      });
    });
  });
});