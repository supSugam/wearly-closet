    const overlay = document.querySelector("#overlay");
    const okButton = document.querySelectorAll(".btn--modal, .btn--close");

    const openPopup = function (popup) {
        popup.classList.add("open-popup");
        overlay.style.display = "block";
        document.body.classList.add("modal-open");
        document.body.style.overflow = "hidden";
    };

    const closePopup = function () {
        document.querySelector(".modal-popup.open-popup").classList.remove("open-popup");
        overlay.style.display = "none";
        document.body.classList.remove("modal-open");
        document.body.style.overflow = "auto";
    };

    okButton.forEach((btn) => {
        btn.addEventListener("click", closePopup);
    });
