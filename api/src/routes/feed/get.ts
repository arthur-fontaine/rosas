import { FastifyPluginAsync } from 'fastify';
import * as search from './../../utils/search';
import * as normalize from './../../utils/normalize';
import { Feed } from '../../../types/Feed';

const root: FastifyPluginAsync = async (fastify, opts): Promise<void> => {
	fastify.get<{
		Querystring: { q?: string; type?: 'podcasts' | 'news' };
	}>(
		'/',
		{
			schema: {
				description: 'Search for a feed',
				tags: ['feed'],
				querystring: {
					type: 'object',
					properties: {
						q: { type: 'string' },
						type: { type: 'string' }
					}
				}
			}
		},
		async function (request, reply) {
			if (request.query.q === undefined)
				return reply.badRequest('Please provide a "q" query string.');

			if (request.query.type !== undefined)
				if (request.query.type !== 'podcasts' && request.query.type !== 'news')
					return reply.badRequest(
						'Please provide a correct "type" query string.'
					);

			let feeds: Feed[];

			if (request.query.type === 'podcasts')
				feeds = normalize.podcasts(await search.podcasts(request.query.q));
			else if (request.query.type === 'news')
				feeds = normalize.news(await search.news(request.query.q));
			else {
				feeds = Array.prototype.concat(
					normalize.podcasts(await search.podcasts(request.query.q)),
					normalize.news(await search.news(request.query.q))
				);
			}

			return reply.send(feeds);
		}
	);
};

export default root;
