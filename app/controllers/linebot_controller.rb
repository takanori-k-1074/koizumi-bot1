class LinebotController < ApplicationController
  include LinebotHelper

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    @lineNews = [] # スクレイピング用
    @techUrl = [] # スクレイピング用 
    @picture = []
    @comment = [] 
    @color = []  

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
          elsif event.message['text'].include?("リファレンス")
            message = reference # linebot_helperに記載
          elsif event.message['text'].include?("紹介")
            message = bubble # linebot_helperに記載
          elsif event.message['text'].include?("ニュース")
            agent = Mechanize.new
            page = agent.get("https://tech-camp.in/note/technology")
            elements = page.search('h2 a')                    
            elements.each { |ele| @lineNews << ele.inner_text }
            elements.each { |ele| @techUrl << ele.get_attribute(:href) }
            @title = "TECHCAMP blog new arrival"
            message = news # privateに記載
          elsif event.message['text'].include?("ps5")
            agent = Mechanize.new
            page = agent.get("https://www.famitsu.com/search/?category=ps5")
            elements = page.search('h2 a')                  
            elements.each { |ele| @lineNews << ele.inner_text }
            elements.each { |ele| @techUrl << "https://www.famitsu.com#{ele.get_attribute(:href)}" }
            @title = "Famitu-ps5"
            message = news # privateに記載
          elsif event.message['text'].include?("おみくじ")
            
            randumNumber = rand(1..100)
            case
            when randumNumber == 1
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/16/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.17.22.png"
              @comment << "Raoh"
              @color << "#f0e68c"
            when randumNumber <= 10
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/17/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.17.10.png"
              @comment << "mobA"
              @color << "#0000ff"
            when randumNumber <= 20
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/18/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.17.03.png"
              @comment << "Amiba"
              @color << "#ff0000"
            when randumNumber <= 30
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/19/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.16.54.png"
              @comment << "mobB"
              @color << "#ff0000"
            when randumNumber <= 40
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/20/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.16.47.png"
              @comment << "Jagi"
              @color << "#ff0000"
            when randumNumber <= 50
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/21/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.16.40.png"
              @comment << "rey"
              @color << "#0000ff"
            when randumNumber <= 60
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/23/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.16.24.png"
              @comment << "Souther"
              @color << "#ff0000"
            when randumNumber <= 70
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/24/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.16.16.png"
              @comment << "Kenshiro"
              @color << "#000088"
            when randumNumber <= 80
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/25/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.16.06.png"
              @comment << "Shin"
              @color << "#ff0000"
            when randumNumber <= 90
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/26/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.15.56.png"
              @comment << "Toki"
              @color << "#000088"
            when randumNumber <= 100
              @picture << "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/22/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88_2020-07-14_18.16.32.png"
              @comment << "	Rei"
              @color << "#000088"
            end
            message = omikuji # privateに記載
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
        when Line::Bot::Event::MessageType::Sticker
          message = reference # linebot_helperに記載
          client.reply_message(event['replyToken'], message)
        end
        
      end
    }
    "OK"
  end

  private

  def news
    { 
      "type": "flex",
      "altText": "bubble",
      "contents":{
        "type": "bubble",
        "header": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "#{@title}",
              "size": "md",
              "weight": "bold",
              "color": "#f0c6b9"
            }
          ],
          "backgroundColor": "#d3e9d0"
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "spacing": "sm",
          "contents": [
            {
              "type": "box",
              "layout": "vertical",
              "margin": "lg",
              "spacing": "sm",
              "contents": [
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "1.",
                      "color": "#cfd2da",
                      "size": "sm",
                      "flex": 1
                    },
                    {
                      "type": "text",
                      "text": "#{@lineNews[0]}",
                      "wrap": true,
                      "size": "sm",
                      "flex": 4,
                      "color": "#222222"
                    }
                  ]
                },
                {
                  "type": "button",
                  "action": {
                    "type": "uri",
                    "label": "link to",
                    "uri": "#{@techUrl[0]}"
                  },
                  "margin": "none",
                  "height": "sm",
                  "color": "#f0c6b9",
                  "style": "link"
                }
              ],
              "backgroundColor": "#FFFFFF"
            },
            {
              "type": "box",
              "layout": "vertical",
              "margin": "lg",
              "spacing": "sm",
              "contents": [
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "2.",
                      "color": "#dfe2ea",
                      "size": "sm",
                      "flex": 1
                    },
                    {
                      "type": "text",
                      "text": "#{@lineNews[1]}",
                      "wrap": true,
                      "size": "sm",
                      "flex": 4,
                      "color": "#222222"
                    }
                  ]
                },
                {
                  "type": "button",
                  "action": {
                    "type": "uri",
                    "label": "link to",
                    "uri": "#{@techUrl[1]}"
                  },
                  "margin": "none",
                  "height": "sm",
                  "color": "#f0c6b9",
                  "style": "link"
                }
              ],
              "backgroundColor": "#FFFFFF"
            },
            {
              "type": "box",
              "layout": "vertical",
              "margin": "lg",
              "spacing": "sm",
              "contents": [
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "3.",
                      "color": "#dfe2ea",
                      "size": "sm",
                      "flex": 1
                    },
                    {
                      "type": "text",
                      "text": "#{@lineNews[2]}",
                      "wrap": true,
                      "size": "sm",
                      "flex": 4,
                      "color": "#222222"
                    }
                  ]
                },
                {
                  "type": "button",
                  "action": {
                    "type": "uri",
                    "label": "link to",
                    "uri": "#{@techUrl[2]}"
                  },
                  "margin": "none",
                  "height": "sm",
                  "color": "#f0c6b9",
                  "style": "link"
                }
              ],
              "backgroundColor": "#FFFFFF"
            }
          ]
        }
      }
    }
  end

  def omikuji
    { 
      "type": "flex",
      "altText": "bubble",
      "contents":{
        "type": "bubble",
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "image",
              "url": "#{@picture[0]}",
              "size": "full",
              "aspectMode": "cover",
              "aspectRatio": "1:1",
              "gravity": "center"
            },
            {
              "type": "box",
              "layout": "horizontal",
              "contents": [
                {
                  "type": "box",
                  "layout": "vertical",
                  "contents": [
                    {
                      "type": "box",
                      "layout": "horizontal",
                      "contents": [
                        {
                          "type": "text",
                          "text": "#{@comment[0]}",
                          "size": "3xl",
                          "color": "#{@color[0]}",
                          "style": "italic",
                          "weight": "bold"
                        }
                      ]
                    }
                  ],
                  "spacing": "xs"
                }
              ],
              "position": "absolute",
              "offsetBottom": "0px",
              "offsetStart": "0px",
              "offsetEnd": "0px",
              "paddingAll": "20px"
            }
          ],
          "paddingAll": "0px"
        }
      }
    }
  end
end