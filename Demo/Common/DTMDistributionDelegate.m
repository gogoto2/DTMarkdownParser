//
//  DTMDistributionDelegate.m
//  DTMarkdownParser
//
//  Created by Jan on 25.10.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import "DTMDistributionDelegate.h"

@implementation DTMDistributionDelegate {
	NSMutableArray *_subDelegates;
}


- (id)init;
{
	self = [super init];
	
	if (self) {
		_subDelegates = [NSMutableArray array];
	}
	
	return self;
}

- (void)addDelegate:(id <DTMarkdownParserDelegate>)aDelegate;
{
	[_subDelegates addObject:aDelegate];
}

- (void)parserDidStartDocument:(DTMarkdownParser *)parser;
{
	[_subDelegates makeObjectsPerformSelector:_cmd withObject:parser];
}

- (void)parserDidEndDocument:(DTMarkdownParser *)parser;
{
	[_subDelegates makeObjectsPerformSelector:_cmd withObject:parser];
}

- (void)parser:(DTMarkdownParser *)parser didStartElement:(NSString *)elementName attributes:(NSDictionary *)attributeDict;
{
	[_subDelegates enumerateObjectsUsingBlock:^(id <DTMarkdownParserDelegate>aDelegate, NSUInteger idx, BOOL *stop) {
		if (elementName != nil) {
			[aDelegate parser:parser didStartElement:elementName attributes:attributeDict];
		}
	}];
}

- (void)parser:(DTMarkdownParser *)parser foundCharacters:(NSString *)string;
{
	[_subDelegates enumerateObjectsUsingBlock:^(id <DTMarkdownParserDelegate>aDelegate, NSUInteger idx, BOOL *stop) {
		if (string != nil) {
			[aDelegate parser:parser foundCharacters:string];
		}
	}];
}

- (void)parser:(DTMarkdownParser *)parser didEndElement:(NSString *)elementName;
{
	[_subDelegates enumerateObjectsUsingBlock:^(id <DTMarkdownParserDelegate>aDelegate, NSUInteger idx, BOOL *stop) {
		if (elementName != nil) {
			[aDelegate parser:parser didEndElement:elementName];
		}
	}];
}

@end
