const functions = require('@google-cloud/functions-framework');

// Register an HTTP function with the Functions Framework that will be executed
// when you make an HTTP request to the deployed function's endpoint.
functions.http('secretGET', (req, res) => {
  SECRET_ENV_VAR='projects/myprojec21/secrets/my-cldfun-secret/versions/2'
  res.send($SECRET_ENV_VAR)
});
