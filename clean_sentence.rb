#!/usr/bin/env ruby

input = gets
exit if input.nil?

sentence = input.strip

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
  sentence = sentence[0].upcase + sentence[1..].downcase
end

# Remove trailing commas
sentence = sentence.sub(/,+\z/, '')

# Add appropriate ending punctuation
if use_exclamation
  sentence += '!'
elsif use_question
  sentence += '?'
else
  sentence += '.'
end

puts sentence
