# app/services/openai_service.rb
# require 'cloudmersive-voice-recognition-api-client'

# class CloudmersiveService
#     # setup authorization
#   CloudmersiveVoiceRecognitionApiClient.configure do |config|
#     # Configure API key authorization: Apikey
#     config.api_key['Apikey'] = 'CLOUD_MERSIVE'
#     # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
#     #config.api_key_prefix['Apikey'] = 'Bearer'
#   end
#   api_instance = CloudmersiveVoiceRecognitionApiClient::RecognizeApi.new
#   speech_file = File.new('/path/to/inputfile') # File | Speech file to perform the operation on.  Common file formats such as WAV, MP3 are supported.
#   begin
#     #Recognize audio input as text using machine learning
#     result = api_instance.recognize_file(speech_file)
#     p result
#   rescue CloudmersiveVoiceRecognitionApiClient::ApiError => e
#     puts "Exception when calling RecognizeApi->recognize_file: #{e}"
#   end
# end
