////THIS SHADER MUST BE APPLIED TO A QUAD (MeshInstance) WITH A SIZE OF (2, 2)
////Extra Cull Margin on the quad should be turned up all the way!
//
//shader_type spatial;
//render_mode unshaded;
//
//uniform int outline_mode : hint_range(1, 3, 1) = 3;
//uniform float outline_intensity : hint_range(0, 5) = 1;
//uniform bool _round = false;
//uniform float outline_bias : hint_range(-10, 10) = 0;
//
//uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

shader_type spatial;


uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D DEPTH_TEXTURE: hint_screen_texture, filter_linear_mipmap;


uniform vec4 edge_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float threshold = 0.0;
uniform float blend = 0.01;
uniform bool enable_depth_pass = true;
uniform float threshold_depth = 0.0;
uniform float blend_depth = 0.01;
uniform float distance_fade_length = 50.0;
uniform float distance_fade_blend = 20.0;

void vertex() {
    VERTEX *= 2.0;
    POSITION = vec4(VERTEX, 1.0);
}

float getGrayScale(sampler2D sampler, vec2 coords) {
    return texture(sampler, coords).r;
}

float get_linear_depth(sampler2D sampler, vec2 coords, mat4 ipm) {
    float depth = texture(sampler, coords).r;
    vec3 ndc = vec3(coords, depth) * 2.0 - 1.0;
    vec4 view = ipm * vec4(ndc, 1.0);
    view.xyz /= view.w;
    return -view.z;
}

void fragment() {
    vec2 delta = vec2(0.0, 0.003);
    vec2 SCREEN_PIXEL_SIZE = 1.0 / VIEWPORT_SIZE;
    vec2 iResolution = SCREEN_PIXEL_SIZE;
    float m = max(iResolution.x, iResolution.y);
    vec2 texCoords = SCREEN_UV;

    vec3 screen_color = texture(SCREEN_TEXTURE, texCoords).rgb;

    float c1y = getGrayScale(SCREEN_TEXTURE, texCoords - delta / 2.0);
    float c2y = getGrayScale(SCREEN_TEXTURE, texCoords + delta / 2.0);
    float c1x = getGrayScale(SCREEN_TEXTURE, texCoords - delta.yx / 2.0);
    float c2x = getGrayScale(SCREEN_TEXTURE, texCoords + delta.yx / 2.0);
    float dcdx = (c2x - c1x) / (delta.y * 10.0);
    float dcdy = (c2y - c1y) / (delta.y * 10.0);

    vec2 dcdi = vec2(dcdx, dcdy);
    float edge = length(dcdi) / 10.0;
    edge = 1.0 - edge;
    edge = smoothstep(threshold, threshold + blend, edge);
    float final_edge = edge;

    // Depth-Pass
    if (enable_depth_pass) {
        c1y = get_linear_depth(DEPTH_TEXTURE, texCoords - delta / 2.0, INV_PROJECTION_MATRIX);
        c2y = get_linear_depth(DEPTH_TEXTURE, texCoords + delta / 2.0, INV_PROJECTION_MATRIX);
        c1x = get_linear_depth(DEPTH_TEXTURE, texCoords - delta.yx / 2.0, INV_PROJECTION_MATRIX);
        c2x = get_linear_depth(DEPTH_TEXTURE, texCoords + delta.yx / 2.0, INV_PROJECTION_MATRIX);
        dcdx = (c2x - c1x) / (delta.y * 10.0);
        dcdy = (c2y - c1y) / (delta.y * 10.0);
        dcdi = vec2(dcdx, dcdy);
        float depth_edge = length(dcdi) / 10.0;
        depth_edge = 1.0 - depth_edge;
        depth_edge = smoothstep(threshold_depth, threshold_depth + blend_depth, depth_edge);
        final_edge *= depth_edge;
    }

    // Distance Fading
    float linear_depth = get_linear_depth(DEPTH_TEXTURE, SCREEN_UV, INV_PROJECTION_MATRIX);
    float df = 1.0 - smoothstep(distance_fade_length, distance_fade_length + distance_fade_blend, linear_depth);
    final_edge = (1.0 - final_edge) * df;
    final_edge = 1.0 - final_edge;

    ALBEDO = mix(edge_color.rgb, screen_color.rgb, final_edge);
}

//void vertex() {
//	POSITION = vec4(VERTEX, 1.0);
//}
//
//void fragment() {
//	ALBEDO = outline_color.rgb;
//
//	vec2 screen_size = vec2(textureSize(SCREEN_TEXTURE, 1));
//
//	float px = 0.5/screen_size.x;
//	float py = 0.5/screen_size.y;
//
//	float d = texture(DEPTH_TEXTURE, SCREEN_UV).x;
//	float du = texture(DEPTH_TEXTURE, SCREEN_UV+vec2(0.0, py)).x;
//	float dd = texture(DEPTH_TEXTURE, SCREEN_UV+vec2(0.0, -py)).x;
//	float dr = texture(DEPTH_TEXTURE, SCREEN_UV+vec2(px, 0.0)).x;
//	float dl = texture(DEPTH_TEXTURE, SCREEN_UV+vec2(-px, 0.0)).x;
//
//	if (outline_mode == 1){
//		ALPHA = 0.0 + abs(abs(d)-abs(du)) + abs(abs(d)-abs(dd)) + abs(abs(d)-abs(dl)) + abs(abs(d)-abs(dr));
//
//		ALPHA *= 1000.0*outline_intensity;
//	} else if (outline_mode == 2) {
//		ALPHA = 0.0 + abs(abs(abs(d)-abs(du)) - abs(abs(d)-abs(dd))) + abs(abs(abs(d)-abs(dl)) - abs(abs(d)-abs(dr)));
//
//		ALPHA *= 3.0*50000.0*outline_intensity;
//	} else if (outline_mode == 3) {
//		float dq = texture(DEPTH_TEXTURE, SCREEN_UV+vec2(-px, py)).x;
//		float de = texture(DEPTH_TEXTURE, SCREEN_UV+vec2(px, py)).x;
//		float dz = texture(DEPTH_TEXTURE, SCREEN_UV+vec2(-px, -py)).x;
//		float dc = texture(DEPTH_TEXTURE, SCREEN_UV+vec2(px, -py)).x;
//
//		ALPHA = 0.0 + abs(abs(abs(d)-abs(du)) - abs(abs(d)-abs(dd))) + abs(abs(abs(d)-abs(dl)) - abs(abs(d)-abs(dr))) + abs(abs(abs(d)-abs(dq)) - abs(abs(d)-abs(dc))) + abs(abs(abs(d)-abs(dz)) - abs(abs(d)-abs(de)));
//
//		ALPHA *= 50000.0*outline_intensity;
//	}
//
//	ALPHA += outline_bias;
//
//	if (_round) {
//		ALPHA = round(ALPHA);
//	}
//
//	ALPHA *= outline_color.a;
//}
//
////Written by Warren Jennings