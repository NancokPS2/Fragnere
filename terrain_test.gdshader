shader_type spatial;

void vertex() {
	NORMAL = VERTEX * MODELVIEW_NORMAL_MATRIX;
}

void fragment() {
	const float MAX_DISTANCE = distance(vec3(1,0,0), vec3(0,1,0));
	const vec3 UP = vec3(0,1,0);
	const vec3 RIGHT = vec3(1,0,0);
	const vec3 DOWN = vec3(0,-1,0);
	ALBEDO = vec3(
		1.0 - distance(NORMAL.y, 1.0),
		1.0 - distance(NORMAL.x, 1.0),
		1.0 - distance(NORMAL.y, -1.0)
		);
	//if( distance(NORMAL, vec3(0,1,0)) < 1.0 ){
		//ALBEDO = vec3(1,0,0);
	//}else{
		//ALBEDO = vec3(0,0,1);
	//};
	//if ( distance(NORMAL, vec3(0,-1,0)) < 1.0 ){
		//ALBEDO = vec3(0,1,0);
	//};
}

