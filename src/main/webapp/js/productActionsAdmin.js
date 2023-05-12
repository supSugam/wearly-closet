
const deleteProductFromDatabase = (productId,productRow=null) => {
    let btnConfirm = document.querySelector(".btn--confirm");
    btnConfirm.innerHTML = `<i class="fa-solid fa-spinner-third fa-spin"></i>`;

    fetch(`http://localhost:8080/wearly-ecommerce/DeleteProductServlet?productId=${productId}`, {
        method: "get",
    }).then((response) => {
        if(response.status===200){
            if(!productRow) productRow.remove();
        } else{
            console.log("Response not OK");
        }
    });

    btnConfirm.innerHTML = `Deleted <i class="fa-solid fa-check"></i>`;
    setTimeout(() => {
        closePopup(document.getElementById("deleteProduct-modal"));
    }, 1000);
};

const deleteProduct = function (productId, productRow=null) {

    openPopup(document.getElementById("deleteProduct-modal"));

    document.getElementById("deleteProduct-modal").querySelector(".modal__buttons").addEventListener("click", (e) => {
        const target = e.target;
        if(target.classList.contains("btn--cancel")) closePopup();
        if (target.classList.contains("btn--confirm")) deleteProductFromDatabase(productId, productRow);
    });
}

document.querySelectorAll(".btn--deleteProduct").forEach((btn) => {
    btn.addEventListener("click", (e) => {
        e.preventDefault();
        const productId = e.target.dataset.id;
        deleteProduct(productId);
    })
})
