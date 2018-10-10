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
        quote: false,
        trim: true,
        workerNum: 2,
        checkColumn: true
    });
    converter.fromString(csvString, (err, result) => {
        if (_.isNil(err) && result.length > 0) {
            const jsonString = JSON.stringify({row: result})
            var object = JSON.parse(jsonString);
            var t = transform(object);
            const xmlString = jsonParse('csv_root_node', t);
            libxslt.parseFile('./example.xsl', function (err, stylesheet) {
                else {
                    stylesheet.apply(xmlString, function (err, res) {
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