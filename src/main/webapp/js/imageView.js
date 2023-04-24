

const imageHandlerEdit = function (editForm) {
	const imageInput = editForm.querySelector(".imageUpload-edit");

	if (!imageInput) return;
	const imagePreview = editForm.querySelector(".imagePreview-edit");



	imageInput.addEventListener("change", function () {
		if (this.files && this.files[0]) {
			const reader = new FileReader();
			reader.onload = function (e) {
				imagePreview.style.backgroundImage = `url(${e.target.result})`;
				imagePreview.style.display = "none";
				imagePreview.style.opacity = "0";
				imagePreview.classList.remove("default-avatar");
				setTimeout(() => {
					imagePreview.style.display = "block";
					imagePreview.style.transition = "opacity 650ms ease-in-out";
					imagePreview.style.opacity = "1";
				}, 100);
			};
			reader.readAsDataURL(this.files[0]);
		}
	});

	editForm.querySelector(".product-preview__edit").addEventListener("click", function (e) {
		e.preventDefault();
		imageInput.click();
	});
};
const imagePreviewHandler = function () {
	let imageUpload = document.getElementById("profileUpload");
	if (!imageUpload) imageUpload = document.getElementById("productUpload");
	let imagePreview = document.getElementById("imagePreview");
	// if (!imagePreview) imagePreview = document.getElementById("productPreview");

	if (!imageUpload) return;
	imageUpload.addEventListener("change", function () {
		if (this.files && this.files[0]) {
			const reader = new FileReader();
			reader.onload = function (e) {
				imagePreview.style.backgroundImage = `url(${e.target.result})`;
				imagePreview.style.display = "none";
				imagePreview.style.opacity = "0";
				imagePreview.classList.remove("default-avatar");
				setTimeout(() => {
					imagePreview.style.display = "block";
					imagePreview.style.transition = "opacity 650ms ease-in-out";
					imagePreview.style.opacity = "1";
				}, 100);
			};
			reader.readAsDataURL(this.files[0]);
		}
	});
};

const imageInputOptimization = function () {
	let profileUpload = document.querySelector(".profile-upload");

	if (!profileUpload) {
		profileUpload = document.querySelector(".product-upload");
	}
	profileUpload.addEventListener("click", function (e) {
		if (
			!e.target.matches('label[for="profileUpload"]') &&
			profileUpload.classList.contains("profile-upload")
		) {
			document.querySelector(".avatar-edit input[type=file]").click();
		}
		if (!e.target.matches('label[for="productUpload"]')) {
			document.querySelector(".product-edit input[type=file]").click();
		}
	});
};

window.addEventListener("load", function () {
	imagePreviewHandler();
	imageInputOptimization();
	const editForm = document.querySelector(".edit-product-form");
	if(editForm) imageHandlerEdit(editForm);
	else return;
});

