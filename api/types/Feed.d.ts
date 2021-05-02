export interface Feed {
	title: string;
	iconUrl: string;
	website?: string;
	author?: string;
	lastUpdated: Date;
	type: 'news' | 'podcasts';
}
