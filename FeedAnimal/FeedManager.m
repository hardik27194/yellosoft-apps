//
//  FeedManager.m
//  FeedAnimal
//
//  Created by Andrew Pennebaker on 10 Mar 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "FeedManager.h"

@implementation FeedManager

// From ThinkMac Software
// http://www.thinkmac.co.uk/blog/2005/05/removing-entities-from-html-in-cocoa.html
+(NSString*) decodeCharacterEntities: (NSString*) source {
	if (!source) {
		return nil;
	}
	else if ([source rangeOfString: @"&"].location==NSNotFound) {
		return source;
	}
	else {
		NSMutableString *escaped=[NSMutableString stringWithString:source];
		NSArray *codes=[NSArray arrayWithObjects:
			@"&nbsp;", @"&iexcl;", @"&cent;", @"&pound;", @"&curren;", @"&yen;", @"&brvbar;",
			@"&sect;", @"&uml;", @"&copy;", @"&ordf;", @"&laquo;", @"&not;", @"&shy;", @"&reg;",
			@"&macr;", @"&deg;", @"&plusmn;", @"&sup2;", @"&sup3;", @"&acute;", @"&micro;",
			@"&para;", @"&middot;", @"&cedil;", @"&sup1;", @"&ordm;", @"&raquo;", @"&frac14;",
			@"&frac12;", @"&frac34;", @"&iquest;", @"&Agrave;", @"&Aacute;", @"&Acirc;",
			@"&Atilde;", @"&Auml;", @"&Aring;", @"&AElig;", @"&Ccedil;", @"&Egrave;",
			@"&Eacute;", @"&Ecirc;", @"&Euml;", @"&Igrave;", @"&Iacute;", @"&Icirc;", @"&Iuml;",
			@"&ETH;", @"&Ntilde;", @"&Ograve;", @"&Oacute;", @"&Ocirc;", @"&Otilde;", @"&Ouml;",
			@"&times;", @"&Oslash;", @"&Ugrave;", @"&Uacute;", @"&Ucirc;", @"&Uuml;", @"&Yacute;",
			@"&THORN;", @"&szlig;", @"&agrave;", @"&aacute;", @"&acirc;", @"&atilde;", @"&auml;",
			@"&aring;", @"&aelig;", @"&ccedil;", @"&egrave;", @"&eacute;", @"&ecirc;", @"&euml;",
			@"&igrave;", @"&iacute;", @"&icirc;", @"&iuml;", @"&eth;", @"&ntilde;", @"&ograve;",
			@"&oacute;", @"&ocirc;", @"&otilde;", @"&ouml;", @"&divide;", @"&oslash;", @"&ugrave;",
			@"&uacute;", @"&ucirc;", @"&uuml;", @"&yacute;", @"&thorn;", @"&yuml;", nil
		];

		int count=[codes count];

		// Html
		int i;
		for (i=0; i<count; i++) {
			NSRange range=[source rangeOfString:[codes objectAtIndex:i]];
			if (range.location!=NSNotFound) {
				[escaped
					replaceOccurrencesOfString:[codes objectAtIndex:i]
					withString:[NSString stringWithFormat:@"%C", 160+i]
					options:NSLiteralSearch
					range:NSMakeRange(0, [escaped length])
				];
			}
		}

		// Decimal & Hex
		NSRange start, finish, searchRange=NSMakeRange(0, [escaped length]);

		i=0;
		while (i<[escaped length]) {
			start=[escaped
				rangeOfString:@"&#"
				options: NSCaseInsensitiveSearch 
				range: searchRange
			];

			finish=[escaped
				rangeOfString:@";"
				options:NSCaseInsensitiveSearch
				range:searchRange
			];

			if (start.location!=NSNotFound && finish.location!=NSNotFound && finish.location>start.location) {
				NSRange entityRange=NSMakeRange(start.location, (finish.location-start.location)+1);
				NSString *entity=[escaped substringWithRange:entityRange];
				NSString *value=[entity substringWithRange:NSMakeRange(2, [entity length]-2)];

				[escaped deleteCharactersInRange:entityRange];

				if ([value hasPrefix:@"x"]) {
					int tempInt=0;
					NSScanner *scanner=[NSScanner scannerWithString:[value substringFromIndex:1]];
					[scanner scanHexInt:&tempInt];
					[escaped insertString:[NSString stringWithFormat:@"%C", tempInt] atIndex:entityRange.location];
				}
				else {
					[escaped insertString:[NSString stringWithFormat: @"%C", [value intValue]] atIndex: entityRange.location];
				}

				i=start.location;
			}
			else {
				i++;
			}

			searchRange=NSMakeRange(i, [escaped length]-i);
		}

		return [escaped retain]; // Note this was autoreleased before.
	}
}

// From Karelia Software
// http://cocoa.karelia.com/Foundation_Categories/NSString/_Flatten__a_string_.m
+(NSString*) flattenHTML: (NSString*) text {
	NSString *result=@"";

	if (![text isEqualToString:@""]) { // if empty string, don't do this!  You get junk.
		// HACK -- IF SHORT LENGTH, USE MACROMAN -- FOR SOME REASON UNICODE FAILS FOR "" AND "-" AND "CNN" ...

		int encoding=([text length]>3) ? NSUnicodeStringEncoding:NSMacOSRomanStringEncoding;
		NSAttributedString *attrString;
		NSData *theData=[text dataUsingEncoding:encoding];
		if (nil!=theData) { // this returned nil once; not sure why; so handle this case.
			NSDictionary *encodingDict=[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:encoding] forKey:@"CharacterEncoding"];
			attrString=[[NSAttributedString alloc] initWithHTML:theData documentAttributes:&encodingDict];
			result=[[[attrString string] retain] autorelease]; // keep only this
			[attrString release]; // don't do autorelease since this is so deep down.
		}
	}

	return result;
}

