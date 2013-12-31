//
//  MOAIEaseSimpleBase.cpp
//  libmoai
//
//  Created by Aaron Barrett on 12/30/13.
//
//

#include "pch.h"
#include "MOAIEaseSimpleBase.h"

int MOAIEaseSimpleBase::_setRate( lua_State *L ){
	MOAI_LUA_SETUP( MOAIEaseSimpleBase, "UN" );
	
	float rate = state.GetValue < float >( 2, 0 );
	self->SetRate(rate);
	
	return 0;
}

MOAIEaseSimpleBase::MOAIEaseSimpleBase()
	:mRate(2.0f)
{
	RTTI_SINGLE(MOAIEase)
}

MOAIEaseSimpleBase::~MOAIEaseSimpleBase(){
	
}

void MOAIEaseSimpleBase::RegisterLuaClass(MOAILuaState &state){
	MOAIEase::RegisterLuaClass(state);
}

void MOAIEaseSimpleBase::RegisterLuaFuncs(MOAILuaState &state){
	MOAIEase::RegisterLuaFuncs(state);
	
	luaL_Reg regTable [] = {
		{ "setRate",				_setRate },
		{ NULL, NULL }
	};
	
	luaL_register ( state, 0, regTable );
}

void MOAIEaseSimpleBase::SetRate(float inputRate){
	this->mRate = inputRate;
}