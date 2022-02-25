require 'nokogiri'
require 'open-uri'
require 'pry'

class QuotesCrawler
  def self.fetch_by_tag(tag)
    doc = request_doc(tag)
    quotes = get_quotes_from_doc(doc)
    raise "Tag doesn't exist" if quotes.empty? # se for passada uma quote inválida, o método lançará uma excessão

    quotes.map { |quote| get_quote_params(quote) }
  end

  def self.request_doc(tag)
    Nokogiri::HTML(URI.open("http://quotes.toscrape.com/tag/#{tag}/"))
  end

  def self.get_quotes_from_doc(doc)
    doc.css('div.col-md-8').search('div.quote')
  end

  def self.get_quote_params(quote)
    {
      quote: quote.css('span.text').text,
      author: quote.css('small.author').text,
      author_about: quote.css('span').css('a').attribute('href').text,
      tags: quote.css('div').css('a.tag').map { |element| element.children.text }
    }
  end
end

# TODO

# 1. criar projeto docker ok
# 2. configurar mongo db ok
# 3. criar controller api v1 quotes_controller ( add rota no routes) ok
# 4. criar model quote ok
# 5. criar action index ok
# 6. na action index.
# 6.1 pesquisar no banco a existencia da tag
# 6.2 se existir, retornar JSON
# 6.3 senão, Executar  params = QuotesCrawler.fetch_by_tag(tag) e criar novos registros de Quote
