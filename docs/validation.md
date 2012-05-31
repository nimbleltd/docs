# Validation

>    alert: This section documents preliminary functionality. 
>    The functionality described below is still under development.

## Backlift collections and schemas

In backlift, the universal container is the collection. Collections are like tables in a database and are defined by a set of attributes, or fields. In backlift individual models in a table don't need to contain all the attributes of their sibling models. However, if any of the models in a collection contain an attribute, it will be considered a part of that collection's schema.

By default there are no validation rules on any models in backlift. Anything can be stored in a collection, and new collections can be created on the fly. This is useful during development when the data model of an application is changing regularly. Later, when the application is ready for production, schema validation rules may be applied to "lock down" the kinds of data that backlift accepts.

Backlift validation is currently an active area of development, so changes may occur frequently. Our apologies.

## Defining schemas

Currently backlift validation rules must be created using the .backlift configuration file. Here is an example section of the .backlift file that sets up some validation rules:

    collections:
      tweets:
        message: {type: 'string', max: 140, required: yes}
        _public_permissions: {default: 'r', readonly: yes}

Each sub group under 'collections' defines a new collection. When an AJAX request is sent to a /backliftapp/collection URL, backlift searches for the collection in this list. When found, the data attributes are matched against the rule names in order to select a validation test. If the data passes the test for all attributes, the operation is permitted. 

For a discussion of the permissions attributes used during authorization, see the [authorization](authorization.html) section.

The syntax for defining a new rule is:

    <field name>: {[type: '<rule type>',] <parameter name>: <value> [...]}

If the rule 'type' is omitted, it will be assumed to be a 'string'.

## Validation errors

If one or more validation tests fail, backlift will return a 403 response along with a JSON object containing error data. The error data structure will look like this:

    {"form_errors": {
    	"message": ["exceeds 140 character limit"],
    	"otherfield": ["required"],
    	"": ["other problems"],
    }}

Each attribute of the 'form_errors' hash is a field name, and the value is a list of error messages. The empty string attribute indicates form-wide errors.

## Validation rule reference

The following is a list of validation rule types, and their type specific parameters.

*   '**auto:current_user**':
    A string with the current user will be substituted for the value of this attribute. This rule implies that the attribute is read-only.

*   '**auto:uuid**':
    A string that matches the regex pattern '^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$'. A random uuid matching this pattern will be substituted for this attribute's value when the object is initially created.

*   '**auto:unique_uuid**':
    A string that matches the regex pattern '^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$'. A random uuid will be substituted for this attribute's value when the object is initially created. This value will be unique amongst values for this attribute on this collection.

*   '**auto:datetime**':
    The current date and time in ISO standard format will be substituted for this attribute's value when the object is first created.

*   '**string**' (min, max):
    A string with an optional minimum and maximum length. This is the default validation type for all rules.

This list is incomplete at this time. We will update this list as new validation rules are created.

We realize that it is impossible to perform all server side data validation using a predetermined finite set of validation rules. Our goal is not to cover all possibilities. We are currently working to define a reasonable set that covers as much territory as possible. We are also evaluating alternatives on how to handle more custom validation needs.


## Common validation rule parameters

All validation rules accept the generic parameters 'default', 'requred' and 'readonly'. 

* The 'default' parameter sets the value if no value is specified for an attribute.

* The 'required' parameter will ensure that a value is supplied for an attribute if set. (The value cannot be the empty string, nor can the attribute be absent entirely.)

* The 'readonly' parameter will cause the server to quietly reject any changes made to that attribute if set.

A common pattern is to set a value for the 'default' parameter, and set 'readonly' to 'yes'. This has the same effect of setting a fixed value for an attribute. All new objects created with these parameters will have the default value set for this attribute, which cannot be changed. This technique is effective for setting permissions on objects. See the [authorization](authorization.html) section for further discussion.

## Null values vs. the empty string

There are no null values in backlift, only the empty string. (Similarly, there is no Dana, only Zuul.)

