const express = require('express');
const router = express.Router();
const axios = require('axios');

router.post('/payment', async (req, res) => {
    const url = "https://sandbox.paymee.tn/api/v2/payments/create"; 
    const payload = {
        "amount": req.body.amount,
        "note": "Payment for BridgeWear", 
        "first_name": req.body.first_name,
        "last_name": req.body.last_name,
        "email": req.body.email,
        "phone": req.body.phone,
        // The return URL is now a HTTPS page that will trigger the deep link redirection
        "return_url": `https://bridgewear.com/payment-success?id=${req.body.idprd}&status=true`,
        "cancel_url":  `https://bridgewear.com/payment-success?id=${req.body.idprd}&status=false`,  // Optional: You can handle cancellations here
        "webhook_url": "https://yourwebsite.com/webhook",  // Your server's webhook to handle Paymee's callback
    };

    try {
        // Send request to Paymee API
        const response = await axios.post(url, payload, {
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Token dde1e14c00b8a1bb3960988ce1fe106b3fb055b6"
            }
        });

        // Respond with the Paymee payment URL or further details
return res.status(200).json(response.data);
    } catch (error) {
        console.error("Request failed:", error.response.data);
        res.status(400).send("Bad request: " + error.response.data);
    }
});

module.exports = router;
