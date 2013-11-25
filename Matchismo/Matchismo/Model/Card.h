//
//  Card.h
//  Matchismo
//
//  Created by Larry Laski on 11/20/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
