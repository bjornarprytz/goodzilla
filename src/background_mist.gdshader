shader_type canvas_item;

uniform float mist_height : hint_range(0.0, 1.0) = 0.5;
uniform float mist_softness : hint_range(0.0, 1.0) = 1.0;
uniform vec4 mist_color: source_color = vec4(0.8, 0.8, 0.8, 1.0);
uniform float pixel_size : hint_range(1.0, 200.0) = 200.0; // Pixelation level

void fragment() {
    // Get the UV coordinates of the current pixel
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;

    // Apply pixelation
    vec2 pixel_uv = floor(UV * pixel_size) / pixel_size;

    // Sample the texture using the pixelated UV coordinates
    vec4 color = texture(TEXTURE, pixel_uv);

    // Calculate the mist factor based on the height of the pixel
    float mist_factor = smoothstep(mist_height, mist_height - mist_softness, UV.y) *1.4;

    // Create the mist color
    vec4 mist = mist_color * mist_factor;

    // Combine the original pixelated color and the mist
    COLOR = mix(color, mist, UV.y);
}
