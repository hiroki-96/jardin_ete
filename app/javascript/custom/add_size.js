document.addEventListener("turbo:load", () => {
  const addButton = document.getElementById("add-size");
  const container = document.getElementById("sizes-container");
  const template = document.getElementById("size-template");

  if (!addButton || !container || !template) return;

  addButton.addEventListener("click", () => {
    const index = Date.now(); // ユニークなインデックスを作る
    let newFields = template.innerHTML.replace(/NEW_RECORD/g, index);
    container.insertAdjacentHTML("beforeend", newFields);
  });
});