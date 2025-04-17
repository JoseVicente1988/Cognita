@tool
extends EditorPlugin

# ==============================================================================
# Signals
# ==============================================================================
signal download_completed(output_dir: String)  # Emitted when the download is completed
signal download_progress(current: int, total: int)  # Emitted to report download progress
signal download_failed(error: String)  # Emitted if the download fails

# ==============================================================================
# Constants and Variables
# ==============================================================================
const REPO_URL = "https://raw.githubusercontent.com/JoseVicente1988/GodotIA/main/Version.txt"  # Repository URL for version check
const ZIP_URL = "https://github.com/JoseVicente1988/GodotIA/archive/refs/heads/main.zip"  # URL for ZIP file download

var zip_save_path := "res://Addons/Cognita-main/Temp/Addon_IA_update.zip"  # Path to save the downloaded ZIP
var extraction_path := "res://Addons/"  # Path for extracting files
var new_version: String = ""  # Holds the new version string
var update_dialog_shown := false  # Tracks whether the update dialog has been shown
var current_request_url := ""  # Stores the URL of the current HTTP request

var dock  # Dock for the plugin UI
var progress_window: Window  # Window to display download progress
var progress_bar: ProgressBar  # Progress bar for tracking download progress
var http_request: HTTPRequest  # Node for handling HTTP requests

var lang = preload("res://Addons/Cognita-main/Lang.gd").new()  # Language handler


const VERSION_FILE_PATH = "res://Addons/Cognita-main/Version.txt"  # Path to the local version file

# ==============================================================================
# Initialization and Cleanup
# ==============================================================================
func _enter_tree():
	# Instantiate and register the plugin dock
	dock = preload("res://Addons/Cognita-main/IA.tscn").instantiate()
	add_control_to_bottom_panel(dock, "Cognita")
	
	# Create and add HTTPRequest
	http_request = HTTPRequest.new()
	add_child(http_request)
	
	# Setup the progress window
	progress_window = Window.new()
	progress_window.title = lang.translations[lang.language_selector()].get("start_download")
	progress_window.size = Vector2(400, 100)
	progress_window.visible = false
	
	progress_bar = ProgressBar.new()
	progress_bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	progress_bar.custom_minimum_size = Vector2(360, 24)
	progress_bar.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	progress_bar.position = Vector2(progress_window.size.x / 20, progress_window.size.y / 3)
	progress_bar.value = 0
	
	progress_window.add_child(progress_bar)
	add_child(progress_window)
	
	http_request.request_completed.connect(_on_http_request_completed)

func _ready():
	call_deferred("check_for_updates")

func _exit_tree():
	# Ensure cleanup of any modal dialogs created by the plugin
	for child in get_children():
		if child is ConfirmationDialog:
			child.queue_free()
			
	remove_control_from_bottom_panel(dock)
	dock.queue_free()

# ==============================================================================
# Update Check
# ==============================================================================
func check_for_updates():
	if update_dialog_shown:
		return
	current_request_url = REPO_URL
	var error = http_request.request(REPO_URL)
	if error != OK:
		push_error(lang.translations[lang.language_selector()].get("error_git") + str(error))

func _on_http_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray):
	if current_request_url == REPO_URL:
		_on_version_check_completed(result, response_code, headers, body)
	elif current_request_url == ZIP_URL:
		_on_zip_download_completed(result, response_code, headers, body)

func _on_version_check_completed(result: int, response_code: int, headers: Array, body: PackedByteArray):
	if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
		push_error(lang.translations[lang.language_selector()].get("error_version") % [result, response_code])
		return
	
	# Read the version from the local file
	var local_version = _read_local_version()

	var remote_version = body.get_string_from_utf8().strip_edges()
	
	if remote_version != local_version and not update_dialog_shown:
		update_dialog_shown = true
		new_version = remote_version
		show_update_dialog()

