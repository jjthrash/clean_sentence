#!/usr/bin/env ruby

# Words that should always be capitalized (case-insensitive match)
SPECIAL_CASE_WORDS = %w(
  I
  Sarah
  Chip
  Emma
  Jason
  Martin
)

input = gets

sentence = input.strip
exit if sentence.nil? || sentence.empty?

# Extract trailing line number if present (before other processing)
trailing_line_number = nil
if sentence =~ / \[\d+\]$/
  trailing_line_number = sentence[/ \[\d+\]$/]
  sentence = sentence.sub(/ \[\d+\]$/, '')
end

# Find the last occurrence of exclamation or question mark
last_exclamation = sentence.rindex('!')
last_question = sentence.rindex('?')

# Determine which punctuation to use (last one wins)
use_exclamation = false
use_question = false

if last_exclamation && last_question
  # Both present - use whichever comes last
  if last_exclamation > last_question
    use_exclamation = true
  else
    use_question = true
  end
elsif last_exclamation
  use_exclamation = true
elsif last_question
  use_question = true
end

# Remove all exclamation points, question marks, and periods from the sentence
sentence = sentence.gsub(/[!?.]/, '')

# Downcase words in the middle of the sentence (capitalize first letter)
sentence = sentence.strip
if sentence.length > 0
  # Find the first alphabetic character and capitalize it
  if sentence =~ /[a-z]/i
    first_letter_index = sentence.index(/[a-z]/i)
    sentence = sentence[0...first_letter_index] +
               sentence[first_letter_index].upcase +
               sentence[first_letter_index+1..].downcase
  else
    sentence = sentence.downcase
  end
end

# Restore special-case words to their proper capitalization
SPECIAL_CASE_WORDS.each do |word|
  sentence.gsub!(/\b#{Regexp.escape(word)}\b/i, word)
end

# Remove double commas
sentence.gsub!(/,{2,}/, ',')

# Remove trailing commas
sentence = sentence.sub(/,+\z/, '')

# Exit if sentence is empty after cleaning
exit if sentence.empty?

# Add appropriate ending punctuation
if use_exclamation
  sentence += '!'
elsif use_question
  sentence += '?'
else
  sentence += '.'
end

# Re-append trailing line number if it was present
if trailing_line_number
  sentence += trailing_line_number
end

puts sentence
