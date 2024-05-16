require 'curses'
require_relative '../Project 2/lexer.rb'
require_relative '../Project 2/parser.rb'
require_relative '../Project 1/primitives.rb'
require_relative '../Project 1/evaluator.rb'
require_relative '../Project 1/serializer.rb'

include Curses

# Initiate new Grid structure
gridkid = Grid.new(15, 5)

init_screen
noecho
start_color

# Highlight color to indiciate current position in the cell
init_pair(1, 1, 2)

# Create TUI panels
half_width = cols / 2
evaluation_panel = Window.new(5, 60, 0, 1)
formula_panel = Window.new(5, 60, 0, 70)
grid = Window.new(13, 129, 6, 1)

# Enable keypad compatibility
grid.keypad(true)
evaluation_panel.keypad(true)
formula_panel.keypad(true)

# Draw initial evaluation window
evaluation_panel.box("|", "-")
evaluation_panel.setpos(2, 2)
evaluation_panel.addstr("Evaluation: ")

# Serialize primitive based off of type
def tree_serializer(tree)
  if tree.is_a?(Primitive::NumericPrimitive)
    return tree.value.to_s
  elsif tree.is_a?(Primitive::Boolean)
    return tree.bool.to_s
  elsif tree.is_a?(Primitive::String)
    return tree.chars
  else
    return "Error" # In case something goes wrong
  end
end

# Draw the grid
def build_grid(grid, gridkid, cell_eval, curr_row, curr_col)
  # Draw top line of grid
  grid.setpos(0, 0)
  grid.addstr("\u250c")
  (1...128).each do |i|
    if i % 8 == 0
    grid.addstr("\u252c")
    else
    grid.addstr("\u2500")
    end
  end
  grid.addstr("\u2510")

  # Draw column numbers
  grid.setpos(1, 0)
  grid.addstr("\u2502       \u2502   0   \u2502   1   \u2502   2   \u2502   3   \u2502   4   \u2502   5   \u2502   6   \u2502   7   \u2502   8   \u2502   9   \u2502   10  \u2502   11  \u2502   12  \u2502   13  \u2502   14  \u2502")

  # Draw horizontal lines
  (2..11).step(2) do |row|
    grid.setpos(row, 0)
    grid.addstr("\u251c")
    (1...128).each do |i|
      if i % 8 == 0
        grid.addstr("\u253c")
      else
        grid.addstr("\u2500")
      end
    end
    grid.addstr("\u2524")
  end
  
  # Draw numbered rows
  (3..11).step(2) do |row|
    grid.setpos(row, 0)
    grid.addstr("\u2502   #{(row - 3) / 2}   \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502       \u2502")
  end

  grid.setpos(12, 0)
  grid.addstr("\u2514")
  (1...128).each do |i|
    if i % 8 == 0
    grid.addstr("\u2534")
    else
    grid.addstr("\u2500")
    end
  end
  grid.addstr("\u2518")

  # Add all evaluated values into the grid
  cell_eval.each_with_index do |col, i|
    col.each_with_index do |value, j|
      if value != ""
        grid.setpos(3 + (i * 2), 9 + (j * 8))

        # Highlight current cell position
        if curr_col == j && curr_row == i
          grid.attron(color_pair(1))
          grid.addstr(cell_eval[i][j][0..6])
          grid.attroff(color_pair(1))
        else
          grid.addstr(cell_eval[i][j][0..6])
        end
      end
    end
  end
  grid.refresh
end

# Refresh panels to update TUI
evaluation_panel.refresh
formula_panel.refresh

# Use panel index to flip back and forth between panels
panels = [formula_panel, grid]
panel_index = 1

cell_source = Array.new(5) {Array.new(15) {''}} # 2D array to store source code for all cells
cell_eval = Array.new(5) {Array.new(15) {''}}   # 2D array to store source code for all cells

# Set up initial cursor and cell positions
focus = true
quit = false
pos_row = 3
pos_col = 9
cell_row = 0
cell_col = 0

# Build the initial grid
build_grid(grid, gridkid, cell_eval, cell_row, cell_col)

