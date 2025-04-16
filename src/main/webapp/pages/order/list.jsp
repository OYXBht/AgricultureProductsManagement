<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
    <h2 class="page-header">订单管理</h2>
    
    <div class="row">
        <div class="col-md-6">
            <div class="input-group">
                <input type="text" id="searchKeyword" class="form-control" placeholder="搜索订单...">
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" onclick="searchOrders()">搜索</button>
                </span>
            </div>
        </div>
        <div class="col-md-6">
            <div class="btn-group pull-right">
                <button type="button" class="btn btn-default" onclick="filterOrders('all')">全部</button>
                <button type="button" class="btn btn-default" onclick="filterOrders('pending')">待处理</button>
                <button type="button" class="btn btn-default" onclick="filterOrders('processing')">处理中</button>
                <button type="button" class="btn btn-default" onclick="filterOrders('completed')">已完成</button>
                <button type="button" class="btn btn-default" onclick="filterOrders('cancelled')">已取消</button>
            </div>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>订单号</th>
                    <th>客户名称</th>
                    <th>订单金额</th>
                    <th>订单状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="orderTableBody">
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td>${order.orderNumber}</td>
                        <td>${order.customerName}</td>
                        <td>￥${order.totalAmount}</td>
                        <td>
                            <span class="label ${order.status == 'pending' ? 'label-warning' : 
                                               order.status == 'processing' ? 'label-info' : 
                                               order.status == 'completed' ? 'label-success' : 
                                               'label-danger'}">
                                ${order.status == 'pending' ? '待处理' : 
                                  order.status == 'processing' ? '处理中' : 
                                  order.status == 'completed' ? '已完成' : 
                                  '已取消'}
                            </span>
                        </td>
                        <td>${order.createTime}</td>
                        <td>
                            <button class="btn btn-xs btn-primary" onclick="viewOrder('${order.orderNumber}')">
                                <span class="glyphicon glyphicon-eye-open"></span>
                            </button>
                            <c:if test="${order.status == 'pending'}">
                                <button class="btn btn-xs btn-success" onclick="processOrder('${order.orderNumber}')">
                                    <span class="glyphicon glyphicon-play"></span>
                                </button>
                                <button class="btn btn-xs btn-danger" onclick="cancelOrder('${order.orderNumber}')">
                                    <span class="glyphicon glyphicon-stop"></span>
                                </button>
                            </c:if>
                            <c:if test="${order.status == 'processing'}">
                                <button class="btn btn-xs btn-success" onclick="completeOrder('${order.orderNumber}')">
                                    <span class="glyphicon glyphicon-ok"></span>
                                </button>
                            </c:if>
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

<!-- 订单详情模态框 -->
<div class="modal fade" id="orderDetailModal" tabindex="-1" role="dialog" aria-labelledby="orderDetailModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">订单详情</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <h5>订单信息</h5>
                        <table class="table table-bordered">
                            <tr>
                                <th>订单号</th>
                                <td id="detailOrderNumber"></td>
                            </tr>
                            <tr>
                                <th>客户名称</th>
                                <td id="detailCustomerName"></td>
                            </tr>
                            <tr>
                                <th>订单状态</th>
                                <td id="detailStatus"></td>
                            </tr>
                            <tr>
                                <th>创建时间</th>
                                <td id="detailCreateTime"></td>
                            </tr>
                            <tr>
                                <th>订单金额</th>
                                <td id="detailTotalAmount"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h5>收货信息</h5>
                        <table class="table table-bordered">
                            <tr>
                                <th>收货人</th>
                                <td id="detailReceiverName"></td>
                            </tr>
                            <tr>
                                <th>联系电话</th>
                                <td id="detailReceiverPhone"></td>
                            </tr>
                            <tr>
                                <th>收货地址</th>
                                <td id="detailReceiverAddress"></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h5>订单商品</h5>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>商品名称</th>
                                    <th>单价</th>
                                    <th>数量</th>
                                    <th>小计</th>
                                </tr>
                            </thead>
                            <tbody id="detailOrderItems">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script>
var currentPage = 1;
var pageSize = 10;
var currentStatus = 'all';

function searchOrders() {
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/orders/search?keyword=" + keyword + "&status=" + currentStatus + "&page=1&size=" + pageSize;
}

function filterOrders(status) {
    currentStatus = status;
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/orders/search?keyword=" + keyword + "&status=" + status + "&page=1&size=" + pageSize;
}

function changePage(page) {
    currentPage = page;
    var keyword = document.getElementById('searchKeyword').value;
    window.location.href = "${pageContext.request.contextPath}/api/orders/search?keyword=" + keyword + "&status=" + currentStatus + "&page=" + page + "&size=" + pageSize;
}

function viewOrder(orderNumber) {
    $.ajax({
        url: "${pageContext.request.contextPath}/api/orders/" + orderNumber,
        type: "GET",
        success: function(order) {
            $("#detailOrderNumber").text(order.orderNumber);
            $("#detailCustomerName").text(order.customerName);
            $("#detailStatus").text(getStatusText(order.status));
            $("#detailCreateTime").text(order.createTime);
            $("#detailTotalAmount").text("￥" + order.totalAmount);
            $("#detailReceiverName").text(order.receiverName);
            $("#detailReceiverPhone").text(order.receiverPhone);
            $("#detailReceiverAddress").text(order.receiverAddress);
            
            var itemsHtml = "";
            order.items.forEach(function(item) {
                itemsHtml += "<tr>" +
                    "<td>" + item.productName + "</td>" +
                    "<td>￥" + item.price + "</td>" +
                    "<td>" + item.quantity + "</td>" +
                    "<td>￥" + (item.price * item.quantity) + "</td>" +
                    "</tr>";
            });
            $("#detailOrderItems").html(itemsHtml);
            
            $("#orderDetailModal").modal("show");
        }
    });
}

function getStatusText(status) {
    switch(status) {
        case 'pending': return '待处理';
        case 'processing': return '处理中';
        case 'completed': return '已完成';
        case 'cancelled': return '已取消';
        default: return status;
    }
}

function processOrder(orderNumber) {
    if (confirm("确定要开始处理这个订单吗？")) {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/orders/" + orderNumber + "/process",
            type: "PUT",
            success: function() {
                window.location.reload();
            }
        });
    }
}

function completeOrder(orderNumber) {
    if (confirm("确定要将这个订单标记为已完成吗？")) {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/orders/" + orderNumber + "/complete",
            type: "PUT",
            success: function() {
                window.location.reload();
            }
        });
    }
}

function cancelOrder(orderNumber) {
    if (confirm("确定要取消这个订单吗？")) {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/orders/" + orderNumber + "/cancel",
            type: "PUT",
            success: function() {
                window.location.reload();
            }
        });
    }
}
</script> 