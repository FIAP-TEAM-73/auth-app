import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import jwt from 'jsonwebtoken';
/**
 *
 * Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format
 * @param {Object} event - API Gateway Lambda Proxy Input Format
 *
 * Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
 * @returns {Object} object - API Gateway Lambda Proxy Output Format
 *
 */
const uri = process.env.TECH_CHALLENGE_URI;

export const lambdaHandler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
    try {
        if (!event.body) {
            return {
                statusCode: 400,
                body: JSON.stringify({
                    message: 'Request body is empty',
                }),
            };
        }
        const cpf = JSON.parse(event.body).cpf;
        const response: { isCustomer: boolean } = await fetch(`${uri}/customer/${cpf}`).then((response) =>
            response.json(),
        );
        if (!response.isCustomer) {
            return {
                statusCode: 404,
                body: JSON.stringify({
                    message: 'Customer not found',
                }),
            };
        }
        return {
            statusCode: 200,
            body: JSON.stringify({
                token: generateToken(cpf),
            }),
        };
    } catch (err) {
        console.log(err);
        return {
            statusCode: 500,
            body: JSON.stringify({
                message: 'some error happened',
            }),
        };
    }
};

const generateToken = (payload: string) => {
    const secretKey = 'yourSecretKey'; // Replace with your own secret key
    const options = {
        expiresIn: '10m', // Token expiration time
    };
    return jwt.sign({ payload }, secretKey, options);
};
