const _ = require('lodash');
var getStdin = require('get-stdin');
const libxslt = require('libxslt');
var parseString = require('xml2js').parseString;
var date = require('date-and-time');

const Json2csvParser = require('json2csv').Parser;
const fields = ['ORDER_TYPE', 'ORDER_TERMS','ORDER_NUMB','ORDER_CALLER','MARKFOR_NAME','ORDER_DATE','DATE_ENTERED','DUEOUT_DATE','CUST_REQ_DATE','CUST_COUNTRY','SHIPTO_CODE','SHIPTO_PO','SHIPNAME','SHIPADD1','SHIPADD2','SHIPCITY','SHIPST','SHIPZIP','SHIPCOUNTRY','SHIPPHONE','SHIPTO_EMAIL','CUST_PO','ROUTE_CODE','MET_OF_SHIP','CARR_CODE','HDR_COST_CTR','CUST_CODE','BILLTO_CODE','BILLNAME','BILLADD1','BILLCITY','BILLST','BILLZIP','BILLCOUNTRY','BILLPHONE','NOTES1','ITEM_NO','ITEM_TYPE','PART_CODE','QTY','ITEM_PRICE','ITEM_DISCOUNT','DISCNT','SHIPCHG','PAYMENT_AMT','GIFT_CERT_AMT','GIFT_CERT_TYPE','GIFT_CARD_MEMO','ITEM_DISC_TYPE','VOLDIS_SO','PAYMENT_TYPE','CARD_APPROVAL','HDR_NUMFLD3'];
const json2csvParser = new Json2csvParser({ fields });
var warehouse = {
    'FN': 'FDX',
    'FI':'FDXC',
    'MAGA':'FDRP',
    'HOTX':'FDRP',
    'OCFL':'FDRP'
};

var methodOfShipment = {
    'FEDEX_GROUND_HOME_DELIVERY': 'FGR',
    'FEDEX_STANDARD_OVERNIGHT': 'FS',
    'FEDEX_PRIORITY_OVERNIGHT':'FP',
    'FEDEX_BACKUP':'FP'
};

var saturdayMethodOfShip = {
    'FEDEX_GROUND_HOME_DELIVERY': 'FGR',
    'FEDEX_STANDARD_OVERNIGHT': 'FSAT',
    'FEDEX_PRIORITY_OVERNIGHT':'FSAT',
    'FEDEX_BACKUP':'FSAT'
};

/**
 *
 *
 * @param data
 * @returns {}
 */
