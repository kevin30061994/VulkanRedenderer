#version 420 core

// Uniforms ==============================================
uniform mat4 MODEL;
uniform mat4 VIEW;
uniform mat4 PROJECTION; 

// Attributes ============================================
// Inputs
in vec3 POSITION;
in vec3 NORMAL;   // new
in vec4 COLOR;
in vec2 UV; 

// Outputs
out vec2 passUV; 
out vec4 passColor; 
out vec3 passWorldPos;     // new
out vec3 passWorldNormal;  // new

// Entry Point ===========================================
void main( void )
{
   vec4 local_pos = vec4( POSITION, 1.0f );  

   vec4 world_pos = MODEL * local_pos; 
   vec4 camera_pos = VIEW * world_pos; 
   vec4 clip_pos = PROJECTION * camera_pos; 

   passUV = UV; 
   passColor = COLOR; 

   // new
   passWorldPos = world_pos.xyz;  
   passWorldNormal = (MODEL * vec4( NORMAL, 0.0f )).xyz; 

   gl_Position = clip_pos; // we pass out a clip coordinate
}