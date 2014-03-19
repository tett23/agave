module Agave
  module API
    extend self

    def reserve(page=1)
      pages = page.times.map do |i|
        request('/reserve.html', page: i)
      end
      pages.map do |page|
        table = page.css('table').first.children()
        table.each_slice(2).map do |status, name|
          time_range, station = status.css('td').map do |td|
            td.inner_html
          end
          _, date, start_time, end_time = time_range.match(/(\d{4}\/\d{2}\/\d{2}).{3}\s(.{5}).(.{5})/).to_a
          start_at = DateTime.parse("#{date} #{start_time}")
          end_at = DateTime.parse("#{date} #{end_time}")
          program_name = name.css('td').first.inner_html

          {
            start_at: start_at,
            end_at: end_at,
            station: station,
            name: program_name
          }
        end
      end.flatten
    end

    def reserve_page_count
      page = request('/reserve.html')
      page.css('a').map do |a|
        href = a.attributes['href'].value

        href =~ /reserve\.html/ ? href : nil
      end.compact.count
    end

    def add_auto_reserve(keyword, params)
      'autoaddepgadd.html'

      {
        andKey: params[:keyword],
        notKey: params[:exclude],
        regExpFlag: params[:use_regex],
        aimaiFrag: params[:fuzzy],
        titleOnlyFrag: params[:only_title],
        contentList: params[:genre],
        notContentFlag: params[:not_genre],
        serviceList: params[:services],
        dateList: params[:date],
        freeCAFlag: params[:ca],
        chkRecEnd: params[:check_recording_end],
        chkRecDay: params[:check_recording_date],

      }
    end

    private
    def request(url, params={})
      uri = request_url(url, params)
      page = URI.parse(uri).read

      html = Nokogiri::HTML(page, uri, 'SJIS')
      html.encoding = 'UTF-8'

      html
    end

    def request_url(url, params)
      Agave::Config.host + url + '?' + params.to_param
    end
  end
end
