extends Node

var current_language = "en"  # Idioma por defecto
var translations = {
	"es": {
		"welcome": "Hola, soy Cognita. Tu compañero en Godot, me especializo en responder dudas o consultas que tengas. Disfruta de consultarme lo que necesites que te respondere tan rápido como pueda.

Para empezar necesitas acceder a:
[color=blue][url=https://www.together.ai]Haz clic aquí[/url][/color] (https://www.together.ai)

Crea una cuenta, al crearla te dará una API, esta debes introducirlo en: Addon/Cognita/Llama3.gd - api_key

Con este tendrás 60 peticiones por minuto de forma gratuita. ¡DISFRÚTALO!",
		"click_here": "Preguntar",
		"placeholder": "Consulta aquí",
		"prompt": "Trabajas exclusivamente con Godot, debes responder únicamente la petición, sin documentarlo, solo el código, no quiero símbolos raros como (''')",
		"invalid": "La respuesta no contiene datos válidos.",
		"start_download": "Descargando actualización...",
		"error_git": "Error al conectar con GitHub: ",
		"error_version": "Error al verificar versión: %s / Código: %s ",
		"local_version_error": "No se pudo abrir el archivo de versión local en: %s",
		"update_available": "Actualización disponible",
		"new_version": "Versión %s disponible (tienes %s)\n¿Actualizar ahora?",
		"download_start_error": "Error iniciando descarga: %s",
		"download_zip_error": "Error al descargar el ZIP: %s / Código: %s",
		"save_zip_error": "No se pudo guardar el ZIP en: %s",
		"delete_zip_success": "Archivo ZIP eliminado correctamente: %s",
		"delete_zip_error": "Error al intentar eliminar el archivo ZIP: %s (Código de error: %s)",
		"dir_access_error": "No se pudo obtener acceso al directorio de: %s",
		"zip_not_found": "El archivo ZIP no se encontró: %s",
		"zip_open_error": "No se pudo abrir el archivo ZIP: %s",
		"write_file_error": "Error al escribir archivo: %s",
		"decompression_complete": "Descompresión completa en:",
		"error_request_send": "Error al enviar la solicitud:",
		"request_sent_waiting": "Solicitud enviada. A la espera de la respuesta...",
		"connection_error": "Error en la conexión:",
		"http_error": "Error HTTP:",
		"json_parse_error": "Error al parsear JSON:",
	},
	"en": {
		"welcome": "Hello, I am Cognita. Your companion in Godot, I specialize in answering questions or inquiries you have. Enjoy asking me whatever you need, I will respond as quickly as I can.

To get started, you need to access:
[color=blue][url=https://www.together.ai]Click here[/url][/color] (https://www.together.ai)

Create an account, when created it will give you an API key, you must enter it in: Addon/Cognita/Llama3.gd - api_key

With this, you will have 60 requests per minute for free. ENJOY IT!",
		"click_here": "Ask",
		"placeholder": "Ask here",
		"prompt": "You work exclusively with Godot, you must respond only to the request without documenting it, just the code, I don't want strange symbols like (''').",
		"invalid": "The response does not contain valid data.",
		"start_download": "Downloading update...",
		"error_git": "Error connecting to GitHub: ",
		"error_version": "Error checking version: %s / Code: %s ",
		"local_version_error": "Could not open the local version file at: %s",
		"update_available": "Update available",
		"new_version": "Version %s available (you have %s)\nUpdate now?",
		"download_start_error": "Error starting download: %s",
		"download_zip_error": "Error downloading the ZIP: %s / Code: %s",
		"save_zip_error": "Could not save the ZIP at: %s",
		"delete_zip_success": "ZIP file successfully deleted: %s",
		"delete_zip_error": "Error trying to delete the ZIP file: %s (Error code: %s)",
		"dir_access_error": "Could not access the directory at: %s",
		"zip_not_found": "The ZIP file was not found: %s",
		"zip_open_error": "Could not open the ZIP file: %s",
		"write_file_error": "Error writing file: %s",
		"decompression_complete": "Decompression complete at:",
		"error_request_send": "Error sending the request:",
		"request_sent_waiting": "Request sent. Waiting for the response...",
		"connection_error": "Connection error:",
		"http_error": "HTTP error:",
		"json_parse_error": "Error parsing JSON:",
	},
	"fr": {
		"welcome": "Bonjour, je suis Cognita. Votre compagnon sur Godot, je me spécialise dans la réponse aux questions ou demandes que vous avez. Profitez de me demander ce dont vous avez besoin, je répondrai aussi vite que possible.

Pour commencer, vous devez accéder à :
[color=blue][url=https://www.together.ai]Cliquez ici[/url][/color] (https://www.together.ai)

Créez un compte, une fois créé, il vous donnera une clé API, que vous devrez entrer dans : Addon/Cognita/Llama3.gd - api_key

Avec cela, vous aurez 60 requêtes par minute gratuitement. PROFITEZ-EN !",
		"click_here": "Demander",
		"placeholder": "Demandez ici",
		"prompt": "Vous travaillez exclusivement avec Godot, vous devez répondre uniquement à la demande sans la documenter, juste le code, je ne veux pas de symboles étranges comme (''').",
		"invalid": "La réponse ne contient pas de données valides.",
		"start_download": "Téléchargement de la mise à jour...",
		"error_git": "Erreur de connexion à GitHub : ",
		"error_version": "Erreur lors de la vérification de la version : %s / Code : %s ",
		"local_version_error": "Impossible d'ouvrir le fichier de version locale à : %s",
		"update_available": "Mise à jour disponible",
		"new_version": "Version %s disponible (vous avez %s)\nMettre à jour maintenant ?",
		"download_start_error": "Erreur lors du démarrage du téléchargement : %s",
		"download_zip_error": "Erreur lors du téléchargement du ZIP : %s / Code : %s",
		"save_zip_error": "Impossible de sauvegarder le ZIP à : %s",
		"delete_zip_success": "Fichier ZIP supprimé avec succès : %s",
		"delete_zip_error": "Erreur en essayant de supprimer le fichier ZIP : %s (Code d'erreur : %s)",
		"dir_access_error": "Impossible d'accéder au répertoire à : %s",
		"zip_not_found": "Le fichier ZIP n'a pas été trouvé : %s",
		"zip_open_error": "Impossible d'ouvrir le fichier ZIP : %s",
		"write_file_error": "Erreur d'écriture du fichier : %s",
		"decompression_complete": "Décompression terminée à :",
		"error_request_send": "Erreur lors de l'envoi de la demande :",
		"request_sent_waiting": "Demande envoyée. En attente de la réponse...",
		"connection_error": "Erreur de connexion :",
		"http_error": "Erreur HTTP :",
		"json_parse_error": "Erreur lors de l'analyse du JSON :",
	},
	"de": {
		"welcome": "Hallo, ich bin Cognita. Ihr Begleiter in Godot, ich spezialisiere mich darauf, Fragen oder Anliegen zu beantworten, die Sie haben. Genießen Sie es, mich alles zu fragen, was Sie brauchen, ich werde so schnell wie möglich antworten.

Um loszulegen, müssen Sie Folgendes aufrufen:
[color=blue][url=https://www.together.ai]Hier klicken[/url][/color] (https://www.together.ai)

Erstellen Sie ein Konto, und wenn es erstellt ist, erhalten Sie einen API-Schlüssel, den Sie eingeben müssen in: Addon/Cognita/Llama3.gd - api_key

Damit haben Sie kostenlos 60 Anfragen pro Minute. GENIESSEN SIE ES!",
		"click_here": "Fragen",
		"placeholder": "Hier fragen",
		"prompt": "Du arbeitest ausschließlich mit Godot, du musst nur auf die Anfrage antworten, ohne sie zu dokumentieren, nur den Code, ich möchte keine seltsamen Symbole wie (''').",
		"invalid": "Die Antwort enthält keine gültigen Daten.",
		"start_download": "Update wird heruntergeladen...",
		"error_git": "Fehler beim Verbinden mit GitHub: ",
		"error_version": "Fehler beim Überprüfen der Version: %s / Code: %s ",
		"local_version_error": "Konnte die lokale Versionsdatei nicht öffnen unter: %s",
		"update_available": "Update verfügbar",
		"new_version": "Version %s verfügbar (Sie haben %s)\nJetzt aktualisieren?",
		"download_start_error": "Fehler beim Starten des Downloads: %s",
		"download_zip_error": "Fehler beim Herunterladen des ZIP: %s / Code: %s",
		"save_zip_error": "Konnte das ZIP nicht speichern unter: %s",
		"delete_zip_success": "ZIP-Datei erfolgreich gelöscht: %s",
		"delete_zip_error": "Fehler beim Versuch, die ZIP-Datei zu löschen: %s (Fehlercode: %s)",
		"dir_access_error": "Konnte nicht auf das",
		"zip_not_found": "ZIP-файл не найден: %s",
		"zip_open_error": "Не удалось открыть ZIP-файл: %s",
		"write_file_error": "Ошибка записи файла: %s",
		"decompression_complete": "Распаковка завершена в:",
		"error_request_send": "Fehler beim Senden der Anfrage:",
		"request_sent_waiting": "Anfrage gesendet. Warten auf die Antwort...",
		"connection_error": "Verbindungsfehler:",
		"http_error": "HTTP-Fehler:",
		"json_parse_error": "Fehler beim Parsen von JSON:",
	},
	"ru": {
		"welcome": "Привет, я Cognita. Ваш помощник в Godot, я специализируюсь на ответах на вопросы или запросы, которые у вас есть. Задавайте любые вопросы, я отвечу так быстро, как смогу.

Чтобы начать, вам нужно зайти на:
[color=blue][url=https://www.together.ai]Нажмите здесь[/url][/color] (https://www.together.ai)

Создайте учетную запись, после создания вам будет предоставлен API-ключ, который необходимо ввести в: Addon/Cognita/Llama3.gd - api_key

С этим у вас будет 60 запросов в минуту бесплатно. НАСЛАЖДАЙТЕСЬ!",
		"click_here": "Спросить",
		"placeholder": "Спросите здесь",
		"prompt": "Вы работаете исключительно с Godot, вы должны отвечать только на запрос, без документации, только код, никаких странных символов вроде (''').",
		"invalid": "Ответ не содержит допустимых данных.",
		"start_download": "Загрузка обновления...",
		"error_git": "Ошибка подключения к GitHub: ",
		"error_version": "Ошибка проверки версии: %s / Код: %s ",
		"local_version_error": "Не удалось открыть локальный файл версии по адресу: %s",
		"update_available": "Доступно обновление",
		"new_version": "Доступна версия %s (у вас %s)\nОбновить сейчас?",
		"download_start_error": "Ошибка при запуске загрузки: %s",
		"download_zip_error": "Ошибка загрузки ZIP: %s / Код: %s",
		"save_zip_error": "Не удалось сохранить ZIP по адресу: %s",
		"delete_zip_success": "ZIP-файл успешно удален: %s",
		"delete_zip_error": "Ошибка при попытке удалить ZIP-файл: %s (Код ошибки: %s)",
		"dir_access_error": "Не удалось получить доступ к директории: %s",
		"zip_not_found": "ZIP-файл не найден: %s",
		"zip_open_error": "Не удалось открыть ZIP-файл: %s",
		"write_file_error": "Ошибка записи файла: %s",
		"decompression_complete": "Распаковка завершена в:",
		"error_request_send": "Ошибка при отправке запроса:",
		"request_sent_waiting": "Запрос отправлен. Ожидание ответа...",
		"connection_error": "Ошибка соединения:",
		"http_error": "Ошибка HTTP:",
		"json_parse_error": "Ошибка разбора JSON:"
	}
}

func language_selector() -> String:
	var supported_languages = ["es", "en", "fr", "de", "ru"]
	var system_lang = OS.get_locale().substr(0, 2)
	return system_lang if system_lang in supported_languages else "en"
