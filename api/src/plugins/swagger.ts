import fp from 'fastify-plugin';
import swagger, { SwaggerOptions } from 'fastify-swagger';

/**
 * This plugins generates a Swagger documentation
 *
 * @see https://github.com/fastify/fastify-swagger
 */
export default fp<SwaggerOptions>(async (fastify, opts) => {
	fastify.register(swagger, {
		routePrefix: '/documentation',
		exposeRoute: true,
		swagger: {
			info: {
				title: 'Rosas',
				description: 'API of Rosas',
				version: '0.1.0'
			},
			schemes: ['http'],
			consumes: ['application/json'],
			produces: ['application/json'],
			tags: [{ name: 'feed', description: 'Feed related end-points' }],
			definitions: {
				Feed: {
					type: 'object',
					properties: {
						title: { type: 'string' },
						iconUrl: { type: 'string', format: 'url' },
						website: { type: 'string', format: 'url' },
						author: { type: 'string' },
						lastUpdated: { type: 'string', format: 'date-time' },
						type: { type: "'news' | 'podcasts'" }
					}
				}
			}
		}
	});
});
