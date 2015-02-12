//
//  Creature.m
//  GameOfLife
//
//  Created by Syed Junaid Ahmed on 2/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(instancetype)initCreature {
    self= [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
           
           if (self) {
               self.isAlive = NO;
               
           }
           
           return self;
           }
           -(void)setIsAlive:(BOOL)newState {
               _isAlive = newState;
               
               
               self.visible = _isAlive;
               
           }
           
           @end
