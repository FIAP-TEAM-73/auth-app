import { APIGatewayAuthorizerResult, APIGatewayRequestAuthorizerEventV2 } from 'aws-lambda';
import jwt from 'jsonwebtoken';

export const handler = async (event: APIGatewayRequestAuthorizerEventV2): Promise<APIGatewayAuthorizerResult> => {
    // Extract the bearer authorization token from the event
    console.log('handler', JSON.stringify(event));
    const authHeader = event.identitySource.find((source) => source.includes('Bearer'));
    if (!authHeader) {
        return {
            principalId: 'user',
            policyDocument: {
                Version: '2012-10-17',
                Statement: [
                    {
                        Action: 'execute-api:Invoke',
                        Effect: 'Deny',
                        Resource: event.routeArn,
                    },
                ],
            },
        };
    }
    const token = authHeader.split(' ')[1]!;

    try {
        const payload = jwt.verify(token, 'yourSecretKey');
        console.log('Authorizer', { payload });
    } catch (err) {
        console.error('Error verifying token', err);
        // Return an authorization response indicating the request is not authorized
        return {
            principalId: 'user',
            policyDocument: {
                Version: '2012-10-17',
                Statement: [
                    {
                        Action: 'execute-api:Invoke',
                        Effect: 'Deny',
                        Resource: event.routeArn,
                    },
                ],
            },
        };
    }

    // return an authorization response indicating the request is authorized
    return {
        principalId: 'user',
        policyDocument: {
            Version: '2012-10-17',
            Statement: [
                {
                    Action: 'execute-api:Invoke',
                    Effect: 'Allow',
                    Resource: event.routeArn,
                },
            ],
        },
    };
};
