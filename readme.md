# CoderNight Solution - Chess Validator

## Assignment
[\[#13\] Chess Validator - PuzzleNode](http://www.puzzlenode.com/puzzles/13-chess-validator)

## Mission Statement
TDDing solution.  Attempting to decouple tests from specific implementation.

## Status
This month's project took longer than I expected and I was not able to finish on time.  Here's the current status:

### Complete
- Board parsing
- Algebraic Notation calculator
- Pawn move validation

### Incomplete
- Pieces other than pawns
- Command line interface

## Expected Changes
- It appears that `PieceBase` descendants only need to implement `get_valid_move_criteria`.  This probably means that inheritance is not the best strategy.  Refactor to parameterize a piece with its move validation criteria.
- I really don't like using strings to represent color.
- It might be useful to encapsulate algebraic notation coordinates in a class.
