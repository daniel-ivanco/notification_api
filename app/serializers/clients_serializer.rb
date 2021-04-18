# frozen_string_literal: true

# clients serializer
class ClientsSerializer
  attr_reader :clients

  def initialize(clients:)
    @clients = clients
  end

  def to_json(*_args)
    @to_json ||= Oj.dump(to_h)
  end

  def to_h
    {
      clients: clients.map { |client| client.attributes.except('id') }
    }
  end
end
