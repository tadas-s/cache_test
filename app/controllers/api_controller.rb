# frozen_string_literal: true
# nodoc
class ApiController < ApplicationController
  def foo
    expires_in 1.hour, public: true

    srand params[:seed].to_i

    length = rand(100)
    response = { seed: params[:seed].to_i }

    (1..length).each do |n|
      response["prop-#{n}"] = ('a'..'z').to_a.sample(64).join
    end

    render json: response
  end
end
