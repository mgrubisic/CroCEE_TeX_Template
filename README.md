# 4CroCEE 2027 – LaTeX template for full papers and extended abstracts

LaTeX template for the 4th Croatian Conference on Earthquake Engineering (4CroCEE,
22–25 March 2027, Opatija, Croatia; <https://crocee.grad.hr/event/4/>). The class
`CroCEE.cls` follows the page geometry and typography of the conference's Word templates
(A4, Palatino 11 pt, line spacing exactly 1.2 × font size, the same spacing of headings,
captions, equations and references), so that papers written in Word and in LaTeX look
alike in the proceedings. See [Validation](#validation) for what has been compared with
Word and what has not.

Questions and bug reports: the conference secretariat (crocee@grad.hr) or the issue
tracker of this repository.

## Files

```
4CroCEE_FullPaper.tex          full paper example – copy it and write your paper in it
4CroCEE_ExtendedAbstract.tex   extended abstract example (class option "extended")
Definitions/CroCEE.cls         document class – all formatting; do not edit
Definitions/Elsevier.bst       BibTeX style (Elsevier numeric, with titles)
Definitions/Elsevier.csl       the same style for Zotero / Mendeley (Word users)
Bibliography/References.bib    example BibTeX database, one entry of each type
Figures/4CroCEE_logo.png       header logo (used by the class)
Figures/example_figure.png     example figure (low-resolution placeholder) – delete in your paper
README.md                      this file
```

Keep the folder structure: the class is loaded from the folder of the `.tex` file, the BibTeX
style from `Definitions/` and the logo from `Figures/`.

## Requirements and compiling

- **LaTeX kernel 2022-06-01 or newer** (TeX Live 2022+, MiKTeX 22.7+, current Overleaf).
  The class uses `\fpeval` and the kernel hooks; older installations are not supported.
- **Engines.** pdfLaTeX and XeLaTeX have been tested (TeX Live 2023). LuaLaTeX has not
  been tested; the class uses the same `fontspec` branch for it as for XeLaTeX.
- **Fonts.** The Word template uses Palatino Linotype.
  - pdfLaTeX: `newpx` if installed, otherwise `mathpazo` (URW Palladio). These are
    Palatino-style fonts, **not** Palatino Linotype, so line and page breaks can differ
    slightly from Word.
  - XeLaTeX / LuaLaTeX: Palatino Linotype if installed, otherwise TeX Gyre Pagella (the class
    prints a warning). Whether the glyph widths equal those of Palatino Linotype has not
    been verified.
- **Packages** (all in standard TeX Live / MiKTeX / Overleaf): `amsmath`, `iftex`,
  `fontenc` (T1), `newpx` or `mathpazo` (+ `fontspec` for XeLaTeX/LuaLaTeX), `bm`,
  `geometry`, `enumitem`, `graphicx`, `titlesec`, `caption`, `array`, `xcolor`, `booktabs`,
  `tabularx`, `changepage`, `endnotes`, `cite`, `url`, `hyperref`.

Unpack the folder (or upload the zip to Overleaf: *New Project → Upload Project*) and run

```
pdflatex 4CroCEE_FullPaper
bibtex   4CroCEE_FullPaper
pdflatex 4CroCEE_FullPaper
pdflatex 4CroCEE_FullPaper
```

Overleaf does this automatically. Source files are UTF-8; Croatian letters can be typed
directly in the text, in author names and in the `.bib` file.

Submit the complete source (`.tex`, `.bib`, figures) together with the compiled PDF.

**Note:** the example `4CroCEE_FullPaper.tex` is shorter than 6 pages, so its compilation
prints `The paper has 4 pages; the minimum is 6`. This is the page-length check of the class
(see [Length](#length)); it disappears when your paper has the required length.

## Class options

```latex
\documentclass{Definitions/CroCEE}           % full paper, 6–12 pages, with abstract
\documentclass[extended]{Definitions/CroCEE} % extended abstract, max. 2 pages, no abstract section
```

Further options: `noparindent` (no 1 cm indentation of paragraphs), `hyphenation` (allow
hyphenation; Word does not hyphenate), `nourlunderline` (URLs not underlined), `draft` and
`final` (passed to the `article` class). An unknown option is ignored with a warning.

## Title, authors, affiliations

```latex
\title{Title of the paper}          % printed in capitals automatically, max. two lines

\author[1]{First Author}            % number = affiliation mark
\author[1,2]{Second Author}
\author{Third Author}               % without mark

\affiliation[1]{Position, affiliation, e-mail address}
\affiliation[2]{Position, affiliation, e-mail address}

\begin{document}
\maketitle
```

- The title is converted to capital letters by the class (`\MakeUppercase`; Croatian letters
  are handled, mathematics is left unchanged). Protect text that must keep its case with
  `\NoCaseChange{...}`, e.g. `10 \NoCaseChange{kN}`.
- The PDF metadata (title in the original case, author names, subject, language) are
  filled in from `\title` and `\author`. If the title contains macros or mathematics,
  hyperref may warn about tokens "not allowed in a PDF string"; set the PDF title
  yourself with `\hypersetup{pdftitle={...}}` after `\begin{document}`.

## Abstract and keywords

```latex
\begin{abstract}          % full paper only; omit with the option extended
250 to 300 words, no references or equations.
\end{abstract}

\keywords{keyword1, keyword2, keyword3, keyword4}   % 4–8 keywords
```

In the extended abstract `\keywords` follows `\maketitle` directly.

## Sections, lists, footnotes, endnotes

```latex
\section{Introduction}          % 1.     13 pt bold
\subsection{Title}              % 1.1.   11 pt bold
\subsubsection{Title}           % 1.1.1. 11 pt bold (at most three levels)
\paragraph{Title} Text ...      % unnumbered bold run-in heading, 11 pt

\section*{Acknowledgements}     % unnumbered
\section*{Copyrights}
```

- `\paragraph` is **not** part of the Word template; the class styles it so that it looks
  consistent, but use it sparingly.
- `itemize` and `enumerate` are indented by 1.27 cm with a 0.635 cm label.
- `\footnote{...}` gives footnotes in 9 pt at the bottom of the page. The Word template
  does not define footnotes, so this style is the class's own choice.
- `\endnote{...}` marks an endnote (numbered i, ii, …); `\printendnotes` prints the list
  under the heading "Notes". Place it before the References.

Pages are not numbered; page numbers are added by the editors. The header with the logo is
added automatically.

## Tables

Caption above the table, centred, 10 pt. Tables span the full text width, use the `booktabs`
rules and have no vertical lines or shading:

```latex
\begin{table}
  \begin{adjustwidth}{-\extralength}{0cm}
  \caption{Dynamic properties of model.}
  \label{tab:modes}
  \begin{tabularx}{\fulllength}{cCCCC}      % C = centred stretching column
    \toprule
    \textbf{Mode} & \textbf{T (s)} & \textbf{Mx} & \textbf{My} & \textbf{MRz} \\
    \midrule
    1 & 0.116 & 0 & 0.833 & 0 \\
    \bottomrule
  \end{tabularx}
  \tablenotes{\textbf{Notes:} explanations of symbols (9 pt).}   % optional
  \end{adjustwidth}
\end{table}
```

In the text: `\tabref{tab:modes}` → "Table 1".

A very wide table may protrude into the **left** margin: put
`\setlength{\extralength}{1cm}` before the table and `\setlength{\extralength}{0cm}` after
it. `\fulllength` (the table width) is then the text width plus `\extralength`, and the
`adjustwidth` environment shifts the table to the left by the same amount, so the right edge
stays at the right margin.

## Figures

Caption below the figure, centred, 10 pt. Minimum resolution 300 dpi **at the printed size**;
PDF for diagrams and plots.

```latex
\begin{figure}
  \centering
  \includegraphics[width=\textwidth]{Figures/figure}
  \caption{a) Building plan; b) Numerical model.}
  \label{fig:model}
\end{figure}
```

In the text: `\figref{fig:model}` → "Fig. 1". The example figure is a 1024 px placeholder; at the
8.5 cm used in the examples it has about 300 dpi. Replace it with your own figure.

## Equations

```latex
\begin{equation}
  \matr{K}\,\vect{u} = \vect{f}
  \label{eq:static}
\end{equation}
```

- `\vect{u}` vector, `\matr{K}` matrix (both bold); scalars italic (default)
- in the text: `\Eqref{eq:static}` → "Eq. (1)"
- units upright, separated by a thin space: `10\,kN`

## References

Citation style: **Elsevier (numeric, with titles)** – an existing style of the CSL
repository (<http://www.zotero.org/styles/elsevier-with-titles>), available under that name in
Zotero and Mendeley. `Definitions/Elsevier.bst` implements the same formatting rules for
BibTeX, so that papers written in Word and in LaTeX use the same reference style. It has
been checked on the entry types of `Bibliography/References.bib`; byte-identical output to
Zotero/Mendeley is not guaranteed for every possible record.

- in the text: `\cite{DAyala2003,Bommer2010}` → [1,2]; `\cite{a,b,c,d}` → [1–4]
- in the list: [1], [2] … in order of first citation, 10 pt, hanging indent 0.63 cm
- names as *Initials Surname* (J.J. Bommer), all authors listed; `and others` → "et al."
- initials are UTF-8 aware: names such as Šime, Đuro, Čedo, Ćiro, Željka give Š., Đ., Č., Ć., Ž.
- no italics or bold; year near the end; full stop at the end

| Type | Example |
|---|---|
| Journal article | D. D'Ayala, E. Speranza, Definition of collapse mechanisms ..., Earthquake Spectra 19 (2003) 479–509. https://doi.org/10.1193/1.1599896. |
| Book chapter / proceedings | B. Brown, M. Aaron, Title, in: J. Smith (Ed.), Book Title, 3rd ed., Wiley, New York, 2001: pp. 230–257. |
| Proceedings without editor | G. Magenes, A. Penna, Title, in: 9th Australasian Masonry Conference (9AMC), Queenstown, New Zealand, 2011. |
| Book | A.K. Chopra, Dynamics of Structures, 5th ed., Pearson Education, USA, 2019. |
| Report | POLIMI, Title, Deliverable 3.3, NIKER Project, Italy, 2010. |
| Thesis | J.W. Trent, Title, PhD thesis, University of California, 1975. |
| Web source | K. Beyer, B. Wilding, A. Rezaie, Title, (2019). https://zenodo.org/record/2536830 (accessed November 29, 2020). |
| Personal communication | P. Horvat, Personal correspondence, (2019). |

The style does not print report numbers separately ("PEER 2014/05"); write them at the end
of the title, as in `Bibliography/References.bib`.

```latex
\bibliographystyle{Definitions/Elsevier}
\bibliography{Bibliography/References}
```

If `\bibliographystyle` is omitted, the class uses `Definitions/Elsevier.bst`. The heading
"References" is added automatically. `\setbibpreamble{...}` (text between the heading and
the list) is used in the examples only to explain the style – delete it in your paper.

Entry types in `.bib`: `@article`, `@book`, `@inproceedings`, `@incollection`,
`@techreport`, `@phdthesis`, `@mastersthesis`, `@online` (fields `url`,
`urldate = {YYYY-MM-DD}`), `@misc`; each has an example in `References.bib`. Write titles as
they should appear; protect proper names and acronyms with braces (`{Eurocode}`, `{URM}`).
Give the edition as a number: `edition = {5}`.

### Word users (Zotero / Mendeley)

- **Zotero**: Word add-in → *Document Preferences* → choose "Elsevier (numeric, with
  titles)". If it is not listed: *Settings → Cite → Get additional styles…*, or add
  `Elsevier.csl` with the **+** button.
- **Mendeley Cite**: *Citation Style* → search "Elsevier (numeric, with titles)".

## Hyperref, other packages

The class loads `hyperref` at `\begin{document}` with `hidelinks`, **unless you have loaded
it yourself** in the preamble (then your options are kept, e.g.
`\usepackage[colorlinks]{hyperref}`). Packages that must come after hyperref, such as
`cleveref`, can be loaded normally in the preamble. Do not change margins, font sizes or
spacing and do not modify the class file.

## Header and maintenance settings

For maintainers only (authors must not change them):

```latex
\croceeheader{line 1}{line 2}{line 3}   % the three lines of the header (edition, dates, copyright)
\croceelogo{Figures/4CroCEE_logo}       % logo file without extension (.png or .pdf)
\croceesetup{key=value, ...}            % spacing and size parameters, see below
```

Keys of `\croceesetup`: `linespacing`, `abstractspacing`, `captionspacing`, `tablespacing`,
`bibspacing`, `linepitch`, `ascent`, `descent`, `bodyfontsize`, `smallfontsize`,
`footnotefontsize`, `secfontsize`, `subsecfontsize`, `titlefontsize`, `parskip`, `parindent`,
`eqskip`, `secbefore`, `secafter`, `subsecbefore`, `subsecafter`, `tablecapskip`,
`figurecapskip`, `floatgap`, `floatsep`, `floattrim`, `bibitemsep`. Their defaults are
in Section 1 of `CroCEE.cls`.

## Editorial commands (used by the editors, leave commented out)

```latex
\paperdoi{10.5592/CO/4CroCEE.2027.001}   % 4th header line: DOI: https://doi.org/...
\firstpage{123}                           % first page number; numbers at the bottom right
```

Both are independent; the page-count check takes `\firstpage` into account.

## Length

- full paper: 6 to 12 pages, including abstract, figures, tables and references
- extended abstract: max. 2 pages, 500 to 1000 words, no abstract section
  (Engineering Seismology and PhD sessions only)
- language: English; single column

The class prints a warning at the end of the compilation if the paper is shorter than 6 or
longer than 12 pages (extended abstract: longer than 2). The limits are those given in the
example files; always check them against the current *Information for Authors* of the
conference.

## Before you submit (for authors)

- [ ] pdfLaTeX/XeLaTeX run without errors; no `[?]` in the text; no page-length warning
- [ ] example text, example figure, the `\setbibpreamble` block and the unused `.bib` entries removed
- [ ] abstract 250–300 words, 4–8 keywords, title at most two lines
- [ ] figures at least 300 dpi at the printed size (or vector PDF)
- [ ] `.tex`, `.bib`, figure files and the compiled PDF submitted together

## Notes on the implementation (for maintainers)

- Page: A4, margins top 3.25 cm, others 2.54 cm; header 1.25 cm from the top edge.
- Line spacing: every style of the Word template uses "Exactly" 1.2 × font size
  (11 pt → 13.2 pt, 10 pt → 12 pt, 9 pt → 10.8 pt, 13 pt → 15.6 pt, 14 pt → 16.8 pt).
  The class assumes that Word keeps the font descent (Palatino Linotype: 0.285 × size) at the
  bottom of the line box and takes the rest from the top, and models it with `\crocee@lh`,
  `\crocee@desc` and `\crocee@asc = lh − desc` (Section 1 of the class).
- All metric and spacing parameters are collected in Section 1 of `CroCEE.cls`; dependent
  quantities are recomputed by `\crocee@recalculate`.
- **Empirical values.** Two numbers are calibrated against a PDF exported from Word and are
  not derived from font metrics: the display-equation skip `eqskip` = 6 bp (the Word template
  says 8 pt before and after an equation; Word measures it between line boxes of exact height,
  TeX between the real boxes) and `floattrim` = 0.75 bp (fine correction of the space before a
  section that follows a float). Both are named parameters and are explained in the comments
  of the class; check them again with a new Word export if the template or the fonts change.
- The correction `\crocee@floatcomp` (0.285 bp) is not empirical: it is the change of the
  baseline distance when the font size changes from the 10 pt caption/table line to the
  11 pt body line, derived from the same line-box model.
- The paragraph indent (1 cm) follows the written instructions; the Word example text
  itself is not indented (`noparindent` reproduces it).

## Validation

- **Compilation.** The two examples compile without errors with pdfLaTeX and XeLaTeX (TeX
  Live 2023); the example `.bib` entries, Croatian letters in names, wide tables, footnotes,
  endnotes and a user-loaded `hyperref`/`cleveref` were tested.
- **Comparison with Word.** An earlier version of the class (Palatino with single spacing,
  factor 1.352) was compared line by line with a PDF exported from Word (baselines within
  0.3 pt, identical line breaks). The current version, with "exactly 1.2" line spacing, has
  **not yet been compared** with a new Word export; until then, differences of a fraction of
  a point in vertical positions cannot be excluded, and line breaks depend on the fonts (see
  [Requirements](#requirements-and-compiling)).

## Authors, credits, licence

Template by Marin Grubišić and Vedran Jagodnik (University of Rijeka, Faculty of Civil
Engineering), prepared with the assistance of Claude (Anthropic) and Gemini (Google).

- `Definitions/Elsevier.csl` is the unmodified CSL style "Elsevier (numeric, with titles)" by
  Richard Karnesky and Rintze Zelle, licensed under
  [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/).
- `Definitions/Elsevier.bst` is a BibTeX implementation of the same style, written for this
  template; as a derived work it is also distributed under CC BY-SA 3.0.

<!-- Licence of the template (CroCEE.cls, .tex files), and the origin/permission of the logo
     and of Figures/example_figure.png must be stated here before publication. -->
