class Artist
  extend Concerns::Findable
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name, :songs

  @@all = []
  
  def initialize(name) 
    @name = name
    @songs = []
  end


  end
def self.all
    @@all
  end

  def add_song(song)
    if !song.artist 
      song.artist = self
    end
    @songs << song
    @songs.uniq
    
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(file_name)
    song = split_filename(file_name)
    artist = Artist.find_or_create_by_name(song[0])
    genre = Genre.find_or_create_by_name(song[2])

    new_song = self.new(song[1], artist, genre)
  end


  def self.create_from_filename(file_name)
    song = split_filename(file_name)
    artist = Artist.find_or_create_by_name(song[0])
    genre = Genre.find_or_create_by_name(song[2])

    self.create(song[1]).tap do |song|
      song.artist = artist
      song.genre = genre
    end
  end

end