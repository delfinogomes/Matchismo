//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Delfino on 21/02/13.
//  Copyright (c) 2013 Delfino. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipResultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.jpg"];
    UIImage *blank = [[UIImage alloc] init];
    UIEdgeInsets edge = UIEdgeInsetsMake(5, 5, 5, 5);
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setImageEdgeInsets:edge];
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        [cardButton setImage:blank forState:UIControlStateSelected];
        [cardButton setImage:blank forState:UIControlStateSelected|UIControlStateDisabled];
    }
    
    [self updateUI];
}

- (void)updateUI
{
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable) ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", [self.game score]];
    
    self.slider.maximumValue = self.game.flipResults.count;
    [self.slider setValue:self.game.flipResults.count];
    
    self.lastFlipResultLabel.text = @"";
    
    if ([self.game.flipResults count]) {
        self.lastFlipResultLabel.text = [self.game.flipResults objectAtIndex: (int)self.slider.value - 1];
        self.lastFlipResultLabel.alpha = 1;
    }
    
    
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Flips updated to: %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender
{
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
    self.gameTypeControl.userInteractionEnabled = NO;
    self.game.numberOfCards = self.gameTypeControl.selectedSegmentIndex + 2;
    
    
}

- (IBAction)deal
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sure?"
                                                    message:@"All progress will be lost."
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

- (void)    alertView:(UIAlertView *)alertView
 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        self.game = nil;
        self.flipCount = 0;
        [self updateUI];
        self.gameTypeControl.userInteractionEnabled = YES;
    }
}

- (IBAction)slider:(UISlider *)sender
{
    NSLog(@"%d", (int)sender.value);
    if ((int)sender.value < self.game.flipResults.count) {
        if ((int)sender.value < self.game.flipResults.count - 1) {
            self.lastFlipResultLabel.alpha = 0.4;
        } else {
            self.lastFlipResultLabel.alpha = 1;
        }
        self.lastFlipResultLabel.text = [self.game.flipResults objectAtIndex: (int)sender.value];
    }
}

@end
