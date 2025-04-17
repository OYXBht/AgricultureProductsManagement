<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
    <h2 class="page-header">库存管理</h2>
    
    <div class="row">
        <div class="col-md-6">
            <div class="input-group">
                <input type="text" id="searchKeyword" class="form-control" placeholder="搜索产品...">
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" onclick="searchInventories()">搜索</button>
                </span>
            </div>
        </div>
        <div class="col-md-6 text-right">
            <button class="btn btn-success" data-toggle="modal" data-target="#inventoryModal">
                <span class="glyphicon glyphicon-plus"></span> 添加库存
            </button>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>产品名称</th>
                    <th>种类</th>
                    <th>库存数量</th>
                    <th>库存预警值</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="inventoryTableBody">
                <c:forEach items="${inventories}" var="inventory">
                    <tr>
                        <td>${inventory.id}</td>
                        <td>${inventory.productName}</td>
                        <td>${inventory.categoryName}</td>
                        <td>${inventory.quantity}</td>
                        <td>${inventory.warningLevel}</td>
                        <td>
                            <span class="label ${inventory.quantity > inventory.warningLevel ? 'label-success' : 'label-danger'}">
                                ${inventory.quantity > inventory.warningLevel ? '正常' : '库存不足'}
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-xs btn-primary" onclick="editInventory(${inventory.id})">
                                <span class="glyphicon glyphicon-edit"></span>
                            </button>
                            <button class="btn btn-xs btn-info" onclick="adjustStock(${inventory.id})">
                                <span class="glyphicon glyphicon-plus"></span>
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

<!-- 添加/编辑库存模态框 -->
<div class="modal fade" id="inventoryModal" tabindex="-1" role="dialog" aria-labelledby="inventoryModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalTitle">添加库存</h4>
            </div>
            <div class="modal-body">
                <form id="inventoryForm">
                    <input type="hidden" id="inventoryId">
                    <div class="form-group">
                        <label for="productId">产品</label>
                        <select class="form-control" id="productId" required>
                            <c:forEach items="${products}" var="product">
                                <option value="${product.id}">${product.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="quantity">库存数量</label>
                        <input type="number" class="form-control" id="quantity" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="warningLevel">库存预警值</label>
                        <input type="number" class="form-control" id="warningLevel" min="0" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveInventory()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 调整库存模态框 -->
<div class="modal fade" id="adjustStockModal" tabindex="-1" role="dialog" aria-labelledby="adjustStockModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">调整库存</h4>
            </div>
            <div class="modal-body">
                <form id="adjustStockForm">
                    <input type="hidden" id="adjustInventoryId">
                    <div class="form-group">
                        <label for="adjustType">调整类型</label>
                        <select class="form-control" id="adjustType" required>
                            <option value="add">入库</option>
                            <option value="subtract">出库</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="adjustQuantity">调整数量</label>
                        <input type="number" class="form-control" id="adjustQuantity" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="adjustReason">调整原因</label>
                        <textarea class="form-control" id="adjustReason" rows="3" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveAdjustment()">保存</button>
            </div>
        </div>
    </div>
</div>

<script>
var currentPage = 1;
var pageSize = 10;

function searchInventories() {
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/inventories/search?keyword=" + keyword + "&page=1&size=" + pageSize;
}

function changePage(page) {
    currentPage = page;
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/inventories/search?keyword=" + keyword + "&page=" + page + "&size=" + pageSize;
}

function editInventory(id) {
    $.ajax({
        url: "${pageContext.request.contextPath}/api/inventories/" + id,
        type: "GET",
        success: function(inventory) {
            $("#inventoryId").val(inventory.id);
            $("#productId").val(inventory.productId);
            $("#quantity").val(inventory.quantity);
            $("#warningLevel").val(inventory.warningLevel);
            $("#modalTitle").text("编辑库存");
            $("#inventoryModal").modal("show");
        }
    });
}

function saveInventory() {
    var inventory = {
        id: $("#inventoryId").val(),
        productId: $("#productId").val(),
        quantity: $("#quantity").val(),
        warningLevel: $("#warningLevel").val()
    };

    var url = inventory.id ? "${pageContext.request.contextPath}/api/inventories/" + inventory.id : "${pageContext.request.contextPath}/api/inventories";
    var method = inventory.id ? "PUT" : "POST";

    $.ajax({
        url: url,
        type: method,
        contentType: "application/json",
        data: JSON.stringify(inventory),
        success: function() {
            window.location.reload();
        }
    });
}

function adjustStock(id) {
    $("#adjustInventoryId").val(id);
    $("#adjustStockModal").modal("show");
}

function saveAdjustment() {
    var adjustment = {
        inventoryId: $("#adjustInventoryId").val(),
        type: $("#adjustType").val(),
        quantity: $("#adjustQuantity").val(),
        reason: $("#adjustReason").val()
    };

    $.ajax({
        url: "${pageContext.request.contextPath}/api/inventories/adjust",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(adjustment),
        success: function() {
            window.location.reload();
        }
    });
}
</script> 