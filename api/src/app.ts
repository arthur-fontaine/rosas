import { join } from 'path';
import AutoLoad, { AutoloadPluginOptions } from 'fastify-autoload';
import { FastifyPluginAsync } from 'fastify';

const app: FastifyPluginAsync = async (fastify, opts): Promise<void> => {
	void fastify.register(AutoLoad, {
		dir: join(__dirname, 'plugins'),
		options: opts
	});

	void fastify.register(AutoLoad, {
		dir: join(__dirname, 'routes'),
		options: opts,
		routeParams: true
	});
};

export default app;
export { app };
