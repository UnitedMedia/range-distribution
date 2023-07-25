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
  "displayName": "Range distribution",
  "categories": ["ANALYTICS", "UTILITY"],
  "description": "The custom template will automatically categorize numeric input into specific ranges, based on user-defined parameters. Using this template you’ll quickly and easily categorize numeric data.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "minValue",
    "displayName": "Start Value",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_NEGATIVE_NUMBER"
      }
    ],
    "help": "Numeric value must be a positive integer or 0",
    "valueHint": "e.g. 0"
  },
  {
    "type": "TEXT",
    "name": "maxValue",
    "displayName": "Maximum Value",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      }
    ],
    "help": "Numeric value must be a positive integer \u003e 0",
    "valueHint": "e.g. 500"
  },
  {
    "type": "TEXT",
    "name": "distribValue",
    "displayName": "Step Size",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_NEGATIVE_NUMBER"
      }
    ],
    "help": "Numeric value must be a positive integer \u003e 0 but lower than maximum value",
    "valueHint": "e.g. 50"
  },
  {
    "type": "TEXT",
    "name": "valueInput",
    "displayName": "Input Value",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NUMBER"
      }
    ],
    "help": "Values to be used in values ranges",
    "valueHint": "e.g 100"
  },
  {
    "type": "TEXT",
    "name": "units",
    "displayName": "Units",
    "simpleValueType": true,
    "help": "Units to be diplayed",
    "valueHint": "e.g. USD"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

//Require APIs
 const makeString = require('makeString');
 const makeNumber = require('makeNumber');

//Access Tag Values
 let valueInput = makeNumber(data.valueInput);
 let minValue = makeNumber(data.minValue);
 let maxValue = makeNumber(data.maxValue);
 let distribValue = makeNumber(data.distribValue);
 let units = makeString(data.units);

if (units == 'undefined') { units = ''; }

  if (valueInput >= minValue && valueInput <= maxValue) {
    let intervalStart = minValue;
    while (intervalStart <= maxValue) {
      let intervalEnd = intervalStart + distribValue - 1;
      if (intervalEnd + 1 >= maxValue) { intervalEnd = maxValue; }
      if (valueInput >= intervalStart && valueInput <= intervalEnd) {
        return intervalStart + " - " + intervalEnd + " " + units;
      }
      intervalStart += distribValue;
    }
  } else if (valueInput < minValue) {
      return "< " + minValue + " " + units;
  } else if(valueInput > maxValue) {
      return "> " + maxValue + " " + units;
  }

  return undefined;


___TESTS___

scenarios:
- name: test when input value equals start value
  code: |-
    const mockData = {
      minValue: '0',
      maxValue: '500',
      distribValue: '50',
      valueInput: '0',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value equals max value
  code: |-
    const mockData = {
      minValue: '0',
      maxValue: '500',
      distribValue: '50',
      valueInput: '500',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value higher than max value
  code: |-
    const mockData = {
      minValue: '0',
      maxValue: '500',
      distribValue: '50',
      valueInput: '525',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value lower than max value
  code: |-
    const mockData = {
      minValue: '0',
      maxValue: '500',
      distribValue: '50',
      valueInput: '325',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value lower than start value
  code: |-
    const mockData = {
      minValue: '50',
      maxValue: '500',
      distribValue: '50',
      valueInput: '23',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value lower than max value and start value equals max value
  code: |-
    const mockData = {
      minValue: '500',
      maxValue: '500',
      distribValue: '50',
      valueInput: '395',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value lower than max value and start value higher than max
    value
  code: |-
    const mockData = {
      minValue: '525',
      maxValue: '500',
      distribValue: '50',
      valueInput: '395',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value lower than max value and step size equals max value
  code: |-
    const mockData = {
      minValue: '0',
      maxValue: '500',
      distribValue: '500',
      valueInput: '395',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value lower than max value and step size higher than max value
  code: |-
    const mockData = {
      minValue: '0',
      maxValue: '500',
      distribValue: '545',
      valueInput: '395',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when input value lower than max value and start value higher than 0
  code: |-
    const mockData = {
      minValue: '30',
      maxValue: '500',
      distribValue: '50',
      valueInput: '75',
      units: 'USD'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: test when no currency is added
  code: |-
    const mockData = {
      minValue: '30',
      maxValue: '500',
      distribValue: '50',
      valueInput: '75',
      units: ''
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);


___NOTES___
WEB:https://unitedmedia.ro/
Created on 6/26/2023, 11:09:52 PM


