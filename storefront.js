const _ = require('lodash');
var getStdin = require('get-stdin');
const Converter = require('csvtojson').Converter;
const libxslt = require('libxslt');
const jsonParse = require('js2xmlparser');

/**
 *
 *
 * @param data
 * @returns {}
 */
function transform(data) {
    return data;

}

getStdin().then(function(csvString) {
    const converter = new Converter({
        delimiter: "auto",
        checkType: false,
        trim: true,
        workerNum: 2,
        checkColumn: true,
        escape:true
    });
    converter.fromString(csvString, (err, result) => {
        if (_.isNil(err) && result.length > 0) {
            const jsonString = JSON.stringify({row: result});
            var object = JSON.parse(jsonString);
            var transformedObject = transform(object);

            // transformedObject = editImages(transformedObject);
            const xmlString = jsonParse.parse('csv_root_node', transformedObject);
            libxslt.parseFile('./products_storefront.xsl', function (err, stylesheet) {
                if(err) {
                    console.log(err);
                }
                else {
                    stylesheet.apply(xmlString, function (err, res) {
                        if(err) {
                            console.log(err);
                        }
                        else {
                            console.log(res);
                        }
                    });
                }
            });
        }
        else {
            console.log(err);
        }
    });

});