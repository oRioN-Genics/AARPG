shader_type canvas_item;

uniform vec4 line_color: source_color = vec4(1.0);
uniform float line_thickness: hint_range(0, 10) = 1.0;
uniform float outline_alpha: hint_range(0.0, 1.0) = 0.0;

const vec2 OFFSETS[8] = { 
    vec2(-1, -1), vec2(-1, 0), vec2(-1, 1),vec2(0, -1), vec2(0, 1),
    vec2(1, -1), vec2(1, 0), vec2(1, 1) 
};

void fragment() {
    vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
    float outline = 0.0;

    for (int i = 0; i < OFFSETS.length(); i++) {
        outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
    }

    outline = min(outline - texture(TEXTURE, UV).a, 1.0);

    vec4 color = texture(TEXTURE, UV);
    COLOR = mix(color, vec4(line_color.rgb, outline_alpha), outline * (1.0 - color.a));
}