# Read the version from the local file
func _read_local_version() -> String:
	var file = FileAccess.open(VERSION_FILE_PATH, FileAccess.READ)
	if file:
		var version = file.get_line().strip_edges()  # Read and clean the first line
		file.close()
		return version
	else:
		push_error(lang.translations[lang.language_selector()].get("local_version_error") % VERSION_FILE_PATH)
		return ""

# ==============================================================================
# Update Handling
# ==============================================================================
func show_update_dialog():
	# Create and configure the confirmation dialog
	var dialog = ConfirmationDialog.new()
	dialog.exclusive = false  # Disable exclusivity
	dialog.title = lang.translations[lang.language_selector()].get("update_available")
	dialog.dialog_text = lang.translations[lang.language_selector()].get("new_version") % [new_version, _read_local_version()]
	dialog.confirmed.connect(_on_update_confirmed)
	
	# Reparent the dialog within the dock to prevent conflicts
	dock.add_child(dialog)
	
	# Popup the dialog after a slight delay to avoid conflicts
	call_deferred("_popup_dialog", dialog)

func _popup_dialog(dialog: ConfirmationDialog) -> void:
	dialog.popup_centered()

func _on_update_confirmed():
	download_update()

# ==============================================================================
# ZIP Download and Progress
# ==============================================================================
func download_update():
	progress_bar.value = 0
	progress_window.popup_centered()
	
	current_request_url = ZIP_URL
	var err = http_request.request(ZIP_URL)
	if err != OK:
		push_error(lang.translations[lang.language_selector()].get("download_start_error") % err)

func _process(_delta: float):
	if http_request.get_http_client_status() == HTTPClient.STATUS_BODY:
		var total = http_request.get_body_size()
		if total > 0:
			var downloaded = http_request.get_downloaded_bytes()
			progress_bar.value = float(downloaded) / total * 100.0

func _on_zip_download_completed(result: int, response_code: int, headers: Array, body: PackedByteArray):
	progress_window.hide()
	
	if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
		push_error(lang.translations[lang.language_selector()].get("download_zip_error") % [result, response_code])
		return
	
	var file = FileAccess.open(zip_save_path, FileAccess.WRITE)
	if file:
		file.store_buffer(body)
		file.close()
	else:
		push_error(lang.translations[lang.language_selector()].get("save_zip_error") % zip_save_path)
		return
	
	extract_zip(zip_save_path)
	delete_zip(zip_save_path)

# ==============================================================================
# ZIP Management
# ==============================================================================
func delete_zip(file_path: String):
	if FileAccess.file_exists(file_path):
		var dir_access = DirAccess.open(file_path.get_base_dir())
		if dir_access:
			var error = dir_access.remove(file_path)
			if error == OK:
				print(lang.translations[lang.language_selector()].get("delete_zip_success") % file_path)
			else:
				push_error(lang.translations[lang.language_selector()].get("delete_zip_error") % [file_path, error])
		else:
			push_error(lang.translations[lang.language_selector()].get("dir_access_error") % file_path)
	else:
		print(lang.translations[lang.language_selector()].get("zip_not_found") % file_path)

func extract_zip(path: String):
	var zip = ZIPReader.new()
	var err = zip.open(zip_save_path)
	if err != OK:
		push_error(lang.translations[lang.language_selector()].get("zip_open_error") % str(err))
		return
	
	DirAccess.make_dir_recursive_absolute(extraction_path)
	
	var files_list: PackedStringArray = zip.get_files()
	for file_path in files_list:
		if file_path.ends_with("/"):
			continue

		var file_data: PackedByteArray = zip.read_file(file_path)
		var full_path = extraction_path + file_path
		var dir_path = full_path.get_base_dir()
		DirAccess.make_dir_recursive_absolute(dir_path)
		
		var out_file = FileAccess.open(full_path, FileAccess.WRITE)
		if out_file:
			out_file.store_buffer(file_data)
			out_file.close()
		else:
			push_error(lang.translations[lang.language_selector()].get("write_file_error") % full_path)
	
	print(lang.translations[lang.language_selector()].get("decompression_complete"), extraction_path)
	emit_signal("download_completed", extraction_path)
