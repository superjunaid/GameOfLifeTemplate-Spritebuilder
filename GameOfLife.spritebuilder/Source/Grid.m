//
//  Grid.m
//  GameOfLife
//
//  Created by Syed Junaid Ahmed on 2/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void)onEnter{
    [super onEnter];
    
    [self setupGrid];
    
    //accepts touches on the grid
    self.userInteractionEnabled = YES;
}

-(void)setupGrid
{
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array];
    
    //initialize Creatures
    for (int i = 0; i < GRID_ROWS; i++){
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0;j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp (x, y);
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
            
            // creature.isAlive = YES;
            
            x+=_cellHeight;
        }
        
        y+= _cellHeight;
    }
}
-(void)countNeighbors
{
    
    for (int i = 0; i < [_gridArray count]; i++) {
        {
            for (int j = 0; j < [_gridArray[i] count]; j++) {
                {
                    Creature *currentCreature = _gridArray[i][j];
                    
                    currentCreature.livingNeighbors = 0;
                    
                    for (int x = (i-1); x <= (i+1); x++)
                    {
                        for (int y = (j-1); y <= (j+1); y++) {
                            BOOL isIndexValid;
                            isIndexValid = [self isIndexValidForX:x andY:y];
                            
                            if (!((x == i) && (y == j)) && isIndexValid)
                            {
                                Creature *neighbor = _gridArray[x][y];
                                if (neighbor.isAlive)
                                {
                                    currentCreature.livingNeighbors += 1;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

-(void)updateCreatures
{
    for (int i = 0; i < [_gridArray count]; i++) {
        {
            for (int j = 0; j < [_gridArray[i] count]; j++) {
                {
                    Creature *currentCreature = _gridArray[i][j];
                    
                    currentCreature.livingNeighbors = 0;
                    
                    for (int x = (i-1); x <= (i+1); x++)
                    {
                        for (int y = (j-1); y <= (j+1); y++) {
                            BOOL isIndexValid;
                            isIndexValid = [self isIndexValidForX:x andY:y];
                            
                            if (!((x == i) && (y == j)) && isIndexValid)
                            {
                                Creature *neighbor = _gridArray[x][y];
                                if (neighbor.isAlive)
                                {
                                    currentCreature.livingNeighbors += 1;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}

-(void)evolveStep{
    [self countNeighbors];
    
    [self updateCreatures];
    
    _generation++;
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    creature.isAlive = !creature.isAlive;
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    Creature *creature = nil;
    
    int column = touchPosition.x / _cellWidth;
    int row = touchPosition.y / _cellHeight;
    creature = _gridArray[row][column];
    
    return creature;
}
@end
