const functions = require('@google-cloud/functions-framework');

// Register an HTTP function with the Functions Framework that will be executed
// when you make an HTTP request to the deployed function's endpoint.
functions.http('secretGET', (req, res) => {
  fs.readFileSync('/secrets/my-cldfun-secret/versions/latest');
  res.send('test')
});
