module LinebotHelper

  def responseMessage
    {
      type: 'text',
      text: response
    }
  end

  def bubble
    { 
      "type": "flex",
      "altText": "bubble",
      "contents": {
        "type": "bubble",
        "hero": {
          "type": "image",
          "url": "https://deploy11111111.s3-ap-northeast-1.amazonaws.com/uploads/message/image/14/sample.png",
          "size": "full",
          "aspectRatio": "20:13",
          "aspectMode": "cover",
          "action": {
            "type": "uri",
            "uri": "http://linecorp.com/"
          }
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "spacing": "md",
          "contents": [
            {
              "type": "text",
              "text": "コイズミBOT試作１号機",
              "wrap": true,
              "weight": "bold",
              "gravity": "center",
              "size": "xl",
              "color": "#917c50"
            },
            {
              "type": "box",
              "layout": "baseline",
              "margin": "md",
              "contents": [
                {
                  "type": "icon",
                  "size": "sm",
                  "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                },
                {
                  "type": "icon",
                  "size": "sm",
                  "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
                },
                {
                  "type": "icon",
                  "size": "sm",
                  "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
                },
                {
                  "type": "icon",
                  "size": "sm",
                  "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
                },
                {
                  "type": "icon",
                  "size": "sm",
                  "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
                },
                {
                  "type": "text",
                  "text": "1.0",
                  "size": "sm",
                  "color": "#999999",
                  "margin": "md",
                  "flex": 0
                }
              ]
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
                      "color": "#917c50",
                      "size": "sm",
                      "flex": 1,
                      "text": "目的"
                    },
                    {
                      "type": "text",
                      "text": "真の作成目標アプリに必要なAPIの知見を獲得する",
                      "wrap": true,
                      "size": "sm",
                      "color": "#aaaaaa",
                      "flex": 4
                    }
                  ]
                },
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "現行機能",
                      "color": "#917c50",
                      "size": "xxs",
                      "flex": 1
                    },
                    {
                      "type": "text",
                      "text": "位置情報から天気の取得等",
                      "wrap": true,
                      "color": "#aaaaaa",
                      "size": "sm",
                      "flex": 4
                    }
                  ]
                },
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "追加予定",
                      "color": "#917c50",
                      "size": "xxs",
                      "flex": 1
                    },
                    {
                      "type": "text",
                      "text": "何かのスクレイピング",
                      "wrap": true,
                      "color": "#aaaaaa",
                      "size": "sm",
                      "flex": 4
                    }
                  ]
                }
              ]
            },
            {
              "type": "box",
              "layout": "vertical",
              "margin": "xxl",
              "contents": [
                {
                  "type": "spacer"
                },
                {
                  "type": "text",
                  "text": "The design is old Zaku because the functional content still represents a poor and the tyuunibyou.",
                  "color": "#aaaaaa",
                  "wrap": true,
                  "margin": "xxl",
                  "size": "xs"
                }
              ]
            }
          ],
          "backgroundColor": "#000000"
        }
      }
    }
  end
end
