<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
    <h2 class="page-header">种类管理</h2>
    
    <div class="row">
        <div class="col-md-6">
            <div class="input-group">
                <input type="text" id="searchKeyword" class="form-control" placeholder="搜索种类...">
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" onclick="searchCategories()">搜索</button>
                </span>
            </div>
        </div>
        <div class="col-md-6 text-right">
            <button class="btn btn-success" data-toggle="modal" data-target="#categoryModal">
                <span class="glyphicon glyphicon-plus"></span> 添加种类
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
                    <th>产品数量</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="categoryTableBody">
                <c:forEach items="${categories}" var="category">
                    <tr>
                        <td>${category.id}</td>
                        <td>${category.name}</td>
                        <td>${category.description}</td>
                        <td>${category.productCount}</td>
                        <td>
                            <button class="btn btn-xs btn-primary" onclick="editCategory(${category.id})">
                                <span class="glyphicon glyphicon-edit"></span>
                            </button>
                            <button class="btn btn-xs btn-danger" onclick="deleteCategory(${category.id})"
                                    ${category.productCount > 0 ? 'disabled' : ''}>
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

<!-- 添加/编辑种类模态框 -->
<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalTitle">添加种类</h4>
            </div>
            <div class="modal-body">
                <form id="categoryForm">
                    <input type="hidden" id="categoryId">
                    <div class="form-group">
                        <label for="name">名称</label>
                        <input type="text" class="form-control" id="name" required>
                    </div>
                    <div class="form-group">
                        <label for="description">描述</label>
                        <textarea class="form-control" id="description" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveCategory()">保存</button>
            </div>
        </div>
    </div>
</div>

<script>
var currentPage = 1;
var pageSize = 10;

function searchCategories() {
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/categories/search?keyword=" + keyword + "&page=1&size=" + pageSize;
}

function changePage(page) {
    currentPage = page;
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/categories/search?keyword=" + keyword + "&page=" + page + "&size=" + pageSize;
}

function editCategory(id) {
    $.ajax({
        url: "${pageContext.request.contextPath}/api/categories/" + id,
        type: "GET",
        success: function(category) {
            $("#categoryId").val(category.id);
            $("#name").val(category.name);
            $("#description").val(category.description);
            $("#modalTitle").text("编辑种类");
            $("#categoryModal").modal("show");
        }
    });
}

function saveCategory() {
    var category = {
        id: $("#categoryId").val(),
        name: $("#name").val(),
        description: $("#description").val()
    };

    var url = category.id ? "${pageContext.request.contextPath}/api/categories/" + category.id : "${pageContext.request.contextPath}/api/categories";
    var method = category.id ? "PUT" : "POST";

    $.ajax({
        url: url,
        type: method,
        contentType: "application/json",
        data: JSON.stringify(category),
        success: function() {
            window.location.reload();
        }
    });
}

function deleteCategory(id) {
    if (confirm("确定要删除这个种类吗？")) {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/categories/" + id,
            type: "DELETE",
            success: function() {
                window.location.reload();
            }
        });
    }
}
</script> 