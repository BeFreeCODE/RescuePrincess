//
//  game.m
//  RescuePrincess
//
//  Created by 오 준영 on 13. 5. 20..
//  Copyright (c) 2013년 오 준영. All rights reserved.
//

#import "game.h"

@implementation game

static game *sharedInstance = nil;

+ (game*)getInstance
{
	if (sharedInstance == nil)
		sharedInstance = [game gameWithLevels];
	return sharedInstance;
}


+ (int)getCurrentLevelIndex {
	return 0;//[[Helper getUserValueForKey:@"currentlevel" withDefault:@"0"] intValue];
}



+ (Level)getLevelAtLevelIndex:(int)aLevelIndex
{
    //getInstance 할때 모든 레벨정보가 저장된다.
	return [[game getInstance] getLevelAtIndex:aLevelIndex];    //인자로 넘겨준 레벨의 정보를 반환한다.
}

//레벨을 10으로 수정
static NSString *levels[5][5] = {
    {   @"bachelors",
        @"B04 B01 B02 B03",
        @"B05 A00 B08 B07",
        @"B06 B09 B08 B10",
        @"B11 B12 B13 E14"
    },
    
    {   @"bachelors",
        @"B02 A00 B03 B04",
        @"B07 B05 B01 B08",
        @"B10 B06 B09 E08",
        @"B11 B12 B13 B14"
    },
    
    {   @"bachelors",
        @"B01 B02 A00 B04",
        @"B07 B05 B03 B08",
        @"B10 B06 B09 E08",
        @"B11 B12 B13 B14"
    },
    
    {   @"bachelors",
        @"B01 B02 B04 A00",
        @"B07 B05 B03 B08",
        @"B10 B06 B09 E08",
        @"B11 B12 B13 B14"
    },
    
    {   @"bachelors",
        @"B01 B02 B04 B07",
        @"A00 B05 B03 B08",
        @"B10 B06 B09 E08",
        @"B11 B12 B13 B14"
    },
};

+ (Level) getLevelAtIndex:(int)aIndex
{
    //레벨의 난이도 이름과 타일의 정보를 저장하는 문자열을 선언한다.
	Level aLevel;
	NSString *difficulity = levels[aIndex][0];  //게임 난이도 저장
	NSString *rows[4];      //레벨 정보 저장
	rows[0] = levels[aIndex][1];
	rows[1] = levels[aIndex][2];
	rows[2] = levels[aIndex][3];
	rows[3] = levels[aIndex][4];
	//rows[4] = levels[aIndex][5];
	//rows[5] = levels[aIndex][6];
	//rows[6] = levels[aIndex][7];
	//rows[7] = levels[aIndex][8];
	
    if ([difficulity isEqualToString:@"bachelors"] )
    {
		aLevel.difficulity = bachelors;
		aLevel.gridSize =4 ;
		aLevel.tileSize = 75;
	}
    
	for (int y=0; y<aLevel.gridSize; y++)
    {
        
		Tile tile;
		NSString *row = rows[y];
        
		for (int x=0; x<aLevel.gridSize; x++)
        {
            
			NSString *tileTypeCode = [row substringWithRange:NSMakeRange(x*4, 1)];// 문자열을 잘른다.  x*4 ~ 1 번쨰 문자열을 가져온다.
			
            if ([tileTypeCode isEqualToString:@"A"])
            {
				tile.tileType = arrow;
			}
            else if ([tileTypeCode isEqualToString:@"E"])
            {
				tile.tileType = empty;
			} else {
				tile.tileType = blank;
			}
            
			NSString *locationCode = [row substringWithRange:NSMakeRange(x*4+1, 2)];    //문자열에서 타일의 위치만 뽑나낸다.
			tile.location = y * aLevel.gridSize + x; //0,1,2,3,4,5.....
            
			int tileIndex = [locationCode intValue];// 타일위치를 정수로 변환
			aLevel.tiles[tileIndex] = tile;         //타일의 위치에 해당하는 배열 인덱스에 타일 정보를 넣는다.
			//[aLevel setTileAtIndex:tileIndex tile:tile];
		}
	}
    //레벨에는 타일의 타입과  타일의 위치가 저장되어있다.
	return aLevel;
}

+ (game*)gameWithLevels
{
    game *Game = [[game alloc] init]; // 게임클래스의 메모리생성
    
    //레벨을 8에서 5로 수정함
	for (int i=0;i<5;i++)
    {
		Level level = [game getLevelAtIndex:i]; //레벨에 맞는 문자열을 읽어서 레벨을 반환한다.
        //설정해준 레벨을 저장한다.
		[Game setLevelAtIndex:i level:level];
	}
	return Game;
}

- (void)setLevelAtIndex:(int)aIndex level:(Level)aLevel
{
	levels[aIndex] = aLevel;        //level 멤버 변수에 값이 저장된다.
    //레벨 0,1,2,3,4....
}

- (Level)getLevelAtIndex:(int)aIndex {
	return levels[aIndex];
}

@end
