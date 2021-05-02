import axios from 'axios';
import { INewsAPI } from '../../../types/api/feedly/News';
import { IPodcastsAPI } from '../../../types/api/itunes/Podcast';

export const news = async (term: string) => {
	const response = await axios.get<INewsAPI>(
		`https://cloud.feedly.com/v3/search/feeds?query=${term}`
	);
	return response.data;
};

export const podcasts = async (term: string) => {
	const response = await axios.get<IPodcastsAPI>(
		`https://itunes.apple.com/search?term=${term}&media=podcast`
	);
	return response.data;
};
