export interface Feed {
	title: string;
	feedUrl: string;
	iconUrl: string;
	website?: string;
	author?: string;
	lastUpdated: Date;
	type: 'news' | 'podcasts';
}
