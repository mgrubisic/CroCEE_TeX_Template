# 4CroCEE 2027 – LaTeX template for full papers and extended abstracts

LaTeX version of the official Word templates of the 4th Croatian Conference on
Earthquake Engineering (4CroCEE, 22–25 March 2027, Opatija, Croatia). The class
reproduces the Word layout line by line (same page geometry, Palatino Linotype 11 pt,
line spacing exactly 1.2 × font size, same spacing of headings, captions, equations and
references), so that papers written in Word and in LaTeX look the same in the
proceedings.

Template by Marin Grubišić and Vedran Jagodnik (University of Rijeka, Faculty of Civil
Engineering), prepared with the assistance of Claude (Anthropic). Questions and bug
reports: conference e-mail or the repository issue tracker.

## Files

```
4CroCEE_FullPaper.tex          full paper example – copy it and write your paper in it
4CroCEE_ExtendedAbstract.tex   extended abstract example (class option "extended")
Definitions/CroCEE.cls         document class – all formatting; do not edit
Definitions/Elsevier.bst       BibTeX style (Elsevier numeric, with titles)
Definitions/Elsevier.csl       the same style for Zotero / Mendeley (Word users)
Bibliography/References.bib    example BibTeX database with one entry of each type
Figures/4CroCEE_logo.png       header logo (used by the class)
Figures/example_figure.png     example figure – delete in your paper
README.md                      this file
```

Keep the folder structure: the class, the BibTeX style and the logo are loaded from
`Definitions/` and `Figures/`.

## Compiling

Unpack the folder (or upload the whole zip to Overleaf: *New Project → Upload Project*)
and run

```
pdflatex 4CroCEE_FullPaper
bibtex   4CroCEE_FullPaper
pdflatex 4CroCEE_FullPaper
pdflatex 4CroCEE_FullPaper
```

Overleaf does this automatically. XeLaTeX and LuaLaTeX also work (they use the
system font Palatino Linotype, or TeX Gyre Pagella where it is not installed). Required
packages are part of every standard TeX Live / MiKTeX / Overleaf installation:
`newpx` (or `mathpazo`), `geometry`, `titlesec`, `caption`,
`booktabs`, `tabularx`, `changepage`, `cite`, `enumitem`, `xcolor`, `bm`, `url`,
`hyperref`, `lmodern`.

Submit the complete source (`.tex`, `.bib`, figures) together with the compiled PDF.

## Class options

```latex
\documentclass{Definitions/CroCEE}              % full paper, 6–12 pages, with abstract
\documentclass[extended]{Definitions/CroCEE}    % extended abstract, max. 2 pages, no abstract section
```

Further options: `noparindent` (no 1 cm indentation of paragraphs), `hyphenation`
(allow hyphenation; Word does not hyphenate), `nourlunderline` (URLs not underlined).

The class warns at the end of the compilation if the paper is shorter than 6 or longer
than 12 pages (extended abstract: longer than 2).

## Title, authors, affiliations

```latex
\title{Title of the paper}          % printed in uppercase, max. two lines

\author[1]{First Author}            % number = affiliation mark
\author[1,2]{Second Author}
\author{Third Author}               % without mark

\affiliation[1]{Position, affiliation, e-mail address}
\affiliation[2]{Position, affiliation, e-mail address}

\begin{document}
\maketitle
```

## Abstract and keywords

```latex
\begin{abstract}          % full paper only; omit with the option extended
250 to 300 words, no references or equations.
\end{abstract}

\keywords{keyword1, keyword2, keyword3, keyword4}   % 4–8 keywords
```

In the extended abstract `\keywords` follows `\maketitle` directly.

## Sections

```latex
\section{Introduction}          % 1.     13 pt bold
\subsection{Title}              % 1.1.   11 pt bold
\subsubsection{Title}           % 1.1.1. 11 pt bold (at most three levels)

\section*{Acknowledgements}     % unnumbered
\section*{Copyrights}
```

Pages are not numbered; page numbers are added by the editors. The header with the
logo is added automatically.

