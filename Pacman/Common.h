//
//  Common.h
//  Pacman
//
//  Created by Satansdeer satansdeer on 26.03.13.
//  Copyright (c) 2013 Satansdeer satansdeer. All rights reserved.
//

#ifndef Pacman_Common_h
#define Pacman_Common_h

#define ccp(__X__,__Y__) CGPointMake(__X__,__Y__)

#define SPRITE_SIZE 32

#define NUMBER_OF_VERTICAL_TILES 15
#define NUMBER_OF_HORIZONTAL_TILES 10

#define ANIMATION_DURATION 0.3

#define PACMAN_UP @"pacman_up"
#define PACMAN_DOWN @"pacman_down"
#define PACMAN_LEFT @"pacman_left"
#define PACMAN_RIGHT @"pacman_right"

#define PINKY_UP @"pinky_up"
#define PINKY_DOWN @"pinky_down"
#define PINKY_LEFT @"pinky_left"
#define PINKY_RIGHT @"pinky_right"

#define WALL_UP_RIGHT @"wall_up_right"
#define WALL_UP_LEFT @"wall_up_left"
#define WALL_UP @"wall_up_center"
#define WALL_LEFT @"wall_left"
#define WALL_CENTER @"wall_center"
#define WALL_RIGHT @"wall_right"
#define WALL_DOWN_LEFT @"wall_down_left"
#define WALL_DOWN @"wall_down"
#define WALL_DOWN_RIGHT @"wall_down_right"

#define WALL_ANGLE_UP_LEFT @"wall_angle_up_left"
#define WALL_ANGLE_UP @"wall_angle_up"
#define WALL_ANGLE_UP_RIGHT @"wall_angle_up_right"
#define WALL_ANGLE_LEFT @"wall_angle_left"
#define WALL_ANGLE_CENTER @"wall_angle_center"
#define WALL_ANGLE_RIGHT @"wall_angle_right"
#define WALL_ANGLE_DOWN_LEFT @"wall_angle_down_left"
#define WALL_ANGLE_DOWN @"wall_angle_down"
#define WALL_ANGLE_DOWN_RIGHT @"wall_angle_down_right"

#define WALL_VERT_UP @"wall_vert_up"
#define WALL_VERT_CENTER @"wall_vert_center"
#define WALL_VERT_DOWN @"wall_vert_down"

#define WALL_HOR_LEFT @"wall_hor_left"
#define WALL_HOR_CENTER @"wall_hor_center"
#define WALL_HOR_RIGHT @"wall_hor_right"

#define PELLET @"pellet"

#define PELLET_LAYER @"pellet_layer"
#define BACKGROUND_LAYER @"background_layer"
#define PLAYER_LAYER @"player_layer"

#define PLAYER 15
#define MONSTER 16

#define UP 0
#define RIGHT 1
#define DOWN 2
#define LEFT 3

typedef struct {
    GLuint texture;
    GLfloat width;
    GLfloat height;
    
} PMTexture;


#endif
