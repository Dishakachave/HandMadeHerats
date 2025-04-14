<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <%@include file="all_component/allcss.jsp"%>
    <style>
        .add-product-container {
            padding: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>
    <div class="container add-product-container">
        <h1>Add Product</h1>
        <form action="AddProductServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name" class="form-control">
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="text" id="price" name="price" class="form-control">
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" class="form-control"></textarea>
            </div>
            <div class="form-group">
                <label for="image">Image:</label>
                <input type="file" id="image" name="image" class="form-control">
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" class="form-control">
            </div>
            <div class="form-group">
                <label for="inStock">In Stock:</label>
                <input type="checkbox" id="inStock" name="inStock">
            </div>
            <button type="submit" class="btn btn-primary">Add Product</button>
        </form>
    </div>
    <%@include file="all_component/footer.jsp"%>
</body>
</html>