## Tables

Caption above the table, centred, 10 pt. Tables span the full text width, use the
`booktabs` rules and have no vertical lines or shading:

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

In the text: `\tabref{tab:modes}` → "Table 1". A very wide table may protrude into the
margins: `\setlength{\extralength}{1cm}` before the table.

## Figures

Caption below the figure, centred, 10 pt. Minimum resolution 300 dpi; PDF for
diagrams and plots.

```latex
\begin{figure}
  \centering
  \includegraphics[width=\textwidth]{Figures/figure}
  \caption{a) Building plan; b) Numerical model.}
  \label{fig:model}
\end{figure}
```

In the text: `\figref{fig:model}` → "Fig. 1".

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

The 8 pt of space above and below equations is set by the class.

## References

Citation style: **Elsevier (numeric, with titles)** – an existing style of the CSL
repository (`http://www.zotero.org/styles/elsevier-with-titles`), available under that
name in Zotero and Mendeley. The same records in Zotero/Mendeley and in the `.bib`
file give identical reference lists in Word and in LaTeX.

- in the text: `\cite{DAyala2003,Bommer2010}` → [1,2]; `\cite{a,b,c,d}` → [1–4]
- in the list: [1], [2] … in order of first citation, 10 pt, hanging indent 0.63 cm
- names as *Initials Surname* (J.J. Bommer), all authors listed
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
| Personal communication | D. Lazarevic, Personal correspondence, (2019). |

The style does not print report numbers separately ("PEER 2014/05"); write them at
the end of the title, as in `Bibliography/References.bib`.

```latex
\bibliographystyle{Definitions/Elsevier} 
\bibliography{Bibliography/References}
```

The heading "References" is added automatically. `\setbibpreamble{...}` (text between
the heading and the list) is used in the examples only to explain the style – delete
it in your paper.

Entry types in `.bib`: `@article`, `@book`, `@inproceedings`, `@incollection`,
`@techreport`, `@phdthesis`, `@mastersthesis`, `@online` (fields `url`,
`urldate = {YYYY-MM-DD}`), `@misc`. Write titles as they should appear; protect
proper names and acronyms with braces (`{Eurocode}`, `{URM}`). Give the edition as a
number: `edition = {5}`.

### Word users (Zotero / Mendeley)

- **Zotero**: Word add-in → *Document Preferences* → choose "Elsevier (numeric, with
  titles)". If it is not listed: *Settings → Cite → Get additional styles…*, or add
  `Elsevier.csl` with the **+** button.
- **Mendeley Cite**: *Citation Style* → search "Elsevier (numeric, with titles)".

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

## Notes on the implementation (for maintainers)

- Page: A4, margins top 3.25 cm, others 2.54 cm; header 1.25 cm from the top edge.
- Line spacing: every style of the Word template uses "Exactly" 1.2 × font size
  (11 pt → 13.2 pt, 10 pt → 12 pt, 9 pt → 10.8 pt, 13 pt → 15.6 pt, 14 pt → 16.8 pt).
  Word keeps the font descent (Palatino Linotype: 0.285 × size) at the bottom of the
  line box and takes the rest from the top; the class uses the same model
  (`\crocee@lh`, `\crocee@desc`, `\crocee@asc = lh - desc` in Section 1 of the class).
- All metric and spacing parameters are collected in Section 1 of `CroCEE.cls` and can
  be overridden in a document preamble with `\croceesetup{key=value}` (for maintenance
  only – authors must not change them).
- Word's "8 pt above and below equations" corresponds to a TeX display skip of 6 bp.
- The paragraph indent (1 cm) follows the written instructions; the Word example
  text itself is not indented (`noparindent` reproduces it).
- Validation: a LaTeX document with the verbatim text of the Word template is compared
  line by line with the PDF exported from Word (baselines within 0.3 pt, identical line
  breaks). The version with Palatino single spacing (1.352) was validated this way; the
  exact-1.2 version is to be re-checked with a new Word export.
