@tool
extends Control

# ==============================================================================
# Constants
# ==============================================================================
const API_URL = "https://api.together.xyz/v1/completions"  # API endpoint URL
var api_key = ""  # API key for authentication

	
# ==============================================================================
# Variables
# ==============================================================================
var is_audio_enabled: bool = false  # Determines if responses will be read aloud
var http_request = HTTPRequest.new()  # Node to handle HTTP requests
var language = preload("res://Addons/Cognita-main/Lang.gd").new()  # Language handler

# ==============================================================================
# Initialization
# ==============================================================================
func _ready() -> void:
	# Initialize language settings and add HTTPRequest to the scene tree
	_initialize_language()
	_add_http_request_to_tree()

# ==============================================================================
# User Interaction Handlers
# ==============================================================================
# Handle button press for sending queries
func _on_button_pressed() -> void:
	_send_user_query($VBoxContainer/HBoxContainer/LineEdit.text)
	_clear_input_field()

# Handle text submission via LineEdit
func _on_line_edit_text_submitted(new_text: String) -> void:
	_send_user_query(new_text)
	_clear_input_field()

# Toggle audio functionality through CheckBox
func _on_check_box_toggled(is_checked: bool) -> void:
	is_audio_enabled = is_checked

# ==============================================================================
# API Communication
# ==============================================================================
# Send a user query to the API
func _send_user_query(prompt: String) -> void:
	if prompt.strip_edges() == "":
		print("Prompt is empty; no request sent.")
		return

	# Define request headers and body
	var headers = [
		"Authorization: Bearer %s" % api_key,  # Include the API key for authentication
		"Content-Type: application/json"
	]
	var request_body = {
		"role": "user",
		"model": "meta-llama/Llama-4-Maverick-17B-128E-Instruct-FP8",
		"prompt": language.translations[language.language_selector()].get("promt") + prompt,
		"max_tokens": 512,
		"temperature": 1,
	}

	# Send the HTTP request
	var error_code = http_request.request(API_URL, headers, HTTPClient.METHOD_POST, JSON.stringify(request_body))
	if error_code != OK:
		print("Failed to send request: ", error_code)

# Process the response from the API
func _on_http_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Connection error: ", result)
		return

	if response_code != 200:
		print("HTTP error: ", response_code)
		return

	# Parse the response body
	var json = JSON.new()
	var parse_error = json.parse(body.get_string_from_utf8())
	if parse_error != OK:
		print("JSON parsing error: ", json.get_error_message())
		return

	# Extract and display the response text
	var response_data = json.get_data()
	if response_data and response_data.has("choices") and response_data["choices"].size() > 0:
		var response_text = response_data["choices"][0]["text"]
		_update_interface_with_response(response_text)
		_play_audio_response(response_text)

	else:
		_update_interface_with_error()

# ==============================================================================
# Helper Functions
# ==============================================================================
# Add the HTTPRequest node to the scene tree
func _add_http_request_to_tree() -> void:
	add_child(http_request)
	http_request.request_completed.connect(_on_http_request_completed)

# Play the response audio if audio is enabled
func _play_audio_response(response_text: String) -> void:
	if is_audio_enabled:
		var voices = DisplayServer.tts_get_voices_for_language(language.language_selector())
		if voices.size() > 0:
			DisplayServer.tts_speak(response_text, voices[0], 100)

# Update the interface with the API response
func _update_interface_with_response(response_text: String) -> void:
	$VBoxContainer/Label.call_deferred("set_text", "[center]" + response_text.strip_edges() + "[/center]")

# Update the interface with an error message if the response is invalid
func _update_interface_with_error() -> void:
	$VBoxContainer/Label.text = str(language.translations[language.language_selector()].get("invalid"))

# Clear the input field after sending a query
func _clear_input_field() -> void:
	$VBoxContainer/HBoxContainer/LineEdit.text = ""

# ==============================================================================
# Language Management
# ==============================================================================
# Initialize language settings
func _initialize_language() -> void:
	print(language.language_selector())
	$VBoxContainer/Label.bbcode_text = language.translations[language.language_selector()].get("welcome")
	$VBoxContainer/HBoxContainer/LineEdit.placeholder_text = language.translations[language.language_selector()].get("placeholder")
	$VBoxContainer/HBoxContainer/Button.text = language.translations[language.language_selector()].get("click_here")
