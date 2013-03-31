//
//  LevelManager.m
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "LevelManager.h"
#import "PMTextureLoader.h"
#import <SBJson/SBJson.h>
#import "PMSprite.h"
#import "PMScene.h"
#import "GLView.h"

@implementation LevelManager

-(void)loadLevelFromFile:(NSString*)fileName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    SBJsonParser *jsonParser = [[[SBJsonParser alloc] init] autorelease];
    NSDictionary* json = [jsonParser objectWithString:jsonString];
    [self setupPlayerAndMonsterCoordinatesWithDictionary:json];
    self.level = [json objectForKey:@"level"];
    for (int y=[self.level count]-1; y>=0; y--) {
        for (int x=0; x<[self.level[y] count]; x++) {
            NSString* tileType = [self getSpriteTypeById:[self.level[y][x] intValue]];
            if(tileType){
                [self addWallOfType:tileType atPoint:ccp(x, y)];
            }else{
                [self placePelletAtPoint:ccp(x, y)];
            }
        }
    }
}

-(void)setupPlayerAndMonsterCoordinatesWithDictionary:(NSDictionary*)dictionary{
    CGFloat playerX = [[[dictionary objectForKey:@"player"] valueForKey:@"x"] floatValue];
    CGFloat playerY = [[[dictionary objectForKey:@"player"] valueForKey:@"y"] floatValue];
    self.playerPoint = ccp(playerX, playerY);
    CGFloat monsterX = [[[dictionary objectForKey:@"monster"] valueForKey:@"x"] floatValue];
    CGFloat monsterY = [[[dictionary objectForKey:@"monster"] valueForKey:@"y"] floatValue];
    self.monsterPoint = ccp(monsterX, monsterY);
}

-(void)clearLevel{
    [[[PMScene sharedScene] getLayer:BACKGROUND_LAYER] removeAllChildren];
    [[[PMScene sharedScene] getLayer:PELLET_LAYER] removeAllChildren];
    [self.pellets removeAllObjects];
}

-(BOOL)isFreeAtX:(int)x andY:(int)y{
    return [self.level[14-y][x] intValue]==0;
}

-(void)collectPelletAtPoint:(CGPoint)point{
    for (PMSprite* pellet in self.pellets) {
        if((pellet.x == point.x) && (pellet.y == point.y)){
            [[[PMScene sharedScene] getLayer:PELLET_LAYER] removeChild:pellet];
            [self.pellets removeObject:pellet];
            return;
        }
    }
}

-(void)placePelletAtPoint:(CGPoint)point{
    PMTexture texture = [[PMTextureLoader sharedLoader] getTexture:@"sprites.png"];
    id dataForSprite = [[PMTextureLoader sharedLoader] getDataForSprite:PELLET];
    PMSprite *pellet = [[PMSprite alloc] initWithTexture:texture andCoordsDict:dataForSprite inDepth:1];
    if(!self.pellets){
        self.pellets = [[NSMutableArray alloc] init];
    }
    [self.pellets addObject:pellet];
    [pellet release];
    
    PMNode* layer = [[PMScene sharedScene] getLayer:PELLET_LAYER];
    [layer addChild:pellet];
    pellet.x = point.x * [GLView tileSize];
    pellet.y = (14-point.y) * [GLView tileSize];
}

-(void)addWallOfType:(NSString*)tileType atPoint:(CGPoint)point{
    PMTexture texture = [[PMTextureLoader sharedLoader] getTexture:@"sprites.png"];
    id dataForSprite = [[PMTextureLoader sharedLoader] getDataForSprite:tileType];
    PMSprite *wall = [[PMSprite alloc] initWithTexture:texture andCoordsDict:dataForSprite inDepth:1];
    
    PMNode* layer = [[PMScene sharedScene] getLayer:BACKGROUND_LAYER];
    [layer addChild:wall];
    wall.x = point.x * [GLView tileSize];
    wall.y = (14-point.y) * [GLView tileSize];
    [wall release];
}

-(NSString*)getSpriteTypeById:(int)tileId{
    switch (tileId) {
        case 1:
            return WALL_ANGLE_DOWN_LEFT;
            break;
        case 2:
            return WALL_HOR_CENTER;
            break;
        case 3:
            return WALL_ANGLE_DOWN_RIGHT;
            break;
        case 4:
            return WALL_VERT_CENTER;
            break;
        case 5:
            return WALL_ANGLE_UP_RIGHT;
            break;
        case 6:
            return WALL_ANGLE_UP_LEFT;
            break;
        case 7:
            return WALL_ANGLE_DOWN;
            break;
        case 8:
            return WALL_ANGLE_UP;
            break;
        case 9:
            return WALL_HOR_RIGHT;
            break;
        case 10:
            return WALL_HOR_LEFT;
            break;
        case 11:
            return WALL_VERT_UP;
            break;
        case 12:
            return WALL_VERT_DOWN;
            break;
        case 13:
            return WALL_ANGLE_LEFT;
            break;
        case 14:
            return WALL_ANGLE_RIGHT;
            break;
        default:
            return nil;
            break;
    }
}

-(void)dealloc{
    [self.level release];
    [self.pellets release];
    [super dealloc];
}

@end
