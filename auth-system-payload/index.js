// def lambda_handler(event, context):
//     responseMsg = {
//         'statusCode' : '200',
//         'body': 'Hello world',
//         'headers' : {
//             'Access-Control-Allow-Origin' : '*'
//         }
//     return responseMsg

exports.handler = async (event) => {
  //TODO implement
  const response = {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
    body: JSON.stringify("Hello from Lambda!"),
  };
  return response;
};
