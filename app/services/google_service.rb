require "google/cloud/speech/v1"
class GoogleService
  def transcript(audio)
    audio_file = File.open(audio)
    google_text_obj = speech_to_text(audio_file)
    text = google_text_obj.first.alternatives.first.transcript
  end

  private

  def speech_to_text(audio_file)
    credentials = JSON.parse(File.read('app/controllers/concerns/credentials.json'))
    client = ::Google::Cloud::Speech::V1::Speech::Client.new do |config|
    config.credentials = credentials
    end

    config = {
      language_code: 'en-US',
      audio_channel_count: 2,
      sample_rate_hertz: 44100,
      enable_automatic_punctuation: true
    }

    audio = { content: audio_file }
    puts "Operation started"
    response = client.recognize(config: config, audio: audio)
    results = response.results
    return results
  end
end
