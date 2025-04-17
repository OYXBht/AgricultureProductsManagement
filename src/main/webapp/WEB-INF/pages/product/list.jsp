<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
    <h2 class="page-header">农产品管理</h2>
    
    <div class="row">
        <div class="col-md-6">
            <div class="input-group">
                <input type="text" id="searchKeyword" class="form-control" placeholder="搜索农产品...">
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" onclick="searchProducts()">搜索</button>
                </span>
            </div>
        </div>
        <div class="col-md-6 text-right">
            <button class="btn btn-success" data-toggle="modal" data-target="#addProductModal">
                <span class="glyphicon glyphicon-plus"></span> 添加农产品
            </button>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>名称</th>
                    <th>描述</th>
                    <th>价格</th>
                    <th>种类</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="productTableBody">
                <c:forEach items="${products}" var="product">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.description}</td>
                        <td>${product.price}</td>
                        <td>${product.categoryName}</td>
                        <td>
                            <span class="label ${product.isOnSale ? 'label-success' : 'label-danger'}">
                                ${product.isOnSale ? '在售' : '停售'}
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-xs btn-primary" onclick="editProduct(${product.id})">
                                <span class="glyphicon glyphicon-edit"></span>
                            </button>
                            <button class="btn btn-xs ${product.isOnSale ? 'btn-warning' : 'btn-success'}" 
                                    onclick="toggleSaleStatus(${product.id}, ${!product.isOnSale})">
                                <span class="glyphicon ${product.isOnSale ? 'glyphicon-pause' : 'glyphicon-play'}"></span>
                            </button>
                            <button class="btn btn-xs btn-danger" onclick="deleteProduct(${product.id})"
                                    ${product.isOnSale ? 'disabled' : ''}>
                                <span class="glyphicon glyphicon-trash"></span>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <nav>
        <ul class="pagination">
            <li class="${currentPage == 1 ? 'disabled' : ''}">
                <a href="#" onclick="changePage(${currentPage - 1})" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="${currentPage == i ? 'active' : ''}">
                    <a href="#" onclick="changePage(${i})">${i}</a>
                </li>
            </c:forEach>
            <li class="${currentPage == totalPages ? 'disabled' : ''}">
                <a href="#" onclick="changePage(${currentPage + 1})" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
</div>

<!-- 添加/编辑农产品模态框 -->
<div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalTitle">添加农产品</h4>
            </div>
            <div class="modal-body">
                <form id="productForm">
                    <input type="hidden" id="productId">
                    <div class="form-group">
                        <label for="name">名称</label>
                        <input type="text" class="form-control" id="name" required>
                    </div>
                    <div class="form-group">
                        <label for="description">描述</label>
                        <textarea class="form-control" id="description" rows="3"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="price">价格</label>
                        <input type="number" class="form-control" id="price" step="0.01" required>
                    </div>
                    <div class="form-group">
                        <label for="categoryId">种类</label>
                        <select class="form-control" id="categoryId" required>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="image">图片</label>
                        <input type="file" id="image" accept="image/*">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveProduct()">保存</button>
            </div>
        </div>
    </div>
</div>

<script>
var currentPage = 1;
var pageSize = 10;

function searchProducts() {
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/products/search?keyword=" + keyword + "&page=1&size=" + pageSize;
}

function changePage(page) {
    currentPage = page;
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/products/search?keyword=" + keyword + "&page=" + page + "&size=" + pageSize;
}

function editProduct(id) {
    $.ajax({
        url: "${pageContext.request.contextPath}/api/products/" + id,
        type: "GET",
        success: function(product) {
            $("#productId").val(product.id);
            $("#name").val(product.name);
            $("#description").val(product.description);
            $("#price").val(product.price);
            $("#categoryId").val(product.categoryId);
            $("#modalTitle").text("编辑农产品");
            $("#productModal").modal("show");
        }
    });
}

function saveProduct() {
    var formData = new FormData();
    var id = $("#productId").val();
    formData.append("name", $("#name").val());
    formData.append("description", $("#description").val());
    formData.append("price", $("#price").val());
    formData.append("categoryId", $("#categoryId").val());
    
    var imageFile = $("#image")[0].files[0];
    if (imageFile) {
        formData.append("file", imageFile);
    }

    var url = id ? "${pageContext.request.contextPath}/api/products/" + id : "${pageContext.request.contextPath}/api/products";
    var method = id ? "PUT" : "POST";

    $.ajax({
        url: url,
        type: method,
        data: formData,
        processData: false,
        contentType: false,
        success: function() {
            window.location.reload();
        }
    });
}

function toggleSaleStatus(id, isOnSale) {
    $.ajax({
        url: "${pageContext.request.contextPath}/api/products/" + id + "/sale-status",
        type: "PUT",
        data: { isOnSale: isOnSale },
        success: function() {
            window.location.reload();
        }
    });
}

function deleteProduct(id) {
    if (confirm("确定要删除这个农产品吗？")) {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/products/" + id,
            type: "DELETE",
            success: function() {
                window.location.reload();
            }
        });
    }
}
</script> 