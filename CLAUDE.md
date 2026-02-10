# Development Notes

## Running Tests

Always run tests with `bundle exec`:

```bash
bundle exec ruby test_clean_sentence.rb
```

## Special Case Words

The script preserves capitalization for certain words that should not be downcased. These are configured in the `SPECIAL_CASE_WORDS` constant at the top of `clean_sentence.rb`.

To add new words, add them to the array using one entry per line:

```ruby
SPECIAL_CASE_WORDS = %w(
  I
  Sarah
  Chip
  Emma
  NewName
)
```

## Trailing Line Numbers

The script handles trailing line numbers in the format ` [123]` (space, opening bracket, digits, closing bracket). These line numbers are preserved and placed after the ending punctuation.

For example:
- Input: `"i saw sarah and chip [1]"`
- Output: `"I saw Sarah and Chip. [1]"`

The regex pattern used to detect trailing line numbers is: ` \[\d+\]$`