+(NSString*) clean: (NSString*) text {
	return [FeedManager flattenHTML:[FeedManager decodeCharacterEntities:text]];
}

-(void) setStories: (NSMutableArray*) a {
	stories=[a retain];
}

-(FeedManager*) init {
	self=[super init];
	[self setMaxItems:10];
	[self setStories:
		[[NSMutableArray arrayWithCapacity:10] retain]
	];

	return self;
}

-(void) setMaxItems: (int) max {
	maxItems=max;
}

-(int) getMaxItems {
	return maxItems;
}

+(BOOL) isRSS: (NSXMLDocument*) xmlDoc {
	return [[[xmlDoc rootElement] name] isEqualToString:@"rss"];
}

+(BOOL) isAtom: (NSXMLDocument*) xmlDoc {
	return [[[xmlDoc rootElement] name] isEqualToString:@"feed"];
}

// From DiggUpdate Controller.m
-(NSMutableArray*) loadFeed: (NSString*) url {
	NSMutableArray *items=[[NSMutableArray alloc] initWithCapacity:10];

	NSXMLDocument *xmlDoc=[[NSXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:url] options:nil error:nil];
	if(xmlDoc!=nil) {
		if ([FeedManager isRSS:xmlDoc]) {
			NSArray *xmlItems=[[[[xmlDoc rootElement] elementsForName:@"channel"] objectAtIndex:0] elementsForName:@"item"];
			int count=[xmlItems count];

			int i;
			for (i=0; i<count && i<maxItems; i++) {
				NSXMLElement *rssItem=[xmlItems objectAtIndex:i];
				NSString *title=[[[rssItem elementsForName:@"title"] objectAtIndex:0] stringValue];
				title=[FeedManager clean:title];
				NSString *link=[[[rssItem elementsForName:@"link"] objectAtIndex:0] stringValue];
				NSString *description=[[[rssItem elementsForName:@"description"] objectAtIndex:0] stringValue];
				description=[FeedManager clean:description];

				NSDictionary *item=[NSDictionary dictionaryWithObjectsAndKeys:
					title, @"title",
					link, @"link",
					description, @"description",
					nil
				];

				[items addObject:item];
			}
		}
		else if ([FeedManager isAtom:xmlDoc]) {
			NSArray *xmlEntries=[[xmlDoc rootElement] elementsForName:@"entry"];
			int count=[xmlEntries count];

			int i;
			for (i=0; i<count && i<maxItems; i++) {
				NSXMLElement *atomEntry=[xmlEntries objectAtIndex:i];
				NSString *title=[[[atomEntry elementsForName:@"title"] objectAtIndex:0] stringValue];
				title=[FeedManager clean:title];
				NSString *link=[[[atomEntry elementsForName:@"link"] objectAtIndex:0] stringValue];
				NSString *description=[[[atomEntry elementsForName:@"summary"] objectAtIndex:0] stringValue];
				description=[FeedManager clean:description];

				NSDictionary *item=[NSDictionary dictionaryWithObjectsAndKeys:
					title, @"title",
					link, @"link",
					description, @"description",
					nil
				];

			[items addObject:item];
			}
		}

		[xmlDoc release];
	}

	return items;
}

-(int) getStoryIndexForLink: (NSString*) link {
	int i;
	for (i=0; i<[stories count]; i++) {
		NSDictionary *story=[stories objectAtIndex:i];
		NSString *tempLink=[story objectForKey:@"link"];
		if ([tempLink isEqualToString:link]) {
			return i;
		}
	}

	return -1;
}

-(NSMutableArray*) selectNewStories: (NSMutableArray*) feed {
	NSMutableArray *newStories=[NSMutableArray arrayWithCapacity:10];
	int i;
	for (i=0; i<[feed count]; i++) {
		NSDictionary *story=[feed objectAtIndex:i];
		NSString *link=[story objectForKey:@"link"];
		if ([self getStoryIndexForLink:link]==-1) {
			[newStories addObject:story];
		}
	}

	return newStories;
}

// Assumes newStories are not already being tracked
// and that newStories contains at least one item.
-(void) addStories: (NSMutableArray*) newStories {
	[newStories addObjectsFromArray:stories];
	stories=[newStories retain];

	while ([stories count]>maxItems) {
		[stories removeObjectAtIndex:[stories count]-1];
	}
}

-(NSMutableArray*) getStories {
	return stories;
}

+(void) visitURL: (NSString*) url {
	NSString *command=[NSString stringWithFormat:@"open \"%s\"", [url UTF8String]];
	system([command UTF8String]);
}

-(void) markAsRead: (NSString*) link open: (BOOL) shouldOpen {
	int index=[self getStoryIndexForLink:link];

	NSDictionary *story=[stories objectAtIndex:index];
	NSString *title=[story objectForKey:@"title"];

	NSDictionary *newStory=[[NSDictionary alloc] initWithObjectsAndKeys:
		[NSNumber numberWithInt:1], @"read",
		title, @"title",
		link, @"link",
		nil
	];

	[stories replaceObjectAtIndex:index withObject:newStory];

	if (shouldOpen) {
		[FeedManager visitURL:link];
	}
}

@end