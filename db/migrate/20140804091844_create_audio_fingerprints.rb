class CreateAudioFingerprints < ActiveRecord::Migration
  def change
    create_table :audio_fingerprints do |t|
      t.string :title
      t.string :artist
      t.string :duration
      t.string :fingerprint

      t.timestamps
    end
  end
end
