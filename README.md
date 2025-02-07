# GridKid
## Introduction

GridKid is a terminal-based spreadsheet program that can store expressions, evaluations, and formulas in cells. This program was written based on the guidelines set by [Dr. Chris Johnson](https://twodee.org) from James Madison University for CS430 (Programming Languages) in the Spring semester of 2024. This project was designed to practice implementing expression hierarchies, parsers, lexers, TUI libraries, and Ruby.

## Running GridKid

To run the GridKid program, ensure you have the right version of Ruby (3.2.0 - 3.2.2) by checking the version:

```sh
ruby --version
```

If the version differs, then install and set the correct one. There are [multiple ways](https://superuser.com/questions/340490/how-to-install-and-use-different-versions-of-ruby) to do this.

You will need the Curses library installed. You can check this by running:

```sh
gem list
```

If Curses does not appear in the list, then you can install it by following the following [Linux guide](https://www.cyberciti.biz/faq/linux-install-ncurses-library-headers-on-debian-ubuntu-centos-fedora/).

Next, enter the 'Project 3' directory. This directory contains the executable:

```sh
cd 'Project 3'
```

Next, run the following program to start GridKid in your terminal:

```sh
ruby screen.rb
```

Your terminal should display the following user interface:

![GridKid TUI](/GridKid-TUI.png)

_Note: The TUI may not fit in your current terminal window size. To avoid bugs, exit the program by pressing the backtick (`) key and running the program again after resizing your terminal._

## Using GridKid

The GridKid TUI shows three panels: Evaluation, Formula, and the Grid. To edit a cell, the TUI cursor must be in the formula editor. The evaluation updates after the editor mode is toggled. The cell and formula panel show the source text and the evaluation panel shows the evaluation of that text. To evaluate an expression, the formula editor should start with an equal sign (=) followed by the expression. Otherwise, the text would be treated as a string primitive as long as it is not any other primitive.

![GridKid Usage](https://github.com/Pogoretskiy777/GridKid/blob/main/gridkid.gif)

Since the program is TUI-based, GridKid is controlled exclusively through the keyboard. Here are the following hotkeys:

- **Toggle editor mode:** TAB
- **Move right:** Right Arrow Key
- **Move left:** Left Arrow Key
- **Move up:** Up Arrow Key
- **Move down:** Down Arrow Key
- **Exit program:** Backtick Key (`)

### GridKid supports the following:

**Primitives:**

- Integers
- Floating-point
- Strings
- Booleans _(TRUE/true or FALSE/false)_

**Expressions:**

- Addition _(+)_
- Subtraction _(-)_
- Multiplication _(*)_
- Division _(/)_
- Exponentiation _(**)_
- Negation _(-)_
- Logical Operators _(>, >= ,< ,<= ,== ,!=, !)_
- Bitwise Operators _(>>, <<)_

**Formulas:**

- Max _(max([col1, row1], [col2, row2])_
- Min _(min([col1, row1], [col2, row2])_
- Mean _(mean([col1, row1], [col2, row2])_
- Sum _(sum([col1, row1], [col2, row2])_