# Enter program loop
loop do

  # Update formula panel to display current source code
  formula_panel.clear
  formula_panel.box("|", "-")
  formula_panel.setpos(2, 2)
  formula_panel.addstr("Formula: #{cell_source[cell_row][cell_col]}")
  formula_panel.refresh

  # Update evaluation of all cells when focus is on the grid
  if focus
    evaluation_panel.clear
    evaluation_panel.box("|", "-")
    evaluation_panel.setpos(2, 2)

    cell_source.each_with_index do |col, i|
      col.each_with_index do |value, j|
        if cell_source[i][j] != ''

          # Evaluate the cell's source code to primitive if followed by '='
          if cell_source[i][j][0] == '='
            lexer = Lexer.new(cell_source[i][j][1..-1])
            tokens = lexer.lex
            parser = Parser.new(tokens)
            tree = parser.parse
            gridkid.set_cell(Primitive::CellAddress.new(i, j), tree)
            evaluation = gridkid.get_cell(Primitive::CellAddress.new(i, j))

            serial_eval = tree_serializer(evaluation)
            cell_eval[i][j] = serial_eval
            eval_txt = "Evaluation: #{serial_eval}"

            # Update evaluation panel if position is on current cell
            if i == cell_row && j == cell_col
              evaluation_panel.addstr(eval_txt[0..53])
            end
          else
            lexer = Lexer.new(cell_source[i][j])
            tokens = lexer.lex
            parser = Parser.new(tokens)
            tree = parser.parse
            evaled = tree.traverse(Evaluator.new, Runtime.new(gridkid))

            # Error handling for invalid primitives
            if tree_serializer(evaled) == "Error"
              cell_eval[i][j] = "#{cell_source[i][j]}"
              if i == cell_row && j == cell_col
                evaluation_panel.addstr("Evaluation: #{cell_source[i][j]}")
              end

            # Store String primitive if serialized AST doesn't match source code
            elsif tree_serializer(evaled) != cell_source[i][j].to_s
              gridkid.set_cell(Primitive::CellAddress.new(i, j), Primitive::String.new(cell_source[i][j]))
              evaluation = gridkid.get_cell(Primitive::CellAddress.new(i, j))

              # Update evaluation panel if position is on current cell
              if i == cell_row && j == cell_col
                evaluation_panel.addstr("Evaluation: #{evaluation.chars}")
              end
              cell_eval[i][j] = "#{evaluation.chars}"
            
            # Store primitives as is (Integer, Float, etc)
            else
              gridkid.set_cell(Primitive::CellAddress.new(i, j), evaled)
              serial_eval = tree_serializer(evaled)
              cell_eval[i][j] = "#{serial_eval}"
              if i == cell_row && j == cell_col
                evaluation_panel.addstr("Evaluation: #{serial_eval}")
              end
            end
          end
        else
          # Dealing with empty cells
          if i == cell_row && j == cell_col
            evaluation_panel.addstr("Evaluation: Empty")
          end
        end
      end
    end
    evaluation_panel.refresh
  end
  
  # Build grid when in focus
  if focus
    build_grid(grid, gridkid, cell_eval, cell_row, cell_col)
  end

  # Set cursor positions
  grid.setpos(pos_row, pos_col)
  formula_panel.setpos(2, 11 + cell_source[cell_row][cell_col].length)

  # Enter loop to wait for user input
  loop do
    c = panels[panel_index].getch
    case c
    when 260  # Left arrow key
      if focus
        if !((pos_col - 8) < 3)
          cell_col -= 1
          pos_col -= 8
        end
      end
      break
    when 261  # Right arrow key
      if focus
        if !((pos_col + 8) > 121)
          cell_col += 1
          pos_col += 8
        end
      end
      break
    when 259  # Up arrow key
      if focus
        if !((pos_row - 2) < 3)
          cell_row -= 1
          pos_row -= 2
        end
      end
      break
    when 258  # Down arrow key
      if focus
        if !((pos_row + 2) > 11)
          cell_row += 1
          pos_row += 2
        end
      end
      break
    when 9   # Tab button alternates between focus and edit mode
      panel_index += 1
      panel_index %= panels.length
      if panel_index == 1
        focus = true
      else 
        focus = false
      end
      break
    when '`' # Backtick is how you exit
      quit = true
      break
    when 127 # Backspace
      if !focus
        cell_source[cell_row][cell_col].chop!
      end
      break
    else
      if !focus
        cell_source[cell_row][cell_col] += c.chr
      end
      break
    end  
  end

  # Exit loop when ` is pressed
  if quit
    break
  end
end

close_screen