package vn.iot.star.model;

import jakarta.validation.constraints.NotBlank;

public class CategoryModel {

    private int categoryId;

    @NotBlank(message = "Category name cannot be empty")
    private String categoryname;

    private String images;

    private int status;

    private Boolean isEdit = false;

    public CategoryModel() {
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Boolean getIsEdit() {
        return isEdit;
    }

    public void setIsEdit(Boolean isEdit) {
        this.isEdit = isEdit;
    }
}