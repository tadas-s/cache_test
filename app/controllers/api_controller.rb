# frozen_string_literal: true
# nodoc
class ApiController < ApplicationController
  def foo
    render json: { foo: 'bar' }
  end
end
