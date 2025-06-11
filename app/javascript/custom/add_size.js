document.addEventListener("turbo:load", () => {
  const addButton = document.getElementById("add-size");
  const container = document.getElementById("sizes-container");
  const template = document.getElementById("size-template");
  const maxCount = 5;
  const existingCountInput = document.getElementById("existing-size-count");

  if (!addButton || !container || !template || !existingCountInput) return;

  let count = parseInt(existingCountInput.value, 10);

  // 初期で上限ならボタン非表示
  if (count >= maxCount) {
    addButton.style.display = "none";
  }

  addButton.addEventListener("click", () => {
    if (count >= maxCount) {
      alert("参考価格と画像は最大5件までです");
      return;
    }

    const index = Date.now();
    let newFields = template.innerHTML.replace(/INDEX/g, index);
    container.insertAdjacentHTML("beforeend", newFields);
    count++;

    if (count >= maxCount) {
      addButton.style.display = "none";
    }
  });
});