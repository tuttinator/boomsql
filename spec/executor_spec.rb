require 'spec_helper'

describe Boomsql::Executor do
  
  context "using only ssh credentials" do

    before :each do
      options = YAML::load(File.read "./spec/fixtures/boomsql.yml")
      @executor = Boomsql::Executor.new(options)
    end

    it "initialises correctly" do

      expect(@executor).to be
      # or not to be? That is the question.
      # Whether 'tis Nobler in the mind to suffer
      # The Slings and Arrows of outrageous Fortune,
      # Or to take Arms against a Sea of troubles,
      # And by opposing end them

      # I'm sorry. I had to.

    end

    it "uses the DatabaseProxy without a valid direct database connection" do
      expect(@executor.client.class).to be(Boomsql::DatabaseProxy)
    end

  end



end