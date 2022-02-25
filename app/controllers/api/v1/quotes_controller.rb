class Api::V1::QuotesController < ApplicationController
  def index
    quotes = []
    quotes = Quote.where(:tags.in => [params[:tag]]).to_a
    if quotes.empty?
      quotes_attributes = QuotesCrawler.fetch_by_tag(params[:tag])
      quotes_attributes.each do |quote_attributes|
        quotes << Quote.create(quote_attributes)
      end
    end
    render json: { quotes: quotes }, status: 200
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end
end