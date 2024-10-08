extends Node

@export var texture_rect: TextureRect;
@export var sub_viewport: SubViewport;

@onready var serializer: GVTextureSerializer = GVTextureSerializer.new()
@onready var sm_writer:SharedMemoryWriter = null
@onready var sm_reader:SharedMemoryReader = null
# @onready var image_texture: CompressedTexture2D = load("res://icon.svg")

func _image_format_to_string(format: int) -> String:
	match format:
		Image.FORMAT_L8:
			return "L8"
		Image.FORMAT_LA8:
			return "LA8"
		Image.FORMAT_R8:
			return "R8"
		Image.FORMAT_RG8:
			return "RG8"
		Image.FORMAT_RGB8:
			return "RGB8"
		Image.FORMAT_RGBA8:
			return "RGBA8"
		Image.FORMAT_RGBA4444:
			return "RGBA4444"
		Image.FORMAT_RGB565:
			return "RGB565"
		Image.FORMAT_RF:
			return "RF"
		Image.FORMAT_RGF:
			return "RGF"
		Image.FORMAT_RGBF:
			return "RGBF"
		Image.FORMAT_RGBAF:
			return "RGBAF"
		Image.FORMAT_RH:
			return "RH"
		Image.FORMAT_RGH:
			return "RGH"
		Image.FORMAT_RGBH:
			return "RGBH"
		Image.FORMAT_RGBAH:
			return "RGBAH"
		Image.FORMAT_RGBE9995:
			return "RGBE9995"
		Image.FORMAT_DXT1:
			return "DXT1"
		Image.FORMAT_DXT3:
			return "DXT3"
		Image.FORMAT_DXT5:
			return "DXT5"
		Image.FORMAT_RGTC_R:
			return "RGTC_R"
		Image.FORMAT_RGTC_RG:
			return "RGTC_RG"
		Image.FORMAT_BPTC_RGBA:
			return "BPTC_RGBA"
		Image.FORMAT_BPTC_RGBF:
			return "BPTC_RGBF"
		Image.FORMAT_BPTC_RGBFU:
			return "BPTC_RGBFU"
		Image.FORMAT_ETC:
			return "ETC"
		Image.FORMAT_ETC2_R11:
			return "ETC2_R11"
		Image.FORMAT_ETC2_R11S:
			return "ETC2_R11S"
		Image.FORMAT_ETC2_RG11:
			return "ETC2_RG11"
		Image.FORMAT_ETC2_RG11S:
			return "ETC2_RG11S"
		Image.FORMAT_ETC2_RGB8:
			return "ETC2_RGB8"
		Image.FORMAT_ETC2_RGBA8:
			return "ETC2_RGBA8"
		Image.FORMAT_ETC2_RGB8A1:
			return "ETC2_RGB8A1"
		Image.FORMAT_ETC2_RA_AS_RG:
			return "ETC2_RA_AS_RG"
		Image.FORMAT_DXT5_RA_AS_RG:
			return "DXT5_RA_AS_RG"
		Image.FORMAT_ASTC_4x4:
			return "ASTC_4x4"
		Image.FORMAT_ASTC_4x4_HDR:
			return "ASTC_4x4_HDR"
		Image.FORMAT_ASTC_8x8:
			return "ASTC_8x8"
		Image.FORMAT_ASTC_8x8_HDR:
			return "ASTC_8x8_HDR"
		Image.FORMAT_MAX:
			return "MAX"
		_:
			return "UNKNOWN"

func _ready() -> void:
	pass

func _compress_decompress_image() -> void:
	# var src_image: Image = image_texture.get_image()
	var src_image: Image = sub_viewport.get_texture().get_image()
	# print("compresse image")
	# print("width: ", src_image.get_width())
	# print("height: ", src_image.get_height())
	# print("format: ", _image_format_to_string(src_image.get_format()))
	# print("image_bytes: ", src_image.get_data().size())

	# pass	
	# var bytes:PackedByteArray = serializer.serializeCompressedTexture2D(image_texture)
	var bytes:PackedByteArray = serializer.serializeImage(src_image)
	# print("packed bytes: ", bytes.size())
	
	if sm_writer == null:
		sm_writer = SharedMemoryWriter.try_create("imagePipe", 262143, true)

		if sm_writer == null:
			print("Failed to create shared memory writer")
			return
		
	if sm_writer != null:
		if bytes.size() > 0:
			sm_writer.write_bytes(bytes)
#
	if sm_reader == null:
		sm_reader = SharedMemoryReader.try_create("imagePipe", 262143, true)

		if sm_reader == null:
			print("Failed to create shared memory reader")
			return

	if sm_reader != null:
		var bytes_read:PackedByteArray = sm_reader.read_bytes()
		if bytes_read.size() > 0:
			var image: Image = serializer.deserialize(bytes_read)
			# print("decompressed image")
			# print("width: ", image.get_width())
			# print("height: ", image.get_height())
			# print("format: ", _image_format_to_string(image.get_format()))
			# print("image_bytes: ", image.get_data().size())

			if image.get_width() > 0 and image.get_height() > 0:
				if texture_rect:
					texture_rect.texture = ImageTexture.create_from_image(image)

	#var image: Image = serializer.deserialize(bytes)
	# print("decompressed image")
	# print("width: ", image.get_width())
	# print("height: ", image.get_height())
	# print("format: ", _image_format_to_string(image.get_format()))
	# print("image_bytes: ", image.get_data().size())

	#if texture_rect:
		#texture_rect.texture = ImageTexture.create_from_image(image)

func _process(_delta: float) -> void:
	# pass
	_compress_decompress_image()
