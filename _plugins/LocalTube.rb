# Original Author: Tuan Anh Tran <http://tuananh.org>
# Heavily modified by @fabsenet

# Description: Out put a beautiful thumbnail image. Change to iframe on click.
# Examples: 
# {% youtube /v8o-Vd__I-A 560 315 %}
# {% youtube http://youtu.be/v8o-Vd__I-A %}

module Jekyll
  class LocalTube < Liquid::Tag
    @ytid = nil
    @width = ''
    @height = ''

    def initialize(tag_name, markup, tokens)
      if markup =~ /(?:(?:https?:\/\/)?(?:www.youtube.com\/(?:embed\/|watch\?v=)|youtu.be\/)?(\S+)(?:\?rel=\d)?)(?:\s+(\d+)\s(\d+))?/i
        @ytid = $1
        @width = $2 || "560"
        @height = $3 || "315"
      end
      super
    end

    def render(context)
      ouptut = super
      if @ytid
        if @ytid == "todo"

          thumbnail = "<h1 style=\"color: red;\">YOUTUBE VIDEO ID IS TODO !!!</h1>"
          video = %Q{#{thumbnail}}

        elsif

          id = @ytid
          w = @width
          h = @height
          intrinsic = ((h.to_f / w.to_f) * 100)
          padding_bottom = ("%.2f" % intrinsic).to_s  + "%"
          if !File.file?("./assets/yt_thumbs/#{id}.jpg")
            puts "downloading http://img.youtube.com/vi/#{id}/maxresdefault.jpg"
            #download the cover from youtube
            require 'net/http'
            # Must be somedomain.net instead of somedomain.net/, otherwise, it will throw exception.
            Net::HTTP.start("img.youtube.com") do |http|
                resp = http.get("/vi/#{id}/maxresdefault.jpg")
                open("./assets/yt_thumbs/#{id}.jpg", "wb") do |file|
                    file.write(resp.body)
                end
            end
          end
          imgsrc = "#{context.registers[:site].config['baseurl']}/assets/yt_thumbs/#{id}.jpg"
          imgsrcwebp = "#{context.registers[:site].config['baseurl']}/assets/yt_thumbs/#{id}.webp"
          thumbnail = "<figure class=\"LocalTube\" data-youtube-id=\"#{id}\"><picture><source srcset=\"#{imgsrcwebp}\" type=\"image/webp\"><img src=\"#{imgsrc}\"></picture><a class=\"LocalTubePlayer\" href=\"http://www.youtube.com/watch?v=#{id}\" target=\"_blank\"></a></figure>"

          video = %Q{#{thumbnail}}
        end
      else
        "Error while processing. Try: {% youtube video_id [width height] %}"
      end
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::LocalTube)
