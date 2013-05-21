//
//  gameView.m
//  RescuePrincess
//
//  Created by 오 준영 on 13. 5. 20..
//  Copyright (c) 2013년 오 준영. All rights reserved.
//

#import "gameView.h"

@interface gameView ()

@end

@implementation gameView

#define DIMENSION 4
#define SIZE 75

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
		for (int i=0; i<16; i++)
            tiles[i]=nil;
        
        //currentLevelIndex = [game getCurrentLevelIndex];
        
        currentLevelIndex = 0;
		self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
		topOffset = 20;
		leftOffset = 10;
    }
    return self;
}

- (void)onMixViewAnimationComplete {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationDuration:0.5];
	tiles[0].location = 8;
	tiles[1].location = 7;
	tiles[2].location = 6;
	tiles[3].location = 5;
	tiles[4].location = 4;
	tiles[5].location = 3;
	tiles[6].location = 2;
	tiles[7].location = 1;
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];
}

- (void)mixTiles {
	//for (int i=0 ; i<(DIMENSION*DIMENSION)-1; i++) {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationDuration:0.5];
	tiles[0].location = 4;
	tiles[1].location = 4;
	tiles[2].location = 4;
	tiles[3].location = 4;
	tiles[4].location = 4;
	tiles[5].location = 4;
	tiles[6].location = 4;
	tiles[7].location = 4;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(onMixViewAnimationComplete)];
	[UIView commitAnimations];
	//}
}

// returns true this tile can move to the enpty location
- (bool)tileCanMoveToIndexFromIndex:(int)index
{
	int fromX = [tile getXForLoation:index withDimension:currentLevel.gridSize];
	int fromY = [tile getYForLoation:index withDimension:currentLevel.gridSize];
	int toX = [tile getXForLoation:emptyTile withDimension:currentLevel.gridSize];
	int toY = [tile getYForLoation:emptyTile withDimension:currentLevel.gridSize];
	if (fromX == toX && (fromY+1 == toY || fromY-1 == toY) )
		return true;
	if (fromY == toY && (fromX+1 == toX || fromX-1 == toX) )
		return true;
    
	return false;
}

- (void)moveTile:(tile*)tileView toLocation:(int)aLocation {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	tileView.location = aLocation;
	[UIView commitAnimations];
	//[tile updateArrowPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
    
	for (int i=0 ; i<(currentLevel.gridSize*currentLevel.gridSize)-1; i++)
    {
        //터치된 타일과  타일 배열을 조사해서 일치 하는지 검사한다.
		if ([touch view] == tiles[i])
        {
			if ([self tileCanMoveToIndexFromIndex:tiles[i].location])
            {
				CGPoint location = [touch locationInView:self.view];
				CGFloat maxX, minX, minY, maxY;
				CGRect movingTileRect = [tile getRectForLocation:tiles[i].location withDimension:currentLevel.gridSize withSize:currentLevel.tileSize];
				CGRect emptyTileRect = [tile getRectForLocation:emptyTile withDimension:currentLevel.gridSize withSize:currentLevel.tileSize];
                
				CGRect slideRect = CGRectUnion(movingTileRect, emptyTileRect);
				CGFloat centerPadding = (currentLevel.tileSize) / 2;
                
				minX = slideRect.origin.x + centerPadding;
				minY = slideRect.origin.y + centerPadding;
				maxX = slideRect.origin.x + slideRect.size.width - centerPadding;
				maxY = slideRect.origin.y + slideRect.size.height - centerPadding;
				if (location.x > maxX)
					location.x = maxX;
				if (location.y > maxY)
					location.y = maxY;
				if (location.y < minY)
					location.y = minY;
				if (location.x < minX)
					location.x = minX;
				tiles[i].center = location;
				return;
			}
		}
	}
}

- (bool)tilesInCorrectLocation {
	// check each tile and see if it is in the right place and that is is an arrow tile
	for (int i=0 ; i<(currentLevel.gridSize*currentLevel.gridSize)-1; i++) {
		tile *tileView = tiles[i];
		if (tileView.tileType == arrow
			&& tileView.location != i)
			return false;
		
	}
	return true;
}

