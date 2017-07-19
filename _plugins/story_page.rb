require "storyblok"

module Jekyll

  class StoryPage < Page
    def initialize(site, base, story)
      @site = site
      @base = base
      @dir = story['full_slug']
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'story.html')
      self.data['story'] = story
      self.data['title'] = story['name']
    end
  end

  class StoryPageGenerator < Generator
    safe true

    def generate(site)
      client = ::Storyblok::Client.new(token: 'e9ZTVJwikslzTr2iJbhqDAtt', version: 'draft')
      res = client.stories
      stories = res['data']['stories']

      stories.each do |story|
        site.pages << StoryPage.new(site, site.source, story)
      end
    end
  end
end
