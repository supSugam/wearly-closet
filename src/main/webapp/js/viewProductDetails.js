const viewProductDetails = function (productId,productName) {
    window.location.href = `http://localhost:8080/wearly-ecommerce/view/product.jsp?id=${productId}&name=${productName}`;
}