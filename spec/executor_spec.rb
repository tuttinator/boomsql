require 'spec_helper'

describe Boomsql::Executor do
  
  it "initialises with an ssh_credentials key in the options has" do


    options = { ssh_credentials: { username: "test", host: "example@transcribeme.com", port: 22 } }
    expect(Boomsql::Executor.new(options)).to be
    # or not to be? That is the question.
    # Whether 'tis Nobler in the mind to suffer
    # The Slings and Arrows of outrageous Fortune,
    # Or to take Arms against a Sea of troubles,
    # And by opposing end them

    # I'm sorry. I had to.

  end

end