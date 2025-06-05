<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Make Payment</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #000;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 100px;
        }

        .payment-box {
            background: #fff;
            color: #000;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px orange;
        }

        input[type="number"] {
            padding: 10px;
            font-size: 1em;
            width: 200px;
            margin-bottom: 10px;
            border: 2px solid orange;
            border-radius: 5px;
        }

        button {
            padding: 10px 20px;
            background: orange;
            color: #000;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .display-amount {
            font-size: 1.2em;
            font-weight: bold;
            color: orange;
        }
    </style>
</head>
<body>

<div class="payment-box">
    <h2>Enter Amount to Pay</h2>
    <input type="number" id="amount" placeholder="Enter amount in ₹" required min="1" step="1" />
    <div class="display-amount">₹0</div>
    <button onclick="payNow()">Pay Now</button>
</div>

<script>
    document.getElementById('amount').addEventListener('input', function () {
        let amount = parseInt(this.value.replace(/[^0-9]/g, '')) || 0;
        document.querySelector('.display-amount').textContent = '₹' + amount;
    });

    function payNow() {
        let amount = parseInt(document.getElementById('amount').value);
        if (!amount || amount <= 0) {
            alert("Please enter a valid amount.");
            return;
        }

        fetch('/payment/create-order?amount=' + amount, { method: 'POST' })
            .then(res => res.json())
            .then(order => {
                if (order.error) {
                    alert("Error: " + order.error);
                    return;
                }

                let options = {
                    key: '${razorpayKey}',
                    amount: order.amount,
                    currency: order.currency,
                    name: "Trading App",
                    description: "Payment Transaction",
                    order_id: order.id,
                    handler: function (response) {
                        alert("Payment Successful. ID: " + response.razorpay_payment_id);
                    }
                };
                let rzp = new Razorpay(options);
                rzp.open();
            })
            .catch(err => alert("Failed to create order: " + err));
    }
</script>

</body>
</html>
