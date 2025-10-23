/***************************************************************************
 *             __________               __   ___.
 *   Open      \______   \ ____   ____ |  | _\_ |__   _______  ___
 *   Source     |       _//  _ \_/ ___\|  |/ /| __ \ /  _ \  \/  /
 *   Jukebox    |    |   (  <_> )  \___|    < | \_\ (  <_> > <  <
 *   Firmware   |____|_  /\____/ \___  >__|_ \|___  /\____/__/\_ \
 *                     \/            \/     \/    \/            \/
 * $Id$
 *
 * Copyright (C) 2006 by Barry Wardell
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
 * KIND, either express or implied.
 *
 ****************************************************************************/


#include <SDL.h>
#include "button.h"
#include "config.h"
#include "buttonmap.h"

int key_to_button(int keyboard_button)
{
    int new_btn = BUTTON_NONE;
    switch (keyboard_button)
    {
        case SDLK_F6:
            new_btn = BUTTON_SELECT|BUTTON_PLAY;
            break;
        case SDLK_s:
            new_btn = BUTTON_LEFT;
        case SDLK_i:
            new_btn = BUTTON_RIGHT;
            break;
        case SDLK_c:
            new_btn = BUTTON_SCROLL_BACK;
            break;
        case SDLK_e:
            new_btn = BUTTON_SCROLL_FWD;
            break;
        case SDLK_o:
            new_btn = BUTTON_PLAY;
            break;
        case SDLK_SPACE:
            new_btn = BUTTON_SELECT;
            break;
        case SDLK_w:
            new_btn = BUTTON_MENU;
            break;
    }
    return new_btn;
}

struct button_map bm[] = {
    { SDLK_SPACE,    175, 432, 45, "Select" },
    { SDLK_s,         75, 432, 38, "Left" },
    { SDLK_i,        275, 432, 39, "Right" },
    { SDLK_w,        175, 350, 34, "Menu" },
    { SDLK_o,        175, 539, 41, "Play" },
    { SDLK_c,        100, 375, 35, "Scroll Back" },
    { SDLK_e,        245, 375, 35, "Scroll Fwd" },
};
