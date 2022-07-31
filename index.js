// def lambda_handler(event, context):
//     responseMsg = {
//         'statusCode' : '200',
//         'body': 'Hello world',
//         'headers' : {
//             'Access-Control-Allow-Origin' : '*'
//         }
//     return responseMsg

// exports.handler = async (event) => {
//     //TODO implement
//     const response = {
//       statusCode: 200,
//       headers: {
//         "Access-Control-Allow-Origin": "*",
//       },
//       body: JSON.stringify("Hello from Lambda!"),
//     };
//     return response;
//   };

const healthPath = "/health";
const registerPath = "/register";
const loginPath = "/login";
const verifyPath = "/verify";

exports.handler = async (event) => {
  console.log("Request Event: ", event);
  let response;
  switch (true) {
    case event.httpMethod === "GET" && event.path === healthPath:
      response = buildResponse(200);
      break;
    // case event.httpMethod === 'POST' && event.path === registerPath:
    //     response = buildResponse(200)
    //     break;
    // case event.httpMethod === 'POST' && event.path === loginPath:
    //     response = buildResponse(200)
    //     break;
    // case event.httpMethod === 'POST' && event.path === verifyPath:
    //     response = buildResponse(200)
    //     break;
    default:
      response = buildResponse(404, "404 not found");
  }
  return response;
};

function buildResponse(statusCode, body) {
  return {
    statusCode: statusCode,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  };
}
