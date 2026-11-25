    const mongoose = require('mongoose');

    const Product = mongoose.model('Product', {
        sellingPrice: {
            type: Number
        },
        originalPrice: {
            type: Number
        },
        name: {
            type: String
        },
        state: {
            type: String
        },
        description: {
            type: String
        },
        sex: {
            type: String,
        },
        idcateg: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'departement'},
        idcolor: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'color'
        },
        size: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Size'        },
        idbrand: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'brand'            }
        ,
        iduser :{
            type: mongoose.Schema.Types.ObjectId,  
            ref: 'user'

        },
        pourcentage :{
            type: Number,
        }
    });

    module.exports = Product;
