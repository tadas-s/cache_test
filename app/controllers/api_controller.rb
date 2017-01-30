# frozen_string_literal: true
# nodoc
class ApiController < ApplicationController
  def api
    expires_in 24.hour, public: true

    srand params[:seed].to_i

    # will generate random json responses from 50 to 4000 bytes
    length = rand(100)
    response = { seed: params[:seed].to_i }

    (1..length).each do |n|
      response["prop-#{n}"] = ('a'..'z').to_a.sample(64).join
    end

    render json: response
  end
end
