class Api::V1::QuotesController < ApplicationController
  before_action :authenticate_user!

  def index
    params_to_scrub = %i[_id created_at updated updated_at user_id]
    @quotes = []
    @quotes = Quote.where(:tags.in => [params[:tag]]).to_a
    if @quotes.empty?
      quotes_attributes = QuotesCrawler.fetch_by_tag(params[:tag])
      quotes_attributes.each do |quote_attributes|
        @quotes << Quote.create(quote_attributes)
      end
    end
    render json: { quotes: @quotes }, except: params_to_scrub, status: 200
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end
end
