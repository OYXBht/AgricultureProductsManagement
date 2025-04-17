package com.example.agriculture.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "`order`", schema = "demo")
public class Order {
    @Id
    @Column(name = "order_id", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private com.example.agriculture.entity.User user;

    @Size(max = 50)
    @NotNull
    @Column(name = "order_number", nullable = false, length = 50)
    private String orderNumber;

    @NotNull
    @Column(name = "total_amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalAmount;

    @NotNull
    @ColumnDefault("'UNPAID'")
    @Lob
    @Column(name = "payment_status", nullable = false)
    private String paymentStatus;

    @NotNull
    @ColumnDefault("'UNSHIPPED'")
    @Lob
    @Column(name = "shipping_status", nullable = false)
    private String shippingStatus;

    @NotNull
    @ColumnDefault("'UNRECEIVED'")
    @Lob
    @Column(name = "receiving_status", nullable = false)
    private String receivingStatus;

    @NotNull
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @NotNull
    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;

}