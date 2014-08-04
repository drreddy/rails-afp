class AddGenreToAudioFingerprint < ActiveRecord::Migration
  def change
    add_column :audio_fingerprints, :genre, :string
  end
end
