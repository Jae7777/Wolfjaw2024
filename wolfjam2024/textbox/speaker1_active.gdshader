shader_type canvas_item;
render_mode unshaded;

uniform bool off = true;

void fragment() {
    COLOR = texture(TEXTURE,UV);
    if(off){
        COLOR.r = COLOR.r * 0.5;
        COLOR.g = COLOR.g * 0.5;
        COLOR.b = COLOR.b * 0.5;
    }
}
