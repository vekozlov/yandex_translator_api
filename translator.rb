# Simple using of Yandex-Translate.
# Pages you need to use it
# 1. For generating the API_KEY visit this page (first login/register)
#    http://api.yandex.ru/key/form.xml?service=dict
# 2. For customizing query params, visit this page
#    http://api.yandex.ru/dictionary/doc/dg/reference/lookup.xml
#
# vekozlov
# https://gist.github.com/59c20581013a9409f9af
 
require "rubygems"
require "json"
require "net/http"
require "uri"
 
class Translator
  API_KEY=ENV["API_KEY"]

  def initialize
    @url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?"
    # other languages are also available
    @lang="en-ru"
  end
 
  def translate(word)
    uri = URI.parse "#{@url}key=#{API_KEY}&lang=#{@lang}&text=#{word}"
    response = Net::HTTP.get_response(uri)
 
    if response.code == "200"
      result = JSON.parse(response.body)
      # result has more translation variants, so parse it more accurately to get more translation variants
      result["def"][0]["tr"][0]["text"]
    else
      false 
    end
  end
end
 
# use it to translate single words, to translate sentences use another yandex-services
 
puts Translator.new.translate("word")         # => слово
puts Translator.new.translate("beautiful")    # => красивый
puts Translator.new.translate("programming")  # => программирование  