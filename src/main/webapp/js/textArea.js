const textarea = document.querySelector(".product-description-field textarea");
textarea.addEventListener("input", function () {
    const text = textarea.value;
    const lines = text.split("\n");

    const splitLines = lines
        .map((line) => {
            return line.length > 30
                ? [line.slice(0, 30), ...line.slice(30).match(/.{1,30}/g)]
                : [line];
        })
        .flat();

    textarea.value = splitLines.join("\n");
});
