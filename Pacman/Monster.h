//
//  Monster.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 25.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#import "GameCharacter.h"

@interface Monster : GameCharacter{
    int monsterDirection;
}

-(void)update;

@end
