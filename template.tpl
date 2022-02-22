___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "EEC to GA4 categories",
  "categories": ["UTILITY"],
  "description": "Returns a new items array with the Universal Analytics Enhanced Ecommerce category hierarchy converted to separate category parameters.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_SERVER___

const getEventData = require('getEventData');

const itemsData = getEventData('items');

const mapItemsData = i => {
  const category = i.item_category ? i.item_category.split('/') : [];
  const itemObj = {
    item_id: i.item_id,
    item_name: i.item_name,
    price: i.price,
    item_brand: i.item_brand,
    item_variant: i.item_variant,
    quantity: i.quantity
  };
  category.forEach((c, i) => {
    if (i === 0) itemObj.item_category = c;
    else itemObj['item_category' + (i + 1)] = c;
  });
  return itemObj;
};

if (itemsData) {
  return itemsData.map(mapItemsData);
}

return undefined;


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "items"
              }
            ]
          }
        },
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Converts EEC category hierarchy
  code: |-
    const mockData = {
    };

    mock('getEventData', [
      {
        item_id: "12345",
        item_name: "wimbledon day 1 : men’s and women’s 1st round",
        item_brand: "wimbledon 2021",
        item_category: "event tickets/tennis/grand slams",
        item_variant: "debenture seats - centre court",
        price: 1321.5,
        quantity: 1
      },
      {
        item_id: "67890",
        item_name: "blakemore hyde park hotel",
        item_brand: "blakemore",
        item_category: "hotels",
        item_variant: "double room",
        price: 216,
        quantity: 1
      }]);

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult[0].item_category).isEqualTo("event tickets");
    assertThat(variableResult[0].item_category2).isEqualTo("tennis");
    assertThat(variableResult[0].item_category3).isEqualTo("grand slams");
    assertThat(variableResult[0].item_category4).isUndefined();
    assertThat(variableResult[0].item_category5).isUndefined();
    assertThat(variableResult[1].item_category).isEqualTo("hotels");


___NOTES___

Created on 22/02/2022, 17:02:53