- (void)testDidWin {
	if (![self tilesInCorrectLocation]) return;
	if (currentLevelIndex < 7) {
		NSString *message = [NSString stringWithFormat:@"You have just completed level %d on to the next level", currentLevelIndex+1];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Level Complete!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		//[Helper setUserValue:[NSString stringWithFormat:@"%d", currentLevelIndex] forKey:@"currentlevel"];
		currentLevelIndex++;
	} else {
		NSString *message = [NSString stringWithFormat:@"You have just completed level %d! Congratulations!!", currentLevelIndex+1];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Challange Complete!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];

		//[Helper setUserValue:[NSString stringWithFormat:@"%d", currentLevelIndex] forKey:@"currentlevel"];
		currentLevelIndex = 0;
	}
	[self loadLevel:currentLevelIndex];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	for (int i=0 ; i<(currentLevel.gridSize*currentLevel.gridSize)-1; i++) {
		if ([touch view] == tiles[i]) {
			if ([self tileCanMoveToIndexFromIndex:tiles[i].location]) {
				int oldLocation = tiles[i].location;
				int newLocation = emptyTile;
				// only move to the new location if the center of the moving tile is
				// inside the empty tile
				CGRect emptyTileRect = [tile getRectForLocation:emptyTile withDimension:currentLevel.gridSize withSize:currentLevel.tileSize];
				if (CGRectContainsPoint(emptyTileRect, tiles[i].center)) {
					[self moveTile:tiles[i] toLocation:newLocation];
					emptyTile = oldLocation;
					//[tiles[i] updateArrowPointToIndex:tiles[i].index fromIndex:newLocation];
				}
				else {
					[self moveTile:tiles[i] toLocation:oldLocation];
				}
				
			}
			break;
		}
	}
	[self testDidWin];
}

-(void)clearTiles
{
	for (int i=0; i<16; i++)
    {
		if (tiles[i] != nil)
        {
			[tiles[i] removeFromSuperview];
		}
		tiles[i]=nil;
	}
}

-(void)loadLevel:(int)levelIndex
{
    //levelIndex 게임의 레벨  1,2,3,4,5,6,7,8
	//currentLevelIndex = levelIndex;
    currentLevelIndex = 1;
	//[Game setCurrentLevelIndex:levelIndex];
	//[menuViewController.view removeFromSuperview];
	
    [self clearTiles];  //뷰초기화
    
	currentLevel = [game getLevelAtLevelIndex:levelIndex]; // 레벨값을 넣어주면 레벨에 맞는 타일 정보가 포함된 레벨을 반환한다.
    
                                        //4*4
	for (int i=0 ; i< (currentLevel.gridSize*currentLevel.gridSize)-1; i++)  //총타일의 개수반큼 반복
    {
        //레벨이 가지고 있는 타일 정보를 가져온다.
		Tile curLeveltile = currentLevel.tiles[i]; //[currentLevel getTileAtIndex:i];
        //타일정보를 기반으로 하여 타일뷰를 만든다.
        
        //타일정보를 기반으로 타일뷰를 만든다.
		tile *tileView = [[tile alloc] initWithIndex:i
                                        atLocation:curLeveltile.location //0,1,2,3,4....
                                         withSize:currentLevel.tileSize //75
                                          withDimension:currentLevel.gridSize //4
                                           withType:curLeveltile.tileType]; //a,e,b
		
        
        tiles[i] = tileView;
		[self.view addSubview:tiles[i]];
	}
    
	emptyTile = currentLevel.gridSize * currentLevel.gridSize-1;
    
    
    //Tile : 타일의 정보가 담긴 구조체    tiles 타일 뷰를 만들 뷰클래스
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLevel:1];  // 넣어준 레벨이 실행된다. 레벨값을 1씩 증가해서 마지막 단계의 값은 10이다.
    
    
	//menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuView" bundle:nil];
	//menuViewController.delegate = self;
	//[self.view addSubview:menuViewController.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}



@end
