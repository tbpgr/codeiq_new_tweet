require 'rexml/document'
require 'uri'
require 'open-uri'
require 'openssl'

uri = URI.parse "https://codeiq.jp/rss.xml"
xml_src = open(uri, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read

def delete_unuse_word_from_title(title)
  title = title.delete('挑戦者求む！')
  title.gsub!(/ by .*$/, '')
  title.gsub!(/【.*】/, '')
end

doc = REXML::Document.new(xml_src)
doc.elements.each('/rss/channel/item') do |item|
  title = item.elements['title'].text
  title = delete_unuse_word_from_title(title)
  print "【#{title}】！！ここに運営担当のセンス溢れるメッセージ！！詳細⇒"
  q_url = item.elements['link'].text.gsub(/(.*\/q\d+)\?.*/, '\1')
  print q_url
  print ' #ハッシュタグを設定', "\n"
end
