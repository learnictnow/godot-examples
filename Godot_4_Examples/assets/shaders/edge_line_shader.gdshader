shader_type spatial;

uniform float threshold : hint_range(0.0, 1.0) = 0.1;
uniform float line_width : hint_range(1.0, 10.0) = 1.0;

void fragment() {
    discard;
}

void vertex() {
    vec3 vertex_position = VERTEX;
    vec3 vertex_normal = NORMAL;
    mat4 model_matrix = MODEL_MATRIX;
    mat4 view_matrix = VIEW_MATRIX;
    mat4 projection_matrix = PROJECTION_MATRIX;

    // Transform vertex position to clip space
    vec4 clip_position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);

    // Calculate the screen-space line width based on the vertex position
    float screen_line_width = line_width * length(clip_position.xy) / clip_position.w;

    // Calculate the screen-space vertex position
    vec4 screen_position = clip_position / clip_position.w;

    // Calculate the screen-space normal
    vec4 screen_normal = projection_matrix * view_matrix * model_matrix * vec4(vertex_normal, 0.0);
    screen_normal.xy /= screen_normal.w;

    // Calculate the edge intensity based on the screen-space normal
    float edge = length(screen_normal.xy);

    // Generate the line segment
    if (edge > threshold) {
        float alpha = smoothstep(threshold, threshold + screen_line_width, edge);
        COLOR.rgb = vec3(0.5, 0, 0);
        COLOR.a = alpha;
    }

    VERTEX = clip_position.xyz;
}