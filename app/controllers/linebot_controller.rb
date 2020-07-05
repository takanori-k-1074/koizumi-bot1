class LinebotController < ApplicationController
  include LinebotHelper

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each { |event|

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Location
          # LINEの位置情報から緯度経度を取得
          latitude = event.message['latitude']
          longitude = event.message['longitude']
          appId = "6f0d8d8f2b532a46d4ff945d4091f211"
          url= "http://api.openweathermap.org/data/2.5/forecast?lon=#{longitude}&lat=#{latitude}&APPID=#{appId}&units=metric&mode=xml"
          # XMLをパース
          xml  = open( url ).read.toutf8
          doc = REXML::Document.new(xml)
          xpath = 'weatherdata/forecast/time[1]/'
          nowWearther = doc.elements[xpath + 'symbol'].attributes['name']
          nowTemp = doc.elements[xpath + 'temperature'].attributes['value']
          case nowWearther
          # 条件が一致した場合、メッセージを返す処理。
          when /.*(clear sky|few clouds).*/
            response = "指定地の天気は晴れ\u{2600}\n\n現在の気温は#{nowTemp}℃です\u{1F321}"
          when /.*(scattered clouds|broken clouds|overcast clouds).*/
            response = "指定地の天気は曇り\u{2601}\n\n現在の気温は#{nowTemp}℃です\u{1F321}"
          when /.*(rain|thunderstorm|drizzle).*/
            response = "指定地の天気は雨\u{2614}\n\n現在の気温は#{nowTemp}℃です\u{1F321}"
          when /.*(snow).*/
            response = "指定地の天気は雪\u{2744}\n\n現在の気温は#{nowTemp}℃です\u{1F321}"
          when /.*(fog|mist|Haze).*/
            response = "指定地では霧が発生\u{1F32B}\n\n現在の気温は#{nowTemp}℃です\u{1F321}"
          else
            response = "指定地では何かが発生していますが、\nご自身でお確かめください。\u{1F605}\n\n現在の気温は#{nowTemp}℃です\u{1F321}"
          end
          message = {
            type: 'text',
            text: response
          }
          client.reply_message(event['replyToken'], message)      
        when Line::Bot::Event::MessageType::Text
          if event.message['text'].include?("天気")
            response = "位置情報を送ってくれ"
            message = {
              type: 'text',
              text: response
            }
          elsif event.message['text'].include?("紹介")
            message = bubble
            # helperに記載
          elsif event.message['text'].include?("ニュース")
            agent = Mechanize.new
            page = agent.get("https://tech-camp.in/note/technology")
            elements = page.search('h2 a')
            techNews = []                     
            elements.each { |ele| techNews << ele.inner_text }
            techNewsReverse = techNews.reverse
            num = 0
            lineNews = []
            techNewsReverse.each do |tech|
              next if num == 5 
              lineNews << tech
              num += 1
            end
            message = {
              type: 'text',
              text: lineNews
            }
          else
            response = event.message['text']
            message = {
              type: 'text',
              text: response
            }
          end
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)      
        end
      end
    }
    "OK"
  end
end