function transform(order) {
    var orderArray = [];

        try {
            //array of order information to be returned
            var giftCertAmt,
                paymentAmt = '0.00',
                transactionId,
                paymentType = 'N';

            var customer = order.customer[0];
            var shipment = order['shipments'][0];
            var ships = order['shipments'][0]['shipment'][0];

            var customShipAttributes = shipment.shipment[0]['custom-attributes'][0]['custom-attribute'];
            var customShip = {};
            customShipAttributes.forEach(function (element) {
                customShip[element['$']['attribute-id']] = element['_'];
            });

            if (customShip.hasOwnProperty('routeCode')) {
                var carCode = warehouse[customShip.routeCode];
            }
            var deliverDate = new Date(customShip.deliverDate);
            var orderCallerDate = date.format(deliverDate, 'M/D');
            var formattedDeliveryDate = date.format(deliverDate, 'M/D/YY');

            if(customShip.hasOwnProperty('shipDate')) {
                var shipDate = new Date(customShip.shipDate);
                var formattedShipDate = date.format(shipDate, 'M/D/YY');
            } else {
                throw Error;
            }

            var orderdate = order['order-date'][0];
            var orderDate = new Date(orderdate);
            var formattedOrderDate = date.format(orderDate, 'M/D/YY');

            var shippingMethod = ships['shipping-method'][0];

            var dayOfWeek = date.format(deliverDate, 'dd');
            if (dayOfWeek === 'Sa') {
                if (saturdayMethodOfShip.hasOwnProperty(shippingMethod)) {
                    var methOfShip = saturdayMethodOfShip[shippingMethod];
                }
            } else if (methodOfShipment.hasOwnProperty(shippingMethod)) {
                var methOfShip = methodOfShipment[shippingMethod];
            } else {
                var methOfShip = 'FP'
            }

            var customerEmail = customer['customer-email'][0];
            var billingAddress = customer['billing-address'][0];
            var billingName = billingAddress['first-name'][0] + ' ' + billingAddress['last-name'][0];
            var billingAddress1 = billingAddress['address1'][0];
            if (billingAddress.hasOwnProperty('address2')) {
                var billingAddress2 = billingAddress['address2'];
            }
            var billingPostalCode = billingAddress['postal-code'][0];
            var billingStateCode = billingAddress['state-code'][0];
            var billingCountryCode = billingAddress['country-code'][0];
            if (billingCountryCode === 'US') {
                billingCountryCode = billingCountryCode + 'A';
            }
            var billingPhone = billingAddress['phone'][0];
            var billingCity = billingAddress['city'][0];
            var orderNo = order['$']['order-no'];

            var shipAddress = shipment.shipment[0]['shipping-address'][0];

            var fullName = shipAddress['first-name'][0];
            var stateCode = shipAddress['state-code'][0];
            var city = shipAddress['city'][0];
            var postalCode = shipAddress['postal-code'][0];
            var phone = shipAddress['phone'][0];
            var address1 = shipAddress['address1'][0];

            if (shipAddress.hasOwnProperty('address2')) {
                var address2 = shipAddress['address2'][0];
            }
            var countryCode = shipAddress['country-code'][0];

            if (countryCode === 'US') {
                countryCode = countryCode + 'A';
            }

            order.payments.forEach(function (payment) {
                payment.payment.forEach(function (paymentChild) {
                    if (paymentChild.hasOwnProperty('gift-certificate')) {
                        giftCertAmt = paymentChild.amount[0];
                        transactionId = paymentChild['transaction-id'][0];
                    } else if (paymentChild.hasOwnProperty('credit-card')) {
                        paymentAmt = paymentChild.amount[0];
                        transactionId = paymentChild['transaction-id'][0];
                        paymentType = paymentChild['credit-card'][0]['card-type'][0] === 'AMEX' ? 'A' : 'N';
                    }
                });
            });

            var netMerchandizeTotal = order.totals[0]['adjusted-merchandize-total'][0]['net-price'][0];

            var shippingNetPrice = order['shipping-lineitems'][0]['shipping-lineitem'][0]['net-price'][0];

            var productLineItems = order['product-lineitems'][0]['product-lineitem'];

            productLineItems.forEach(function (productLineItem) {
                let priceAdjustment = 0.00,
                    discountType = '';

                if (productLineItem.hasOwnProperty('price-adjustments')) {
                    let adjustment = productLineItem['price-adjustments'][0]['price-adjustment'][0];
                    priceAdjustment = adjustment['base-price'][0] * -1.00;
                    if (adjustment.hasOwnProperty('lineitem-text')) {
                        var text = adjustment['lineitem-text'][0];
                        if (text.indexOf('%') !== -1) {
                            discountType = '$'
                        } else {
                            discountType = '%'
                        }

                    }
                }
                let productId = productLineItem['product-id'][0],
                    quantity = productLineItem['quantity'][0]['_'],
                    productPrice = productLineItem['base-price'][0];

                var orderFields = {
                    'ORDER_TYPE': 'S',
                    'ORDER_TERMS': 'WEB',
                    'ORDER_NUMB': orderNo,
                    'ORDER_CALLER': orderNo + '-' + orderCallerDate,
                    'MARKFOR_NAME': "STOREFRONT",
                    'ORDER_DATE': formattedOrderDate,
                    'DATE_ENTERED': formattedOrderDate,
                    'DUEOUT_DATE': formattedShipDate,
                    'CUST_REQ_DATE': formattedDeliveryDate,
                    'CUST_COUNTRY': billingCountryCode,
                    'SHIPTO_CODE': "WEBSITE",
                    'SHIPTO_PO': orderNo,
                    'SHIPNAME': fullName,
                    'SHIPADD1': address1,
                    'SHIPADD2': address2 || '',
                    'SHIPCITY': city,
                    'SHIPST': stateCode,
                    'SHIPZIP': postalCode,
                    'SHIPCOUNTRY': countryCode,
                    'SHIPPHONE': phone,
                    'SHIPTO_EMAIL': customerEmail,
                    'CUST_PO': customShip.routeCode,
                    'ROUTE_CODE': customShip.routeCode,
                    'MET_OF_SHIP': methOfShip,
                    'CARR_CODE': carCode || '',
                    'HDR_COST_CTR': customShip.costCenter,
                    'CUST_CODE': "WEBSITE",
                    'BILLTO_CODE': "WEBSITE",
                    'BILLNAME': billingName,
                    'BILLADD1': billingAddress1,
                    'BILLCITY': billingCity,
                    'BILLST': billingStateCode,
                    'BILLZIP': billingPostalCode,
                    'BILLCOUNTRY': billingCountryCode,
                    'BILLPHONE': billingPhone,
                    'NOTES1': '',
                    'ITEM_NO': '10',
                    'ITEM_TYPE': 'S',
                    'PART_CODE': productId,
                    'QTY': quantity,
                    'ITEM_PRICE': productPrice,
                    'ITEM_DISCOUNT': priceAdjustment,
                    'DISCNT': netMerchandizeTotal,
                    'SHIPCHG': shippingNetPrice,
                    'PAYMENT_AMT': paymentAmt,
                    'GIFT_CERT_AMT': giftCertAmt || '0.00',
                    'GIFT_CERT_TYPE': giftCertAmt ? 'R' : 'N',
                    'GIFT_CARD_MEMO': giftCertAmt ? 'test memo' : '',
                    'ITEM_DISC_TYPE': discountType,
                    'VOLDIS_SO': '%',
                    'PAYMENT_TYPE': paymentType,
                    'CARD_APPROVAL': transactionId,
                    'HDR_NUMFLD3': transactionId
                };

                orderArray.push(orderFields);
            });
    } catch(e) {

    }
    return orderArray;
}

getStdin().then(function(xmlString) {
    try {
        parseString(xmlString, function (err, result) {
            var orderArrayMerge = [];
            if (result.hasOwnProperty('orders') && result.orders.hasOwnProperty('order')) {
                result.orders.order.forEach(function (order) {
                    // var csv = transform(order);
                     let orderArr = transform(order);

                     orderArrayMerge.push.apply(orderArrayMerge,orderArr);
                });
            }
            var csv = json2csvParser.parse(orderArrayMerge);
            console.log(csv);

        });
    }catch(e) {
        console.log(e);
    }
});