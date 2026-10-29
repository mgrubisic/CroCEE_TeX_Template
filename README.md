# CroCEE – LaTeX template / LaTeX predložak

🇬🇧 **[English](#-english)** · 🇭🇷 **[Hrvatski](#-hrvatski)**

---

## 🇬🇧 English

LaTeX template for the Croatian Conference on Earthquake Engineering (CroCEE,
<https://crocee.grad.hr/>). The template is conference-independent: the edition, dates,
place and logo are set in one configuration file (see
[Configuring a new edition](#configuring-a-new-edition-editors)); the current
configuration is 4CroCEE 2027 (22–25 March 2027, Opatija, Croatia). The class
`CroCEE.cls` follows the page geometry and typography of the conference's Word templates
(A4, Palatino 11 pt, line spacing exactly 1.26 × font size, the same spacing of headings,
captions, equations and references), so that papers written in Word and in LaTeX look
alike in the proceedings. See [Validation](#validation) for what has been compared with
Word and what has not.

Questions and bug reports: the conference secretariat (crocee@grad.hr) or the issue
tracker of this repository.

### Files

```
CroCEE_FullPaper.tex           full paper example – copy it and write your paper in it
CroCEE_ExtendedAbstract.tex    extended abstract example (class option "extended")
Definitions/CroCEE.cls         document class – all formatting; do not edit
Definitions/conference.cfg     conference data: edition, dates, place, logo (editors only)
Definitions/packages.tex       additional packages (tikz, pgfplots, ...), loaded by the class
Definitions/Elsevier.bst       BibTeX style (Elsevier numeric, with titles)
Definitions/Elsevier.csl       the same style for Zotero / Mendeley (Word users)
Bibliography/References.bib    example BibTeX database, one entry of each type
Figures/4CroCEE_logo.png       header logo (named in conference.cfg)
Figures/example_figure.png     example figure (low-resolution placeholder) – delete in your paper
README.md                      this file (English and Croatian)
```

Keep the folder structure: the class is loaded from the folder of the `.tex` file, the BibTeX
style from `Definitions/` and the logo from `Figures/`.

### Requirements and compiling

- **LaTeX kernel 2021-06-01 or newer** (TeX Live 2021+, MiKTeX 21.6+, current Overleaf).
  The class uses the kernel hooks; `\fpeval` comes from the kernel (2022-06+) or from the
  `xfp` package on older installations. Older installations are not supported.
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
  `tabularx`, `changepage`, `endnotes`, `cite`, `url`, `hyperref`, `xfp`; plus `tikz` and
  `pgfplots` from `Definitions/packages.tex`.

Unpack the folder (or upload the zip to Overleaf: *New Project → Upload Project*) and run

```
pdflatex CroCEE_FullPaper
bibtex   CroCEE_FullPaper
pdflatex CroCEE_FullPaper
pdflatex CroCEE_FullPaper
```

Overleaf does this automatically. Source files are UTF-8; Croatian letters can be typed
directly in the text, in author names and in the `.bib` file.

Submit the complete source (`.tex`, `.bib`, figures) together with the compiled PDF.

**Note:** the example `CroCEE_FullPaper.tex` is shorter than 6 pages, so its compilation
prints `The paper has 5 pages; the minimum is 6`. This is the page-length check of the class
(see [Length](#length)); it disappears when your paper has the required length.

### Class options

```latex
\documentclass{Definitions/CroCEE}           % full paper, 6–12 pages, with abstract
\documentclass[extended]{Definitions/CroCEE} % extended abstract, max. 2 pages, no abstract section
```

Further options: `noparindent` (no 1 cm indentation of paragraphs), `hyphenation` (allow
hyphenation; Word does not hyphenate), `nourlunderline` (URLs not underlined), `draft` and
`final` (passed to the `article` class). An unknown option is ignored with a warning.

### Title, authors, affiliations

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

### Abstract and keywords

```latex
\begin{abstract}          % full paper only; omit with the option extended
250 to 300 words, no references or equations.
\end{abstract}

\keywords{keyword1, keyword2, keyword3, keyword4}   % 4–8 keywords
```

In the extended abstract `\keywords` follows `\maketitle` directly.

### Sections, lists, footnotes, endnotes

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

### Tables

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

### Figures

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

### Equations

```latex
\begin{equation}
  \matr{K}\,\vect{u} = \vect{f}
  \label{eq:static}
\end{equation}
```

- `\vect{u}` vector, `\matr{K}` matrix (both bold); scalars italic (default)
- in the text: `\Eqref{eq:static}` → "Eq. (1)"
- units upright, separated by a thin space: `10\,kN`

### References

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

#### Word users (Zotero / Mendeley)

- **Zotero**: Word add-in → *Document Preferences* → choose "Elsevier (numeric, with
  titles)". If it is not listed: *Settings → Cite → Get additional styles…*, or add
  `Elsevier.csl` with the **+** button.
- **Mendeley Cite**: *Citation Style* → search "Elsevier (numeric, with titles)".

### Hyperref, other packages

The class loads `hyperref` at `\begin{document}`: URLs (including the DOI line of the
header) are printed in Word's hyperlink blue, internal links and citations stay black, no
frames – **unless you have loaded hyperref yourself** in the preamble (then your options are
kept). Packages that must come after hyperref, such as `cleveref`, can be loaded normally in
the preamble.

`Definitions/packages.tex` is read automatically by the class, before `hyperref`. It loads
`tikz` and `pgfplots`; add further `\usepackage` lines there if your paper needs them. Do not
load packages that change the fonts, the page layout or the spacing (`geometry`, `setspace`,
font packages, ...), do not change margins, font sizes or spacing, and do not modify the
class file.

### Conference name and year in the text

The class provides text macros filled from `Definitions/conference.cfg`, so the example
texts never have to be edited for a new edition:

| Macro | Output (current configuration) |
|---|---|
| `\ConfShort` | 4CroCEE |
| `\ConfYear` | 2027 |
| `\ConfEdition` | 4th |
| `\ConfName` | Croatian Conference on Earthquake Engineering |
| `\ConfFullName` | 4th Croatian Conference on Earthquake Engineering |
| `\ConfDates`, `\ConfPlace` | 22–25 March 2027, Opatija, Croatia |

Write `\ConfYear{}` (with empty braces) when a word follows, otherwise the space is lost.

### Configuring a new edition (editors)

Only two things change from one conference to the next:

1. `Definitions/conference.cfg` – edition number and ordinal suffix, dates, place, year,
   copyright holder, short name and logo file name:
   ```latex
   \croceeconference{
     edition = 5, ordinal = th, short = 5CroCEE,
     dates = {10--12 April 2029}, place = {Zagreb, Croatia}, year = 2029,
     name = {Croatian Conference on Earthquake Engineering},
     acronym = CroCEE, copyright = CroCEE, logo = Figures/5CroCEE_logo }
   ```
2. The logo in `Figures/` (PNG or PDF, printed at 2.4 × 1.5 cm).

The header, the PDF metadata and the example texts follow automatically.

### Header and maintenance settings

For maintainers only (authors must not change them):

```latex
\croceeconference{key=value, ...}       % conference data, normally in Definitions/conference.cfg
\croceeheader{line 1}{line 2}{line 3}   % the three header lines written out in full (overrides the cfg)
\croceelogo{Figures/4CroCEE_logo}       % logo file without extension (.png or .pdf)
\croceesetup{key=value, ...}            % spacing and size parameters, see below
```

Keys of `\croceesetup`: `linespacing`, `abstractspacing`, `captionspacing`, `tablespacing`,
`bibspacing`, `linepitch`, `ascent`, `descent`, `bodyfontsize`, `smallfontsize`,
`footnotefontsize`, `secfontsize`, `subsecfontsize`, `titlefontsize`, `parskip`, `parindent`,
`eqskip`, `secbefore`, `secafter`, `subsecbefore`, `subsecafter`, `tablecapskip`,
`figurecapskip`, `floatgap`, `floatsep`, `floattrim`, `bibitemsep`. Their defaults are
in Section 1 of `CroCEE.cls`.

### Editorial commands (used by the editors, leave commented out)

```latex
\paperdoi{10.5592/CO/4CroCEE.2027.001}   % 4th header line: DOI: https://doi.org/...
\firstpage{123}                           % first page number; numbers at the bottom right
```

Both are independent; the page-count check takes `\firstpage` into account.

### Length

- full paper: 6 to 12 pages, including abstract, figures, tables and references
- extended abstract: max. 2 pages, 500 to 1000 words, no abstract section
  (Engineering Seismology and PhD sessions only)
- language: English; single column

The class prints a warning at the end of the compilation if the paper is shorter than 6 or
longer than 12 pages (extended abstract: longer than 2). The limits are those given in the
example files; always check them against the current *Information for Authors* of the
conference.

### Before you submit (for authors)

- [ ] pdfLaTeX/XeLaTeX run without errors; no `[?]` in the text; no page-length warning
- [ ] example text, example figure, the `\setbibpreamble` block and the unused `.bib` entries removed
- [ ] abstract 250–300 words, 4–8 keywords, title at most two lines
- [ ] figures at least 300 dpi at the printed size (or vector PDF)
- [ ] `.tex`, `.bib`, figure files and the compiled PDF submitted together

### Notes on the implementation (for maintainers)

- Page: A4, margins top 3.25 cm, others 2.54 cm; header 1.25 cm from the top edge.
- Line spacing: every style of the Word template uses "Exactly" 1.26 × font size
  (11 pt → 13.86 pt, 10 pt → 12.6 pt, 9 pt → 11.34 pt, 13 pt → 16.38 pt, 14 pt → 17.64 pt).
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

### Validation

- **Compilation.** The two examples compile without errors with pdfLaTeX and XeLaTeX (TeX
  Live 2023); the example `.bib` entries, Croatian letters in names, wide tables, footnotes,
  endnotes and a user-loaded `hyperref`/`cleveref` were tested.
- **Comparison with Word.** An earlier version of the class (Palatino with single spacing,
  factor 1.352) was compared line by line with a PDF exported from Word (baselines within
  0.3 pt, identical line breaks). The current version, with "exactly 1.26" line spacing, has
  **not yet been compared** with a new Word export; until then, differences of a fraction of
  a point in vertical positions cannot be excluded, and line breaks depend on the fonts (see
  [Requirements](#requirements-and-compiling)).

### Authors, credits, licence

Template by Marin Grubišić and Vedran Jagodnik (University of Rijeka, Faculty of Civil
Engineering), prepared with the assistance of Claude (Anthropic) and Gemini (Google).

- `Definitions/Elsevier.csl` is the unmodified CSL style "Elsevier (numeric, with titles)" by
  Richard Karnesky and Rintze Zelle, licensed under
  [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/).
- `Definitions/Elsevier.bst` is a BibTeX implementation of the same style, written for this
  template; as a derived work it is also distributed under CC BY-SA 3.0.

<!-- Licence of the template (CroCEE.cls, .tex files), and the origin/permission of the logo
     and of Figures/example_figure.png must be stated here before publication. -->

[↑ English](#-english) · [🇭🇷 Hrvatski](#-hrvatski)

---

## 🇭🇷 Hrvatski

LaTeX predložak za Hrvatsku konferenciju o potresnom inženjerstvu (Croatian Conference on
Earthquake Engineering, CroCEE, <https://crocee.grad.hr/>). Predložak ne ovisi o izdanju
konferencije: redni broj, datumi, mjesto i logo zadaju se u jednoj konfiguracijskoj
datoteci (vidi [Podešavanje za novo izdanje](#podešavanje-za-novo-izdanje-uredništvo));
trenutačno je podešen za 4CroCEE 2027 (22.–25. ožujka 2027., Opatija). Klasa
`CroCEE.cls` slijedi geometriju stranice i tipografiju Word predložaka konferencije (A4,
Palatino 11 pt, prored točno 1.26 × veličina fonta, isti razmaci naslova, naslova slika i
tablica, jednadžbi i literature), pa radovi pisani u Wordu i u LaTeX-u u zborniku izgledaju
jednako. Što je uspoređeno s Wordom, a što nije, piše u odjeljku [Provjera](#provjera).

Pitanja i prijave grešaka: tajništvo konferencije (crocee@grad.hr) ili *Issues* na ovom
repozitoriju.

### Datoteke

```
CroCEE_FullPaper.tex           primjer cjelovitog rada – kopirati i u njemu pisati rad
CroCEE_ExtendedAbstract.tex    primjer proširenog sažetka (opcija klase "extended")
Definitions/CroCEE.cls         klasa dokumenta – cjelokupno formatiranje; ne mijenjati
Definitions/conference.cfg     podaci o konferenciji: izdanje, datumi, mjesto, logo (uredništvo)
Definitions/packages.tex       dodatni paketi (tikz, pgfplots, ...), učitava ih klasa
Definitions/Elsevier.bst       BibTeX stil literature (Elsevier numeric, with titles)
Definitions/Elsevier.csl       isti stil za Zotero / Mendeley (korisnici Worda)
Bibliography/References.bib    primjer BibTeX baze, po jedan zapis svake vrste
Figures/4CroCEE_logo.png       logo u zaglavlju (naveden u conference.cfg)
Figures/example_figure.png     primjer slike (niska rezolucija, samo primjer) – obrisati u radu
README.md                      ova datoteka (engleski i hrvatski)
```

Strukturu mapa treba zadržati: klasa se učitava iz mape u kojoj je `.tex` datoteka, BibTeX
stil iz `Definitions/`, a logo iz `Figures/`.

### Zahtjevi i prevođenje

- **LaTeX kernel 2021-06-01 ili noviji** (TeX Live 2021+, MiKTeX 21.6+, aktualni Overleaf).
  Klasa koristi kernelske *hookove*; `\fpeval` dolazi iz kernela (2022-06+) ili iz paketa
  `xfp` na starijim instalacijama. Starije instalacije nisu podržane.
- **Prevoditelji.** pdfLaTeX i XeLaTeX su testirani (TeX Live 2023). LuaLaTeX nije testiran;
  klasa za njega koristi istu `fontspec` granu kao za XeLaTeX.
- **Fontovi.** Word predložak koristi Palatino Linotype.
  - pdfLaTeX: `newpx` ako je instaliran, inače `mathpazo` (URW Palladio). To su fontovi u
    stilu Palatina, **ne** Palatino Linotype, pa se prijelomi redaka i stranica mogu
    neznatno razlikovati od Worda.
  - XeLaTeX / LuaLaTeX: Palatino Linotype ako je instaliran, inače TeX Gyre Pagella (klasa
    ispisuje upozorenje). Jesu li širine znakova jednake Palatino Linotypeu nije provjereno.
- **Paketi** (svi u standardnom TeX Live / MiKTeX / Overleafu): `amsmath`, `iftex`,
  `fontenc` (T1), `newpx` ili `mathpazo` (+ `fontspec` za XeLaTeX/LuaLaTeX), `bm`,
  `geometry`, `enumitem`, `graphicx`, `titlesec`, `caption`, `array`, `xcolor`, `booktabs`,
  `tabularx`, `changepage`, `endnotes`, `cite`, `url`, `hyperref`, `xfp`; te `tikz` i
  `pgfplots` iz `Definitions/packages.tex`.

Raspakirati mapu (ili zip učitati na Overleaf: *New Project → Upload Project*) i pokrenuti

```
pdflatex CroCEE_FullPaper
bibtex   CroCEE_FullPaper
pdflatex CroCEE_FullPaper
pdflatex CroCEE_FullPaper
```

Overleaf to radi automatski. Izvorne datoteke su UTF-8; hrvatska slova mogu se pisati
izravno u tekstu, u imenima autora i u `.bib` datoteci.

Predaje se cijeli izvor (`.tex`, `.bib`, slike) zajedno s prevedenim PDF-om.

**Napomena:** primjer `CroCEE_FullPaper.tex` kraći je od 6 stranica, pa prevođenje ispisuje
`The paper has 5 pages; the minimum is 6`. To je provjera opsega iz klase (vidi
[Opseg](#opseg)); nestaje kad rad ima traženi broj stranica.

### Opcije klase

```latex
\documentclass{Definitions/CroCEE}           % cjeloviti rad, 6–12 stranica, sa sažetkom
\documentclass[extended]{Definitions/CroCEE} % prošireni sažetak, max. 2 stranice, bez sažetka
```

Dodatne opcije: `noparindent` (bez uvlake odlomaka od 1 cm), `hyphenation` (dopusti
rastavljanje riječi; Word ga nema), `nourlunderline` (URL-ovi bez podcrtavanja), `draft` i
`final` (prosljeđuju se klasi `article`). Nepoznata opcija zanemaruje se uz upozorenje.

### Naslov, autori, afilijacije

```latex
\title{Naslov rada}                 % automatski velikim slovima, max. dva retka

\author[1]{Ime Prezime}             % broj = oznaka afilijacije
\author[1,2]{Ime Prezime}
\author{Ime Prezime}                % bez oznake

\affiliation[1]{Pozicija, institucija, e-mail}
\affiliation[2]{Pozicija, institucija, e-mail}

\begin{document}
\maketitle
```

- Naslov klasa pretvara u velika slova (`\MakeUppercase`; hrvatska slova su obuhvaćena,
  matematika ostaje nepromijenjena). Tekst koji mora zadržati mala slova zaštititi s
  `\NoCaseChange{...}`, npr. `10 \NoCaseChange{kN}`.
- PDF metapodaci (naslov u izvornom obliku, imena autora, predmet, jezik) pune se iz
  `\title` i `\author`. Ako naslov sadrži naredbe ili matematiku, hyperref može upozoriti na
  „tokens not allowed in a PDF string"; tada PDF naslov zadati ručno s
  `\hypersetup{pdftitle={...}}` iza `\begin{document}`.

### Sažetak i ključne riječi

```latex
\begin{abstract}          % samo cjeloviti rad; uz opciju extended izostaviti
250 do 300 riječi, bez referenci i jednadžbi.
\end{abstract}

\keywords{riječ1, riječ2, riječ3, riječ4}   % 4–8 ključnih riječi
```

U proširenom sažetku `\keywords` dolazi odmah iza `\maketitle`.

### Poglavlja, popisi, fusnote, endnote

```latex
\section{Introduction}          % 1.     13 pt bold
\subsection{Naslov}             % 1.1.   11 pt bold
\subsubsection{Naslov}          % 1.1.1. 11 pt bold (najviše tri razine)
\paragraph{Naslov} Tekst ...    % nenumerirani podebljani naslov u retku, 11 pt

\section*{Acknowledgements}     % nenumerirano
\section*{Copyrights}
```

- `\paragraph` **nije** dio Word predloška; klasa ga oblikuje dosljedno, ali koristiti ga
  štedljivo.
- `itemize` i `enumerate` uvučeni su 1.27 cm s oznakom na 0.635 cm.
- `\footnote{...}` daje fusnote u 9 pt na dnu stranice. Word predložak ne definira fusnote,
  pa je taj stil izbor klase.
- `\endnote{...}` označava endnotu (numerirane i, ii, …); `\printendnotes` ispisuje popis pod
  naslovom „Notes". Staviti ga prije literature.

Stranice se ne numeriraju; brojeve stranica dodaje uredništvo. Zaglavlje s logom dodaje se
automatski.

### Tablice

Naslov iznad tablice, centrirano, 10 pt. Tablice su preko cijele širine teksta, s `booktabs`
linijama, bez okomitih linija i sjenčanja:

```latex
\begin{table}
  \begin{adjustwidth}{-\extralength}{0cm}
  \caption{Dynamic properties of model.}
  \label{tab:modes}
  \begin{tabularx}{\fulllength}{cCCCC}      % C = rastezljivi centrirani stupac
    \toprule
    \textbf{Mode} & \textbf{T (s)} & \textbf{Mx} & \textbf{My} & \textbf{MRz} \\
    \midrule
    1 & 0.116 & 0 & 0.833 & 0 \\
    \bottomrule
  \end{tabularx}
  \tablenotes{\textbf{Notes:} objašnjenja simbola (9 pt).}   % opcionalno
  \end{adjustwidth}
\end{table}
```

U tekstu: `\tabref{tab:modes}` → „Table 1".

Vrlo široka tablica može ući u **lijevu** marginu: staviti `\setlength{\extralength}{1cm}`
prije tablice i `\setlength{\extralength}{0cm}` iza nje. `\fulllength` (širina tablice) tada
je širina teksta plus `\extralength`, a okolina `adjustwidth` pomiče tablicu ulijevo za isti
iznos, pa desni rub ostaje na desnoj margini.

### Slike

Naslov ispod slike, centrirano, 10 pt. Rezolucija najmanje 300 dpi **u tiskanoj veličini**;
za dijagrame PDF.

```latex
\begin{figure}
  \centering
  \includegraphics[width=\textwidth]{Figures/slika}
  \caption{a) Building plan; b) Numerical model.}
  \label{fig:model}
\end{figure}
```

U tekstu: `\figref{fig:model}` → „Fig. 1". Primjer slike je zamjenska slika od 1024 px; na
8.5 cm, koliko je u primjerima, ima oko 300 dpi. Zamijeniti je vlastitom slikom.

### Jednadžbe

```latex
\begin{equation}
  \matr{K}\,\vect{u} = \vect{f}
  \label{eq:static}
\end{equation}
```

- `\vect{u}` vektor, `\matr{K}` matrica (oboje podebljano); skalari kurzivom (zadano)
- u tekstu: `\Eqref{eq:static}` → „Eq. (1)"
- jedinice uspravno, odvojene tankim razmakom: `10\,kN`

### Literatura

Stil citiranja: **Elsevier (numeric, with titles)** – postojeći stil iz CSL repozitorija
(<http://www.zotero.org/styles/elsevier-with-titles>), pod tim imenom dostupan u Zoteru i
Mendeleyu. `Definitions/Elsevier.bst` provodi ista pravila oblikovanja za BibTeX, pa radovi
pisani u Wordu i u LaTeX-u koriste isti stil literature. Provjeren je na vrstama zapisa iz
`Bibliography/References.bib`; identičan ispis kao u Zoteru/Mendeleyu nije zajamčen za svaki
mogući zapis.

- u tekstu: `\cite{DAyala2003,Bommer2010}` → [1,2]; `\cite{a,b,c,d}` → [1–4]
- u popisu: [1], [2] … redom prvog citiranja, 10 pt, viseća uvlaka 0.63 cm
- imena kao *Inicijali Prezime* (J.J. Bommer), navode se svi autori; `and others` → „et al."
- inicijali podržavaju UTF-8: Šime, Đuro, Čedo, Ćiro, Željka daju Š., Đ., Č., Ć., Ž.
- bez kurziva i podebljanja; godina pri kraju; točka na kraju

| Vrsta | Primjer |
|---|---|
| Članak u časopisu | D. D'Ayala, E. Speranza, Definition of collapse mechanisms ..., Earthquake Spectra 19 (2003) 479–509. https://doi.org/10.1193/1.1599896. |
| Poglavlje / zbornik | B. Brown, M. Aaron, Title, in: J. Smith (Ed.), Book Title, 3rd ed., Wiley, New York, 2001: pp. 230–257. |
| Zbornik bez urednika | G. Magenes, A. Penna, Title, in: 9th Australasian Masonry Conference (9AMC), Queenstown, New Zealand, 2011. |
| Knjiga | A.K. Chopra, Dynamics of Structures, 5th ed., Pearson Education, USA, 2019. |
| Izvještaj | POLIMI, Title, Deliverable 3.3, NIKER Project, Italy, 2010. |
| Disertacija | J.W. Trent, Title, PhD thesis, University of California, 1975. |
| Web izvor | K. Beyer, B. Wilding, A. Rezaie, Title, (2019). https://zenodo.org/record/2536830 (accessed November 29, 2020). |
| Osobna komunikacija | P. Horvat, Personal correspondence, (2019). |

Stil ne ispisuje zasebno broj izvještaja („PEER 2014/05"); upisuje se na kraj naslova, kao u
`Bibliography/References.bib`.

```latex
\bibliographystyle{Definitions/Elsevier}
\bibliography{Bibliography/References}
```

Ako se `\bibliographystyle` izostavi, klasa koristi `Definitions/Elsevier.bst`. Naslov
„References" dodaje se automatski. `\setbibpreamble{...}` (tekst između naslova i popisa) u
primjerima služi samo za objašnjenje stila – u radu ga obrisati.

Tipovi zapisa u `.bib`: `@article`, `@book`, `@inproceedings`, `@incollection`,
`@techreport`, `@phdthesis`, `@mastersthesis`, `@online` (polja `url`,
`urldate = {YYYY-MM-DD}`), `@misc`; za svaki postoji primjer u `References.bib`. Naslove
pisati onako kako trebaju izgledati; vlastita imena i kratice zaštititi vitičastim zagradama
(`{Eurocode}`, `{URM}`). Izdanje zadati brojem: `edition = {5}`.

#### Korisnici Worda (Zotero / Mendeley)

- **Zotero**: Word dodatak → *Document Preferences* → odabrati „Elsevier (numeric, with
  titles)". Ako ga nema na popisu: *Settings → Cite → Get additional styles…*, ili dodati
  `Elsevier.csl` gumbom **+**.
- **Mendeley Cite**: *Citation Style* → potražiti „Elsevier (numeric, with titles)".

### Hyperref, ostali paketi

Klasa učitava `hyperref` na `\begin{document}`: URL-ovi (uključujući DOI redak u zaglavlju)
ispisuju se Wordovom plavom bojom poveznica, unutarnje poveznice i citati ostaju crni, bez
okvira – **osim ako ste hyperref sami učitali** u preambuli (tada vrijede vaše opcije).
Paketi koji moraju doći iza hyperrefa, npr. `cleveref`, učitavaju se normalno u preambuli.

`Definitions/packages.tex` klasa čita automatski, prije `hyperref`-a. Učitava `tikz` i
`pgfplots`; ako rad treba još paketa, dodati ih tamo naredbom `\usepackage`. Ne učitavati
pakete koji mijenjaju fontove, prijelom stranice ili razmake (`geometry`, `setspace`, paketi
fontova ...), ne mijenjati margine, veličine fontova ni razmake i ne mijenjati klasu.

### Naziv i godina konferencije u tekstu

Klasa nudi tekstualne naredbe koje se pune iz `Definitions/conference.cfg`, pa se primjeri
teksta za novo izdanje ne moraju mijenjati:

| Naredba | Ispis (trenutačna konfiguracija) |
|---|---|
| `\ConfShort` | 4CroCEE |
| `\ConfYear` | 2027 |
| `\ConfEdition` | 4th |
| `\ConfName` | Croatian Conference on Earthquake Engineering |
| `\ConfFullName` | 4th Croatian Conference on Earthquake Engineering |
| `\ConfDates`, `\ConfPlace` | 22–25 March 2027, Opatija, Croatia |

Kad iza naredbe slijedi riječ, pisati `\ConfYear{}` (s praznim zagradama), inače se gubi
razmak.

### Podešavanje za novo izdanje (uredništvo)

Od jedne do druge konferencije mijenjaju se samo dvije stvari:

1. `Definitions/conference.cfg` – redni broj i njegov sufiks, datumi, mjesto, godina,
   nositelj autorskih prava, kratki naziv i ime datoteke s logom:
   ```latex
   \croceeconference{
     edition = 5, ordinal = th, short = 5CroCEE,
     dates = {10--12 April 2029}, place = {Zagreb, Croatia}, year = 2029,
     name = {Croatian Conference on Earthquake Engineering},
     acronym = CroCEE, copyright = CroCEE, logo = Figures/5CroCEE_logo }
   ```
2. Logo u `Figures/` (PNG ili PDF, ispisuje se na 2.4 × 1.5 cm).

Zaglavlje, PDF metapodaci i primjeri teksta slijede automatski.

### Zaglavlje i postavke za održavanje

Samo za održavatelje (autori ih ne mijenjaju):

```latex
\croceeconference{ključ=vrijednost, ...}  % podaci o konferenciji, obično u Definitions/conference.cfg
\croceeheader{redak 1}{redak 2}{redak 3}  % tri retka zaglavlja izravno (ima prednost pred cfg)
\croceelogo{Figures/4CroCEE_logo}         % datoteka loga bez nastavka (.png ili .pdf)
\croceesetup{ključ=vrijednost, ...}       % parametri razmaka i veličina, vidi dolje
```

Ključevi za `\croceesetup`: `linespacing`, `abstractspacing`, `captionspacing`,
`tablespacing`, `bibspacing`, `linepitch`, `ascent`, `descent`, `bodyfontsize`,
`smallfontsize`, `footnotefontsize`, `secfontsize`, `subsecfontsize`, `titlefontsize`,
`parskip`, `parindent`, `eqskip`, `secbefore`, `secafter`, `subsecbefore`, `subsecafter`,
`tablecapskip`, `figurecapskip`, `floatgap`, `floatsep`, `floattrim`, `bibitemsep`. Zadane
vrijednosti su u 1. odjeljku datoteke `CroCEE.cls`.

### Uredničke naredbe (koristi uredništvo, autori ih ostavljaju zakomentirane)

```latex
\paperdoi{10.5592/CO/4CroCEE.2027.001}   % 4. redak zaglavlja: DOI: https://doi.org/...
\firstpage{123}                           % broj prve stranice; brojevi dolje desno
```

Obje su neovisne; provjera broja stranica uzima `\firstpage` u obzir.

### Opseg

- cjeloviti rad: 6 do 12 stranica, uključujući sažetak, slike, tablice i literaturu
- prošireni sažetak: najviše 2 stranice, 500 do 1000 riječi, bez sažetka
  (samo sesije Engineering Seismology i PhD)
- jezik: engleski; jedan stupac

Klasa na kraju prevođenja ispisuje upozorenje ako rad ima manje od 6 ili više od 12 stranica
(prošireni sažetak: više od 2). Ograničenja su ona iz primjera; uvijek ih provjeriti prema
aktualnim uputama za autore na stranici konferencije.

### Prije predaje (za autore)

- [ ] pdfLaTeX/XeLaTeX prolaze bez grešaka; u tekstu nema `[?]`; nema upozorenja o opsegu
- [ ] uklonjeni primjer teksta, primjer slike, blok `\setbibpreamble` i nekorišteni `.bib` zapisi
- [ ] sažetak 250–300 riječi, 4–8 ključnih riječi, naslov najviše dva retka
- [ ] slike najmanje 300 dpi u tiskanoj veličini (ili vektorski PDF)
- [ ] predani `.tex`, `.bib`, slike i prevedeni PDF zajedno

### Napomene o izvedbi (za održavatelje)

- Stranica: A4, margine gore 3.25 cm, ostale 2.54 cm; zaglavlje 1.25 cm od gornjeg ruba.
- Prored: svaki stil Word predloška koristi „Exactly" 1.26 × veličina fonta
  (11 pt → 13.86 pt, 10 pt → 12.6 pt, 9 pt → 11.34 pt, 13 pt → 16.38 pt, 14 pt → 17.64 pt).
  Klasa pretpostavlja da Word zadržava descent fonta (Palatino Linotype: 0.285 × veličina) na
  dnu retka, a ostatak oduzima odozgo, i to modelira s `\crocee@lh`, `\crocee@desc` i
  `\crocee@asc = lh − desc` (1. odjeljak klase).
- Svi metrički parametri i razmaci skupljeni su u 1. odjeljku `CroCEE.cls`; ovisne veličine
  ponovno računa `\crocee@recalculate`.
- **Empirijske vrijednosti.** Dva broja kalibrirana su prema PDF-u izvezenom iz Worda i nisu
  izvedena iz metrika fonta: razmak oko jednadžbi `eqskip` = 6 bp (Word predložak kaže 8 pt
  prije i poslije jednadžbe; Word to mjeri između redaka točne visine, TeX između stvarnih
  okvira) i `floattrim` = 0.75 bp (fina korekcija razmaka ispred poglavlja koje slijedi iza
  slike ili tablice). Oba su imenovani parametri i objašnjeni u komentarima klase; ponovno ih
  provjeriti s novim izvozom iz Worda ako se promijeni predložak ili fontovi.
- Korekcija `\crocee@floatcomp` (0.285 bp) nije empirijska: to je promjena razmaka osnovnih
  linija pri prijelazu s retka naslova tablice/slike od 10 pt na redak teksta od 11 pt,
  izvedena iz istog modela retka.
- Uvlaka odlomaka (1 cm) slijedi pisane upute; sam primjer teksta u Wordu nije uvučen
  (`noparindent` to reproducira).

### Provjera

- **Prevođenje.** Oba primjera prevode se bez grešaka s pdfLaTeX-om i XeLaTeX-om (TeX Live
  2023); testirani su primjeri `.bib` zapisa, hrvatska slova u imenima, široke tablice,
  fusnote, endnote te korisnički učitani `hyperref`/`cleveref`.
- **Usporedba s Wordom.** Ranija inačica klase (Palatino s jednostrukim proredom, faktor
  1.352) uspoređena je redak po redak s PDF-om izvezenim iz Worda (osnovne linije unutar
  0.3 pt, identičan prijelom redaka). Trenutačna inačica, s proredom „točno 1.26", **još nije
  uspoređena** s novim izvozom iz Worda; dotad se ne mogu isključiti razlike od djelića
  točke u okomitim položajima, a prijelom redaka ovisi o fontovima (vidi
  [Zahtjevi](#zahtjevi-i-prevođenje)).

### Autori, zasluge, licenca

Predložak: Marin Grubišić i Vedran Jagodnik (Sveučilište u Rijeci, Građevinski fakultet), uz
pomoć Claudea (Anthropic) i Geminija (Google).

- `Definitions/Elsevier.csl` nepromijenjeni je CSL stil „Elsevier (numeric, with titles)"
  autora Richarda Karneskog i Rintzea Zellea, licenca
  [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/).
- `Definitions/Elsevier.bst` BibTeX je izvedba istog stila, napisana za ovaj predložak; kao
  izvedeno djelo također se distribuira pod CC BY-SA 3.0.

<!-- Prije objave ovdje treba navesti licencu predloška (CroCEE.cls, .tex datoteke) te
     podrijetlo/dopuštenje za logo i za Figures/example_figure.png. -->

[↑ Hrvatski](#-hrvatski) · [🇬🇧 English](#-english)
