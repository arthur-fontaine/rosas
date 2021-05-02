export interface INewsAPI {
	results: Result[];
	queryType: string;
	scheme: string;
}

interface Result {
	feedId: string;
	lastUpdated: number;
	score: number;
	coverage: number;
	averageReadTime: number;
	coverageScore: number;
	estimatedEngagement: number;
	tagCounts: { [key: string]: number };
	totalTagCount: number;
	websiteTitle: string;
	id: string;
	title: string;
	topics: string[];
	updated: number;
	velocity: number;
	subscribers: number;
	website: string;
	iconUrl: string;
	partial: boolean;
	coverUrl: string;
	visualUrl: string;
	contentType: string;
	language: string;
	description: string;
	coverColor: string;
	deliciousTags: string[];
	twitterScreenName?: string;
	twitterFollowers?: number;
}
