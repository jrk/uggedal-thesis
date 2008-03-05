% UiO LaTeX Thesis Class
\ProvidesClass{uiothesis}
\NeedsTeXFormat{LaTeX2e}

% Based on the memoir class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions
\LoadClass{memoir}


%%
%% Variables
%%

% Internal variables
\newcommand{\@subtitle}{}
\newcommand{\@scm}{}

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\scm}[1]{\renewcommand{\@scm}{#1}}


%%
%% Global setup
%%

% Font setup
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[osf]{mathpazo}
\renewcommand\rmdefault{pplj}
\newfont{\chapnum}{eurb10 scaled 8000}

% Creates an fourier ornament. Args: fontsize, lineheight, char
\RequirePackage{fourier-orns}
\newcommand*{\fourierOrnament}[3]{{%
  \fontencoding{U}\fontfamily{futs}\fontsize{#1}{#2}\selectfont\char#3}}

% Laying out the page
\settypeblocksize{44\onelineskip}{28pc}{*}
\setlrmargins{5pc}{*}{*}
\setulmargins{*}{*}{1.618}
\setmarginnotes{2pc}{10pc}{\baselineskip}
\checkandfixthelayout

% Coloring
\RequirePackage{color}
\definecolor{chapnum}{gray}{0.55}
\definecolor{ornament}{gray}{0.85}


%%
%% Division styles
%%

% Chapter style
\makechapterstyle{uio}{%
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\printchapternum}{%
    \marginpar{%
      \vspace{80pt}
      \color{chapnum}\chapnum \thechapter
      \vspace{20pt}
    }%
  }%
  \renewcommand{\afterchapternum}{}
  \renewcommand{\printchaptertitle}[1]{%
    \raggedright\huge\scshape ##1
  }%
}

% Section style
\setsecheadstyle{\raggedright\Large}
\setsubsecheadstyle{\raggedright\large}
\setsubsubsecheadstyle{\raggedright\itshape}


%%
%% Tops and tails
%%

% Page style
\makepagestyle{uio}
\makeevenfoot{uio}{\thepage}{}{}
\makeoddfoot{uio}{}{}{\thepage}

% Plain headers and footers
\makeevenfoot{plain}{\thepage}{}{}
\makeoddfoot{plain}{}{}{\thepage}

%%
%% Lists
%%

% Table of Contents
\maxtocdepth{subsection}

\renewcommand{\cftchapterfont}{\scshape}
\renewcommand{\cftchapterpagefont}{\scshape}
\renewcommand{\cftchapterpresnum}{\hspace*{-1.5em}}
\cftsetindents{chapter}{1.5em}{0em}
\renewcommand{\cftchapterleader}{}
\renewcommand{\cftchapterafterpnum}{\cftparfillskip}

\renewcommand{\cftsectionfont}{\small}
\renewcommand{\cftsectionpagefont}{\small}
\cftsetindents{section}{1.5em}{2.3em}
\renewcommand{\cftsectionleader}{}
\renewcommand{\cftsectionafterpnum}{\cftparfillskip}

\renewcommand{\cftsubsectionfont}{\small}
\renewcommand{\cftsubsectionpagefont}{\small}
\cftsetindents{subsection}{3.8em}{2.8em}
\renewcommand{\cftsubsectionleader}{}
\renewcommand{\cftsubsectionafterpnum}{\cftparfillskip}

% List of Figures/Tables
\renewcommand{\cftfigureleader}{ }
\renewcommand{\cftfigureafterpnum}{\cftparfillskip}

\renewcommand{\cfttableleader}{ }
\renewcommand{\cfttableafterpnum}{\cftparfillskip}

% Enumeratable list
\newenvironment{enum}{%
  \begin{list}{\arabic{enumi}}{%
    \setlength{\topsep}{\parskip}
    \setlength{\partopsep}{\parskip}
    \setlength{\parsep}{\parskip}
    \setlength{\itemsep}{\parskip}
    \setlength{\leftmargin}{0pt}
    \setlength{\itemindent}{0pt}
  }
}{\end{list}}

% Itemized list
\renewenvironment{itemize}{%
  \begin{list}{}{%
    \setlength{\topsep}{\parskip}
    \setlength{\partopsep}{\parskip}
    \setlength{\parsep}{\parskip}
    \setlength{\itemsep}{\parskip}
    \setlength{\leftmargin}{0pt}
    \setlength{\itemindent}{0pt}
  }
}{\end{list}}
\let\enditemize =\endlist

% Description list
\newcommand{\itlabel}[1]{\textbullet\hspace\labelsep\normalfont\itshape #1}
\newenvironment{desc}{%
  \begin{list}{}{%
    \setlength{\topsep}{\parskip}
    \setlength{\partopsep}{\parskip}
    \setlength{\parsep}{\parskip}
    \setlength{\itemsep}{\parskip}
    \setlength{\itemindent}{0pt}
    \setlength{\listparindent}{\parindent}
    \setlength{\leftmargin}{0pt}
    \setlength{\labelsep}{0.5em}
    \setlength{\labelwidth}{\leftmargin}
    \addtolength{\labelwidth}{-\labelsep}
    \addtolength{\itemindent}{-\labelsep}
    \let\makelabel\itlabel
  }
}{\end{list}}


%%
%% Side notes/tables/figures
%%

% Captions
\RequirePackage{caption}
\captionsetup[figure]{font={footnotesize,sf}}

% The mark on the sidenote
\newcommand{\sidemark}[1]{#1.{\:}}

% Automatic aligned sidenote
\DeclareRobustCommand{\sidenote}[2]%
  [0em]{%
  \footnotemark%
  \strictpagechecktrue
  \ifodd\c@page
    \marginpar{%
      \vspace*{#1}
      \RaggedRight \footnotesize
      \sidemark{\thefootnote}\ignorespaces#2
    }%
  \else
    \marginpar{%
      \vspace*{#1}
      \RaggedLeft \footnotesize
      \sidemark{\thefootnote}\ignorespaces#2
    }%
  \fi
}%

% Forced right or left aligned sidenote
\newcommand{\oddsidenote}[2]%
  [0em]{%
  \footnotemark%
  \marginpar{%
    \vspace*{#1}
    \RaggedRight \footnotesize
    \sidemark{\thefootnote}\ignorespaces#2
  }%
}%
\newcommand{\evensidenote}[2]%
  [0em]{%
  \footnotemark%
  \marginpar{%
    \vspace*{#1}
    \RaggedLeft \footnotesize
    \sidemark{\thefootnote}\ignorespaces#2
  }%
}%

% Sidetable
\newcommand{\sidetable}[2]{%
  \marginpar{%
    \strictpagechecktrue
    \ifodd\c@page
      \captionsetup{font=footnotesize,justification=raggedright}
      \RaggedRight
    \else
      \captionsetup{font=footnotesize,justification=raggedleft}
      \RaggedLeft
    \fi
    \captionof{table}{#1}
    \footnotesize #2
  }
}

% Sidefigure
\newcommand{\sidefigure}[3]{%
  \marginpar{%
    \strictpagechecktrue
    \ifodd\c@page
      \captionsetup{font=footnotesize,justification=raggedright}
      \RaggedRight
    \else
      \captionsetup{font=footnotesize,justification=raggedleft}
      \RaggedLeft
    \fi
    \footnotesize #3
    \captionof{figure}[#1]{#2}
  }
}

%%
%% Environments
%%

% Full width quote environment
\renewenvironment{quote}{%
  \list{}{%
    \setlength{\topsep}{\baselineskip}
    \setlength{\partopsep}{\baselineskip}
    \setlength{\itemindent}{0pt}
    \setlength{\listparindent}{0pt}
    \setlength{\leftmargin}{0pt}
  }%
  \itshape\item[]
}{\endlist}

% Cite quote environment
\newcommand{\@quotekey}{undefined}
\newcommand{\@quoteopt}{undefined}
\newenvironment{citequote}[2][]{%
  \renewcommand{\@quoteopt}{#1}
  \renewcommand{\@quotekey}{#2}
  \begin{quote}
}{%
  \\[0.5\onelineskip]
    \hspace*{\fill}
    \citep[\@quoteopt]{\@quotekey}
  \end{quote}
}

\newlength{\wholemargin}\setlength{\wholemargin}{\marginparwidth}
\addtolength{\wholemargin}{\marginparpush}
\newlength{\wholewidth}\setlength{\wholewidth}{\textwidth}
\addtolength{\wholewidth}{\wholemargin}

% Whole environment
\newenvironment{whole}{%
  \centering
  \strictpagechecktrue
  \begin{adjustwidth*}{0em}{-\wholemargin}
}{%
  \end{adjustwidth*}
}


%%
%% PDF and PS specifics
%%

\RequirePackage{ifpdf}
\ifpdf
  \RequirePackage[pdftex,plainpages=false]{hyperref}
  \RequirePackage[protrusion=true,expansion=false]{microtype}
\else
  \RequirePackage[ps2pdf]{hyperref}
  \RequirePackage{breakurl}
\fi
\RequirePackage{memhfixc}


%%
%% Hyperlinks
%%

\urlstyle{sf}

\hypersetup{%
  colorlinks=false,
  breaklinks,
}


%%
%% Reference shorthands.
%%

\newcommand\figureref[1]{%
  Figure~\ref{figure:#1}%
}
\newcommand\figurepageref[1]{%
  Figure~\ref{figure:#1}
  (p.~\pageref{figure:#1})%
}
\newcommand\tableref[1]{%
  Table~\ref{table:#1}%
}
\newcommand\tablepageref[1]{%
  Table~\ref{table:#1}
  (p.~\pageref{table:#1})%
}
\newcommand\chapterref[1]{%
  Chapter~\ref{chapter:#1}
  (p.~\pageref{chapter:#1})%
}
\newcommand\sectionref[1]{%
  \textsection~\ref{section:#1}
  (p.~\pageref{section:#1})%
}
\newcommand\appendixref[1]{%
  Appendix~\ref{appendix:#1}
  (p.~\pageref{appendix:#1})%
}


%%
%% Declerative formatting
%%

% Items to attend to
\newcommand{\todo}[1]{$\bigotimes$ #1 $\bigotimes$}

% Phrase marker
\newcommand{\dash}{ -- }

% Code snippet
\newcommand{\code}[1]{\texttt{{#1}}}

% UNIX-style variable name.
\newcommand{\var}[1]{\code{\${#1}}}

% Executable name
\let\executable\code

% Term (first usage)
\newcommand{\term}[1]{\textit{{#1}}}

% Title of artistic or academic work
\let\work\term

% Abbreviations (mostly acronyms, but all full caps abbreviations)
\newcommand{\abbr}[1]{\textsc{\MakeLowercase{#1}}}

% Project name (first usage?)
\newcommand{\project}[1]{\textsf{{#1}}}

% Quotation
\newcommand{\q}[1]{``#1''}

% A value
\let\val\q

% Inline quotations
\newcommand{\prequote}[4][]{\citet[#1]{#2} #3 \q{#4}.}
\newcommand{\openprequote}[4][]{\citet[#1]{#2} #3 \q{#4}}

\newcommand{\postquote}[3][]{\q{#3} \citep[#1]{#2}.}
\newcommand{\postquoteyear}[3][]{\q{#3} \citeyearpar[#1]{#2}.}
\newcommand{\openpostquote}[3][]{\q{#3} \citep[#1]{#2}}
\newcommand{\openpostquoteyear}[3][]{\q{#3} \citeyearpar[#1]{#2}}


%%
%% Constants
%%

\newcommand{\urort}{Ur\o{}rt}


%%
%% Front matter
%%

% Colophon
\newcommand{\makecolophon}{%
  \pagestyle{empty}

  \null\vfil

  \begin{adjustwidth*}{\unitlength}{-\unitlength}
    \raggedright\small
    This thesis was typeset using the \LaTeX{} typesetting\\
    system created by Leslie Lamport.\\
    The body text is set 11/\the\baselineskip{} on a 28pc measure\\
    with Palatino designed by Hermann Zapf.\\
    Other fonts include Sans and Typewriter from\\
    Donald Knuth's Computer Modern family.
  \end{adjustwidth*}

  \begin{adjustwidth*}{\unitlength}{-\unitlength}
    \raggedright\small
    This thesis was written in American English as dictated\\
    by \work{The Elements of Style} \citep{strunk00}.\\
    Typographical decisions were based on recommendations\\
    in \work{The Elements of Typographic Style} \citep{bringhurst04}.
  \end{adjustwidth*}
  
  \vfil

  \begin{adjustwidth*}{\unitlength}{-\unitlength}
    \color{ornament}\fourierOrnament{100}{120}{97}
  \end{adjustwidth*}

  \vfil
}

% Titlepage
\renewcommand{\maketitle}{%
  \begin{titlingpage}
    \calccentering{\unitlength}
    \begin{adjustwidth*}{\unitlength}{-\unitlength}
      \begin{center}
        \null\vspace{1cm}
        \includegraphics[width=0.3\textwidth]{uioseal} \\
        \vspace{2cm}
        {\Huge\textsf{{\@title}}} \\
        \vspace{0.5cm}
        {\Large\textsf{{\@subtitle}}} \\
        \vspace{1cm}
        {\large\@author} \\
        \vspace{1cm}
        {\LARGE\aldineleft} \\
        \vspace{1cm}
        Submitted in partial fulfillment of the requirements \\
        for the degree of Master of Science \\
        \vspace{1cm}
        \@date \\
        \vspace{1cm}
        Department of Informatics \\
        Faculty of Mathematics and Natural Sciences \\
        University of Oslo \\
        \vfill
        \@scm
      \end{center}
    \end{adjustwidth*}
    \clearpage
    \makecolophon
  \end{titlingpage}
}
