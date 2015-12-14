/* Header code adapted from SDL_image.h */

module sdl.image;

import sdl.version_;
import sdl.error;
import sdl.video;

extern (C) {


/*
 * SDL_image:  An example image loading library for use with SDL
 * Copyright (C) 1997-2012 Sam Lantinga <slouken@libsdl.org>
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 */

/** A simple library to load images of various formats as SDL surfaces */

/* Printable format: "%d.%d.%d", MAJOR, MINOR, PATCHLEVEL */
enum IMG_Version
{
	MAJOR_VERSION = 1,
	MINOR_VERSION = 2,
	PATCHLEVEL = 12
}

/*
 * This macro can be used to fill a version structure with the compile-time
 * version of the SDL_image library.
 */
void SDL_IMAGE_VERSION(SDL_version *v)
{
	v.major = IMG_Version.MAJOR_VERSION;
	v.minor = IMG_Version.MINOR_VERSION;
	v.patch = IMG_Version.PATCHLEVEL;
}



/*
 * This function gets the version of the dynamically linked SDL_image library.
 * it should NOT be used to fill a version structure, instead you should
 * use the SDL_IMAGE_VERSION() macro.
 */
//const SDL_version *IMG_Linked_Version(void);

enum IMG_InitFlags
{
	IMG_INIT_JPG = 0x00000001,
	IMG_INIT_PNG = 0x00000002,
	IMG_INIT_TIF = 0x00000004,
	IMG_INIT_WEBP = 0x00000008
};

/*
 * Loads dynamic libraries and prepares them for use.  Flags should be
 * one or more flags from IMG_InitFlags OR'd together.
 * It returns the flags successfully initialized, or 0 on failure.
 */
int IMG_Init(int flags);

/* Unloads libraries loaded with IMG_Init */
void IMG_Quit();

/* Load an image from an SDL data source.
 * The 'type' may be one of: "BMP", "GIF", "PNG", etc.
 *
 * If the image format supports a transparent pixel, SDL will set the
 * colorkey for the surface.  You can enable RLE acceleration on the
 * surface afterwards by calling:
 * SDL_SetColorKey(image, SDL_RLEACCEL, image->format->colorkey);
 */
SDL_Surface *IMG_LoadTyped_RW(SDL_RWops *src, int freesrc, char *type);
/* Convenience functions */
SDL_Surface *IMG_Load(const char *file);
SDL_Surface *IMG_Load_RW(SDL_RWops *src, int freesrc);

/*
 * Invert the alpha of a surface for use with OpenGL
 * This function is now a no-op, and only provided for backwards compatibility.
 */
int IMG_InvertAlpha(int on);

/* Functions to detect a file type, given a seekable source */
int IMG_isICO(SDL_RWops *src);
int IMG_isCUR(SDL_RWops *src);
int IMG_isBMP(SDL_RWops *src);
int IMG_isGIF(SDL_RWops *src);
int IMG_isJPG(SDL_RWops *src);
int IMG_isLBM(SDL_RWops *src);
int IMG_isPCX(SDL_RWops *src);
int IMG_isPNG(SDL_RWops *src);
int IMG_isPNM(SDL_RWops *src);
int IMG_isTIF(SDL_RWops *src);
int IMG_isXCF(SDL_RWops *src);
int IMG_isXPM(SDL_RWops *src);
int IMG_isXV(SDL_RWops *src);
int IMG_isWEBP(SDL_RWops *src);

/* Individual loading functions */
SDL_Surface *IMG_LoadICO_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadCUR_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadBMP_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadGIF_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadJPG_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadLBM_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadPCX_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadPNG_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadPNM_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadTGA_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadTIF_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadXCF_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadXPM_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadXV_RW(SDL_RWops *src);
SDL_Surface *IMG_LoadWEBP_RW(SDL_RWops *src);

SDL_Surface *IMG_ReadXPMFromArray(char **xpm);

/* We'll use SDL for reporting errors */
alias IMG_SetError = SDL_SetError;
alias IMG_GetError = SDL_GetError;

}
