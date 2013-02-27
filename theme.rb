@font_family = find_font_family("ubuntu") || @font_family
@monospace_font_family= find_font_family("ubuntu mono") || @monospace_font_family

base_color = "#ffde00"
base_dark_color = "#ffde00"
base_dark_background_color = "#c1d2f4"
base_background_color = "#ffffff"

set_graffiti_color("#{base_color}99")
set_graffiti_line_width(30)

set_progress_foreground(base_color)
set_progress_background(base_background_color)

@default_item1_mark_color = base_color
@default_item1_mark_type = "circle"
@default_item2_mark_color = base_color
@default_item2_mark_type = "circle"
@default_item3_mark_color = base_color
@default_item3_mark_type = "circle"
@default_enum_item1_mark_color = base_color
@default_enum_item1_mark_type = "circle"
@default_enum_item2_mark_color = base_color
@default_enum_item2_mark_type = "circle"
@default_description_item1_mark_color = base_color
@default_description_item1_mark_type = "circle"
@default_block_quote_item1_mark_color = base_color
@default_block_quote_item1_mark_type = "circle"
@description_term_line_color = base_color

@default_emphasis_color = base_dark_color

@preformatted_frame_color = base_color
@preformatted_fill_color = base_background_color

@block_quote_frame_color = base_color
@block_quote_fill_color = base_background_color

@table_frame_color = base_color
@table_fill_color = base_background_color
@table_body_frame_color = base_color
@table_body_fill_color = base_background_color
@table_head_frame_color = base_color
@table_head_fill_color = base_dark_background_color

add_image_path("rabbit-images")
@image_slide_number_image ||= "mini-nyanko.png"
@image_timer_image ||= "mini-sakana.png"
@image_slide_number_start_flag_color = base_color
@image_slide_number_goal_flag_color = base_dark_background_color
@image_slide_number_text_color = "black"
@block_quote_open_quote_image = "open-quote-sakana.png"
@block_quote_close_quote_image = "close-quote-sakana.png"

@block_quote_frame_width = 0
@block_quote_fill_color = "#fff0"
@block_quote_padding_left = 0
@block_quote_padding_right = 0
@block_quote_padding_top = 0
@block_quote_padding_bottom = 0
@block_quote_image_background_alpha = 0.3
@block_quote_image_frame = true

@margin_bottom = canvas.height * 0.05

include_theme("default")

@lightning_talk_proc_name = "lightning-nyankosakana"
@lightning_talk_as_large_as_possible = true
include_theme("lightning-talk-toolkit")

match(Slide) do |slides|
  slides.each do |slide|
    if slide.lightning_talk?
      slide.lightning_talk
    end
  end
end

match(TitleSlide, "*") do |elements|
  elements.horizontal_centering = false
  elements.align = :right
end

match(TitleSlide, Title) do |titles|
  titles.padding_bottom = @space * 2
  titles.align = :left
end

match(TitleSlide, Subtitle) do |titles|
  titles.align = :left
end

match(Slide, HeadLine) do |heads|
  name = "head-line"
  heads.delete_post_draw_proc_by_name(name)

  heads.horizontal_centering = true
end

match(Slide, Body) do |bodies|
  bodies.vertical_centering = true
  bodies.each do |body|
    next if body.elements.all? {|element| element.is_a?(Image)}
    next if body.elements.any? {|element| element.is_a?(BlockQuote)}
    next if body.elements.any? {|element| element.is_a?(PreformattedBlock)}
    next if body.elements.any? {|element| element.is_a?(Table)}
    body.margin_left = canvas.width * 0.05
    body.margin_right = canvas.width * 0.05
  end
end

match("**", BlockQuote) do |quotes|
  quotes.each do |quote|
    first_element = quote.elements.first
    next unless first_element.is_a?(Paragraph)
    first_element.indent = first_element.prop_get("size")
  end
end

@slide_logo_image ||= "nyankosakana.png"
include_theme("slide-logo")

@icon_images = ["nyankosakana.png"]
include_theme("icon")

@slide_footer_info_left_text ||= canvas.title.gsub(/\n/, '')
@slide_footer_info_right_text ||= "Powered by Rabbit #{Rabbit::VERSION}"
include_theme("slide-footer-info")
