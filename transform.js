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
    var allProds = data.row;
    var updateProds = [];
    allProds.forEach(function(element){

        //exlude disabled products
        if(element.status == 1) {
            var images = [];

            //get children if any
            var children = allProds.filter(function (filtered) {
                if(filtered.status == 1) {
                    var parentIds = filtered.parent_ids.split(',');
                    return parentIds.indexOf(element.entity_id) !== -1;
                } else {
                    return false;
                }
            });

            if (children.length !== 0) {
                /*
                 * If size_variations_value no longer uses 'oz', then
                 * we can remove this foreach loop;
                 *
                 * also get children images for parent
                 */
                children.forEach(function (child, i, childrenArr) {
                    let volume = parseFloat(child.size_variations_value);
                    if (!isNaN(volume)) {
                        child.size_variations_value = volume;
                    }

                    //remove path for child images
                    child.image = child.image.split('\\').pop().split('/').pop();
                });


                element.child = children;
            }

            //remove path from image
            element.image = element.image.split('\\').pop().split('/').pop();

            //convert franchise/collection value to lowercase with underscores
            let lowerCase = element.franchise_value.toLowerCase();
            element.franchise_value = lowerCase.split(' ').join('_');

            //add updated element to updated product array
            updateProds.push(element);
        }
    });

    data.row = updateProds;
    return data;

}

// function editImages(data) {
//     var allProds = data.row;
//     var updateProds = [];
//
//     allProds.forEach(function(element){
//         var image = element.image.split('\\').pop().split('/').pop() ;
//         if(image.length !== 0) {
//             element.images = [];
//             var imageObj = {imageFilename: image};
//             element.images.push(imageObj);
//         }
//         updateProds.push(element);
//
//     });
//     data.row = updateProds;
//     return data;
// }
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
        libxslt.parseFile('./products_master.xsl', function (err, stylesheet) {
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