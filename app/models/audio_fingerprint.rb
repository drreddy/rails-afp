class AudioFingerprint < ActiveRecord::Base
  attr_accessible :artist, :duration, :fingerprint, :title
  serialize :fingerprint, :artist
end
