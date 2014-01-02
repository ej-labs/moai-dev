//
//  MOAIEaseElasticInOut.h
//  libmoai
//
//  Created by Aaron Barrett on 1/2/14.
//
//

#ifndef __libmoai__MOAIEaseElasticInOut__
#define __libmoai__MOAIEaseElasticInOut__

#include <moaicore/MOAIEaseElasticBase.h>

class MOAIEaseElasticInOut : public virtual MOAIEaseElasticBase {
	
public:
	
	DECL_LUA_FACTORY( MOAIEaseElasticInOut );
	
	
	MOAIEaseElasticInOut();
	~MOAIEaseElasticInOut();
	
	float DistortedTime(float inputTime);
	
	void			RegisterLuaClass	( MOAILuaState& state );
	void			RegisterLuaFuncs	( MOAILuaState& state );
	
};

#endif /* defined(__libmoai__MOAIEaseElasticInOut__) */