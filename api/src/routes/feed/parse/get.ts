import { FastifyPluginAsync } from 'fastify';
import RSSParser from 'rss-parser';

const root: FastifyPluginAsync = async (fastify, opts): Promise<void> => {
	fastify.get<{
		Querystring: { url?: string; type?: 'podcast' | 'news' };
	}>(
		'/',
		{
			schema: {
				description: 'Parse a feed',
				tags: ['feed'],
				querystring: {
					type: 'object',
					properties: {
						url: { type: 'string' },
						type: { type: 'string' }
					}
				}
			}
		},
		async function (request, reply) {
			if (request.query.url === undefined)
				return reply.badRequest('Please provide a "url" query string.');

			const parser = new RSSParser();
			return await parser.parseURL(request.query.url);
		}
	);
};

export default root;
