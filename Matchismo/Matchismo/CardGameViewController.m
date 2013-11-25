//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Larry Laski on 11/20/13.
//  Copyright (c) 2013 Larry Laski. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (nonatomic) Deck *deck;

@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
//    NSLog(@"Flip Count changed to: %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [sender setTitle:card.contents forState:UIControlStateNormal];
        } else {
            [sender setTitle:@"Empty" forState:UIControlStateNormal];
        }
    }
    self.flipCount++;
}

- (Deck *)deck
{
    if (! _deck) {
        _deck= [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}
@end
