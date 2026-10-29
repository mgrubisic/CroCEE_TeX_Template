%% Elsevier.bst
%% BibTeX implementation of the CSL style
%%   "Elsevier (numeric, with titles)"
%%   http://www.zotero.org/styles/elsevier-with-titles
%% (CSL style by Richard Karnesky and Rintze Zelle, licensed under
%%  Creative Commons Attribution-ShareAlike 3.0,
%%  http://creativecommons.org/licenses/by-sa/3.0/ ).
%% This BibTeX file is a derived work and is therefore also distributed
%% under CC BY-SA 3.0. It follows the same formatting rules, so that Word
%% (Zotero/Mendeley) and LaTeX papers use the same reference style; it is not
%% guaranteed to give byte-identical lists for every possible record.
%%
%% - numbered in order of citation, [1] in the text and in the list
%%   (the class CroCEE.cls typesets the list; no natbib is needed)
%% - names "J.J. Surname", all authors, separated by ", "; "and others" -> "et al."
%% - initials are UTF-8 aware (Š, Đ, Č, Ć, Ž ... are not split)
%% - article:  Authors, Title, Journal Volume (Year) Pages. https://doi.org/DOI.
%% - book/report: Authors, Title, Nth ed., Publisher, Address, Year.
%% - chapter/proceedings: Authors, Title, in: Editors (Eds.), Booktitle,
%%             Nth ed., Publisher, Address, Year: pp. Pages.
%% - thesis:   Authors, Title, PhD thesis, School, Year.
%% - online:   Authors, Title, (Year). URL (accessed Month D, YYYY).
%% - other:    Authors, Title, Howpublished (Year).
%%
%% Version 1.1 (2026-10-28), 4CroCEE 2027
%% Written for the 4CroCEE template by Vedran Jagodnik and Marin Grubisic
%% with the assistance of Claude.

ENTRY
  { address author booktitle chapter doi edition editor howpublished
    institution journal key month note number organization pages
    publisher school series title type url urldate volume year }
  {}
  { label }

INTEGERS { nameptr namesleft numnames len i cc atstart }
STRINGS  { s t out u genre w ini ch fn }

FUNCTION {not}
{ { #0 } { #1 } if$ }

FUNCTION {and}
{ 'skip$ { pop$ #0 } if$ }

FUNCTION {or}
{ { pop$ #1 } 'skip$ if$ }

FUNCTION {field.or.null}
{ duplicate$ empty$ { pop$ "" } 'skip$ if$ }

FUNCTION {add.sep}   % field sep -> (modifies out)
{ 't :=
  's :=
  s empty$
    'skip$
    { out empty$
        { s 'out := }
        { out t * s * 'out := }
      if$ }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
  { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't := }
            { { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't := }
              while$ }
          if$ }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't := }
      if$ }
  while$
}

FUNCTION {format.pages}
{ pages empty$ { "" } { pages n.dashify } if$ }

FUNCTION {month.name}   % "11" -> "Nov"
{ 't :=
  t "01" = t "1" = or { "Jan" } {
  t "02" = t "2" = or { "Feb" } {
  t "03" = t "3" = or { "Mar" } {
  t "04" = t "4" = or { "Apr" } {
  t "05" = t "5" = or { "May" } {
  t "06" = t "6" = or { "Jun" } {
  t "07" = t "7" = or { "Jul" } {
  t "08" = t "8" = or { "Aug" } {
  t "09" = t "9" = or { "Sep" } {
  t "10" = { "Oct" } {
  t "11" = { "Nov" } {
  t "12" = { "Dec" } { t }
  if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$
}

FUNCTION {strip.zero}
{ duplicate$ #1 #1 substring$ "0" =
    { #2 global.max$ substring$ }
    'skip$
  if$
}

%% ---------- names ----------
%% First "character" of w: one UTF-8 sequence (2-4 bytes) when the first byte
%% is a UTF-8 lead byte; otherwise text.prefix$ (which keeps {\v{S}} together).
FUNCTION {first.char}
{ 'w :=
  w #1 #1 substring$ chr.to.int$ 'cc :=
  cc #192 <
    { w #1 text.prefix$ }
    { cc #224 <
        { w #1 #2 substring$ }
        { cc #240 <
            { w #1 #3 substring$ }
            { w #1 #4 substring$ }
          if$ }
      if$ }
  if$
}

%% "Julian J." -> "J.J.";  "Jean-Pierre" -> "J.-P.";  "Šime" -> "Š."
FUNCTION {initials}
{ 'fn :=
  "" 'ini :=
  #1 'atstart :=
  { fn empty$ not }
    { fn #1 #1 substring$ 'ch :=
      ch " " = ch "~" = or
        { #1 'atstart := }
        { ch "-" =
            { ini "-" * 'ini := #1 'atstart := }
            { atstart
                { ini fn first.char * "." * 'ini :=
                  #0 'atstart := }
                'skip$
              if$ }
          if$ }
      if$
      fn #2 global.max$ substring$ 'fn := }
  while$
  ini
}

FUNCTION {format.names}   % names -> string
{ 's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  { namesleft #0 > }
    { nameptr numnames = s nameptr "{ll}" format.name$ "others" = and
        { t empty$ { "et al." 't := } { t ", et al." * 't := } if$ }
        { s nameptr "{ff}" format.name$ initials 'u :=
          u empty$
            { s nameptr "{vv~}{ll}{, jj}" format.name$ }
            { u u text.length$ #3 >
                { " " * } { "~" * } if$
              s nameptr "{vv~}{ll}{, jj}" format.name$ *
            }
          if$
          nameptr #1 >
            { t ", " * swap$ * 't := }
            { 't := }
          if$ }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  t
}

FUNCTION {format.authors}
{ author empty$
    { editor empty$
        { organization field.or.null }
        { editor format.names
          editor num.names$ #1 > { ", Eds." * } { ", Ed." * } if$ }
      if$ }
    { author format.names }
  if$
}

FUNCTION {format.editors.in}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 > { " (Eds.)" * } { " (Ed.)" * } if$ }
  if$
}

FUNCTION {is.digit}   % one-char string -> bool
{ chr.to.int$ 'i :=
  i #47 > i #58 < and
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition "1" =
        { "" }
        { edition #-1 #1 substring$ is.digit not
            { edition }
            { "th"
              edition text.length$ #1 >
                { edition #-2 #1 substring$ "1" = }
                { #0 }
              if$
                'skip$
                { edition #-1 #1 substring$ "1" = { pop$ "st" } 'skip$ if$
                  edition #-1 #1 substring$ "2" = { pop$ "nd" } 'skip$ if$
                  edition #-1 #1 substring$ "3" = { pop$ "rd" } 'skip$ if$ }
              if$
              edition swap$ * " ed." * }
          if$ }
      if$ }
  if$
}

FUNCTION {format.year}
{ year empty$ { "n.d." } { year } if$ }

%% urldate = YYYY-MM-DD -> "November 29, 2020"
FUNCTION {long.month}
{ 't :=
  t "01" = { "January" } {
  t "02" = { "February" } {
  t "03" = { "March" } {
  t "04" = { "April" } {
  t "05" = { "May" } {
  t "06" = { "June" } {
  t "07" = { "July" } {
  t "08" = { "August" } {
  t "09" = { "September" } {
  t "10" = { "October" } {
  t "11" = { "November" } {
  t "12" = { "December" } { t }
  if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$
}

FUNCTION {format.access}
{ url empty$
    { "" }
    { "\url{" url * "}" *
      urldate empty$
        'skip$
        { urldate text.length$ #10 =
            { " (accessed "
              urldate #6 #2 substring$ long.month * " " *
              urldate #9 #2 substring$ strip.zero * ", " *
              urldate #1 #4 substring$ * ")" * }
            { " (accessed " urldate * ")" * }
          if$
          * }
      if$ }
  if$
}

FUNCTION {begin.entry}
{ newline$ "\bibitem{" write$ cite$ write$ "}" write$ newline$
  "" 'out :=
  format.authors ", " add.sep
}

%% DOI, else URL; final period
FUNCTION {strip.final.dot}
{ out empty$
    'skip$
    { out out text.length$ #1 substring$ "." =
        { out #1 out text.length$ #1 - substring$ 'out := }
        'skip$
      if$ }
  if$
}

FUNCTION {finish.entry}
{ strip.final.dot
  doi empty$
    { format.access ". " add.sep }
    { "\url{https://doi.org/" doi * "}" * ". " add.sep }
  if$
  out "." * write$ newline$
}

%% "Publisher, Address, Year" appended with ", "
FUNCTION {add.publisher}   % publisher-string on stack
{ ", " add.sep
  address field.or.null ", " add.sep
  format.year ", " add.sep
}

%% ---------- entry types ----------
FUNCTION {article}
{ begin.entry
  title empty$ 'skip$ { title "," * ", " add.sep } if$
  journal field.or.null " " add.sep
  volume field.or.null " " add.sep
  "(" format.year * ")" * " " add.sep
  format.pages " " add.sep
  finish.entry
}

FUNCTION {book}
{ begin.entry
  title field.or.null ", " add.sep
  format.edition ", " add.sep
  publisher field.or.null add.publisher
  finish.entry
}

FUNCTION {techreport}
{ begin.entry
  title field.or.null ", " add.sep
  institution field.or.null add.publisher
  finish.entry
}

FUNCTION {manual} { techreport }

FUNCTION {incollection}
{ begin.entry
  title field.or.null ", " add.sep
  "in:" ", " add.sep
  format.editors.in " " add.sep
  out format.editors.in empty$ { " " } { ", " } if$ * 'out :=
  booktitle field.or.null "" add.sep
  format.edition ", " add.sep
  publisher field.or.null ", " add.sep
  address field.or.null ", " add.sep
  format.year ", " add.sep
  pages empty$ 'skip$ { out ": pp. " * format.pages * 'out := } if$
  finish.entry
}

FUNCTION {inproceedings} { incollection }
FUNCTION {conference}    { incollection }
FUNCTION {inbook}        { incollection }

FUNCTION {thesis.common}
{ 'genre :=
  begin.entry
  title field.or.null ", " add.sep
  type empty$ { genre } { type } if$ ", " add.sep
  school field.or.null ", " add.sep
  format.year ", " add.sep
  finish.entry
}

FUNCTION {phdthesis}     { "PhD thesis" thesis.common }
FUNCTION {mastersthesis} { "Master's thesis" thesis.common }

%% online / misc: "Title, Container (Year)" (CSL "else" branch)
FUNCTION {misc}
{ begin.entry
  title empty$ 'skip$ { title "," * ", " add.sep } if$
  howpublished field.or.null " " add.sep
  "(" format.year * ")" * " " add.sep
  finish.entry
}

FUNCTION {online}      { misc }
FUNCTION {webpage}     { misc }
FUNCTION {electronic}  { misc }
FUNCTION {booklet}     { misc }
FUNCTION {unpublished} { misc }
FUNCTION {default.type} { misc }

%% ---------- driver ----------
READ

FUNCTION {begin.bib}
{ preamble$ empty$ 'skip$ { preamble$ write$ newline$ } if$
  "\begin{thebibliography}{99}" write$ newline$
  "\providecommand{\url}[1]{\texttt{#1}}" write$ newline$
}

EXECUTE {begin.bib}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$ "\end{thebibliography}" write$ newline$ }

EXECUTE {end.bib}
