// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include "pch.h"
#include <contrib/utf8.h>
#include "MOAIFreeTypeTextBox.h"

int MOAIFreeTypeTextBox::_getAutoFit( lua_State *L ){
	MOAI_LUA_SETUP ( MOAIFreeTypeTextBox, "U" )
	state.Push ( self->mAutoFit );
	return 1;
}

int MOAIFreeTypeTextBox::_getGlyphScale( lua_State *L ){
	MOAI_LUA_SETUP ( MOAIFreeTypeTextBox, "U" )
	state.Push ( self->mGlyphScale );
	return 1;
}

int MOAIFreeTypeTextBox::_getRect( lua_State* L ){
	MOAI_LUA_SETUP ( MOAIFreeTypeTextBox, "U" )
	
	USRect rect = self->mFrame;
	rect.Bless ();
	
	lua_pushnumber ( state, rect.mXMin );
	lua_pushnumber ( state, rect.mYMin );
	lua_pushnumber ( state, rect.mXMax );
	lua_pushnumber ( state, rect.mYMax );
	
	return 4;
}


int	MOAIFreeTypeTextBox::_setAutoFit( lua_State* L ){
	MOAI_LUA_SETUP ( MOAIFreeTypeTextBox, "UB" )
	self->mAutoFit = state.GetValue < bool >( 2, false );
	return 0;
}

/**	@name	setFont
	@text	Sets or clears the style's font.
 
	@in		MOAIFreeTypeTextBox self
	@opt	MOAIFreeTypeFont font		Default value is nil.
	@out	nil
 */

int	MOAIFreeTypeTextBox::_setFont( lua_State* L ){
	MOAI_LUA_SETUP ( MOAIFreeTypeTextBox, "U" )
	MOAIFreeTypeFont *font = state.GetLuaObject< MOAIFreeTypeFont >(2, true);
	UNUSED(font);
	// TODO: implement SetFont()
	return 0;
}

int	MOAIFreeTypeTextBox::_setGlyphScale( lua_State* L ){
	MOAI_LUA_SETUP ( MOAIFreeTypeTextBox, "UN" )
	self->mGlyphScale = state.GetValue < float >( 2, 1.0f );
	return 0;
}


int	MOAIFreeTypeTextBox::_setRect( lua_State* L ){
	MOAI_LUA_SETUP ( MOAIFreeTypeTextBox, "UNNNN" )
	
	float left		= state.GetValue < float >( 2, 0.0f );
	float top		= state.GetValue < float >( 3, 0.0f );
	float right		= state.GetValue < float >( 4, 0.0f );
	float bottom	= state.GetValue < float >( 5, 0.0f );
	
	// TODO: implement SetRect()
	//self->SetRect ( left, top, right, bottom );
	//self->ScheduleLayout ();
	return 0;
}


void MOAIFreeTypeTextBox::RegisterLuaClass(MOAILuaState &state){
	UNUSED(state);
}

void MOAIFreeTypeTextBox::RegisterLuaFuncs(MOAILuaState &state){
	UNUSED(state);
}