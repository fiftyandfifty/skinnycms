class Template < ActiveRecord::Base
  has_many :pages

  class << self
    def all_locations
      locs = []
      uniq_locs = {}
      all.each do |t|
        t.content_locations.split(',').each { |loc| locs << loc }
      end
      locs.uniq.each { |loc| uniq_locs[loc] = {} }
      uniq_locs
    end

    def templates_hash
      templates = {}
      all.each { |t| templates[t.title] = t.content_locations }
      templates
    end
  end
end

