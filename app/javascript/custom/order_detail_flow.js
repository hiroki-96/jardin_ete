document.addEventListener("DOMContentLoaded", () => {
  const usageSection = document.getElementById("usage-section");
  const colorToneSection = document.getElementById("color-tone-section");
  const moodSection = document.getElementById("mood-section");
  const extraSection = document.getElementById("extra-section");

  // サイズが選ばれたら詳細（用途・色味・雰囲気・備考）をまとめて表示する
  document.addEventListener("change", (e) => {
    if (e.target.name === "order[size_id]") {
      usageSection.style.display = "block";
      colorToneSection.style.display = "block";
      moodSection.style.display = "block";
      extraSection.style.display = "block";
    }
  });
});