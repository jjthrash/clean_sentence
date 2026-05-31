#!/usr/bin/env ruby

require 'minitest/autorun'

class TestCleanSentence < Minitest::Test
  def run_clean_sentence(input)
    `echo #{input.inspect} | ruby clean_sentence.rb`.chomp
  end

  def test_empty_input
    assert_equal "", run_clean_sentence("")
  end

  def test_basically_empty_input
    assert_equal "", run_clean_sentence("  ")
  end

  def test_only_punctuation
    assert_equal "", run_clean_sentence(",")
    assert_equal "", run_clean_sentence("?")
    assert_equal "", run_clean_sentence(".")
    assert_equal "", run_clean_sentence("!")
  end

  def test_basic_sentence_without_punctuation
    assert_equal "Hello world.", run_clean_sentence("hello world")
  end

  def test_sentence_with_mixed_case
    assert_equal "Hello world.", run_clean_sentence("hello WORLD")
  end

  def test_all_caps_sentence
    assert_equal "Hello world.", run_clean_sentence("HELLO WORLD")
  end

  def test_sentence_with_exclamation_at_end
    assert_equal "Hello world!", run_clean_sentence("hello world!")
  end

  def test_exclamation_in_middle
    assert_equal "Hello world!", run_clean_sentence("hello! world")
  end

  def test_question_mark_at_end
    assert_equal "Hello world?", run_clean_sentence("hello world?")
  end

  def test_question_mark_in_middle
    assert_equal "What is this?", run_clean_sentence("what? is this")
  end

  def test_multiple_exclamations
    assert_equal "Wow this is great!", run_clean_sentence("wow! this is great!")
  end

  def test_period_in_middle
    assert_equal "Hello world.", run_clean_sentence("hello. world")
  end

  def test_multiple_periods
    assert_equal "Hello world.", run_clean_sentence("hello. world.")
  end

  def test_trailing_comma
    assert_equal "Hello world.", run_clean_sentence("hello world,")
  end

  def test_multiple_trailing_commas
    assert_equal "Hello world.", run_clean_sentence("hello world,,")
  end

  def test_comma_in_middle_preserved
    assert_equal "Hello, world.", run_clean_sentence("hello, world")
  end

  def test_extra_whitespace
    assert_equal "Hello world.", run_clean_sentence("  hello world  ")
  end

  def test_already_properly_formatted
    assert_equal "Hello world.", run_clean_sentence("hello world.")
  end

  def test_question_with_question_mark
    assert_equal "Is this a question?", run_clean_sentence("is this a question?")
  end

  def test_multiple_periods_in_middle
    assert_equal "This is a test.", run_clean_sentence("this. is. a. test")
  end

  def test_all_caps_with_exclamation
    assert_equal "Wow this is amazing!", run_clean_sentence("WOW! THIS IS AMAZING!")
  end

  def test_mixed_punctuation_last_wins
    assert_equal "What really no way!", run_clean_sentence("what? really! no way.")
  end

  # Special case words
  def test_pronoun_i_preserved
    assert_equal "I am happy.", run_clean_sentence("i am happy")
    assert_equal "Hello I am here.", run_clean_sentence("hello i am here")
  end

  def test_names_preserved
    assert_equal "Sarah is here.", run_clean_sentence("sarah is here")
    assert_equal "Hello Chip.", run_clean_sentence("hello chip")
    assert_equal "Hi Emma.", run_clean_sentence("hi emma")
  end

  def test_multiple_special_cases
    assert_equal "I saw Sarah and Chip.", run_clean_sentence("i saw sarah and chip")
  end

  def test_double_commas
    assert_equal "How, modifiable, modulatable our patterns.", run_clean_sentence("How,, modifiable, modulatable. Our patterns.")
  end

  def test_leave_trailing_line_numbers_alone
    assert_equal "I saw Sarah and Chip. [1]", run_clean_sentence("i saw sarah and chip [1]")
  end

  def test_comma_before_period_with_line_number
    assert_equal "At the very least, we should not demand that art fit a reductionist view in some way. [53]", run_clean_sentence("At the very least, we should not demand that art fit a reductionist view in some way,. [53]")
  end

  def test_respect_markdown_bolding
    assert_equal "**But** belief is a function of the mind. [13]", run_clean_sentence("**but** belief is a function of the mind. [13]")
  end

  def test_respect_trailing_obsidian_block_identifier
    assert_equal "**But** belief is a function of the mind. [13] ^asdf1", run_clean_sentence("**but** belief is a function of the mind. [13] ^asdf1")
  end
end
