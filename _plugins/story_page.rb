require "storyblok"

module Jekyll

  class StoryPage < Page
    def initialize(site, base, dir, story, links)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'story.html')
      self.data['story'] = story
      self.data['title'] = story['name']
      self.data['links'] = links
    end
  end

  class StoryPageGenerator < Generator
    safe true

    def generate(site)
      client = ::Storyblok::Client.new(token: 'e9ZTVJwikslzTr2iJbhqDAtt', version: 'draft')
      res = client.stories
      stories = res['data']['stories']

      res_links = client.links
      links = res_links['data']['links']

      stories.each do |story|
        site.pages << StoryPage.new(site, site.source, story['full_slug'], story, links)

        if story['full_slug'] == 'home'
          site.pages << StoryPage.new(site, site.source, '', story, links)
        end
      end
    end
  end
end
