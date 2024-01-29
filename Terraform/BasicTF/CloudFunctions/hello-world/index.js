/* Reference: https://github.com/terraform-google-modules/terraform-docs-samples/blob/main/functions/basic/functions/hello-world/index.js
const functions = require('@google-cloud/functions-framework');

functions.http('helloHttp', (req, res) => {
 res.send(`Hello ${req.query.name || req.body.name || 'World'}!`);
});
