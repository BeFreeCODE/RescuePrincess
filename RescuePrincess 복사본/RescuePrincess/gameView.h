//
//  gameView.h
//  RescuePrincess
//
//  Created by 오 준영 on 13. 5. 20..
//  Copyright (c) 2013년 오 준영. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "tile.h"
#import "game.h"

@interface gameView : UIViewController
{
	int currentLevelIndex;
	Level currentLevel;
	int emptyTile;
	tile *tiles[16];
	int topOffset;
	int leftOffset;
}
-(void)loadLevel:(int)levelIndex;
@end
