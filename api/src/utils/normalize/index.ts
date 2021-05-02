import { Feed } from '../../../types/Feed';
import { IPodcastsAPI } from '../../../types/api/itunes/Podcast';
import { INewsAPI } from '../../../types/api/feedly/News';

export const podcasts = (podcasts: IPodcastsAPI): Feed[] => {
	return podcasts.results.map<Feed>((p) => {
		return {
			title: p.collectionName,
			iconUrl: p.artworkUrl600,
			author: p.artistName,
			lastUpdated: p.releaseDate,
			type: 'podcasts'
		};
	});
};

export const news = (news: INewsAPI): Feed[] => {
	return news.results.map<Feed>((n) => {
		return {
			title: n.title,
			iconUrl: n.iconUrl,
			website: n.website,
			lastUpdated: new Date(n.lastUpdated),
			type: 'news'
		};
	});
};
