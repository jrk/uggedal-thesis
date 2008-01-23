% UiO LaTeX Thesis Class
\ProvidesClass{uiothesis}
\NeedsTeXFormat{LaTeX2e}

% Pass class options to the memoir class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions
\LoadClass{memoir}

% Internal variables
\newcommand{\@subtitle}{}
\newcommand{\@scm}{}

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\scm}[1]{\renewcommand{\@scm}{#1}}

% Font setup
\RequirePackage[T1]{fontenc}
\IfFileExists{lmodern.sty}{%
  \RequirePackage{lmodern}
  \RequirePackage[osf]{mathpazo}
  \renewcommand\rmdefault{pplj}
}{%
  \RequirePackage{mathpazo}
}

% Laying out the page
\settypeblocksize{44\onelineskip}{29pc}{*}
\setlrmargins{5pc}{*}{*}
\setulmargins{*}{*}{1.618}
\setmarginnotes{2pc}{10pc}{\baselineskip}
\checkandfixthelayout

% UiO chapter style
\makechapterstyle{uio}{%
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\printchapternum}{%
    \marginpar{%
      \vspace{80pt}
      \scalebox{5}{\huge \thechapter}
      \vspace{20pt}
    }%
  }%
  \renewcommand{\afterchapternum}{}
  \renewcommand{\printchaptertitle}[1]{%
    \raggedright\huge ##1
  }%
}

% Section style
\setsecheadstyle{\raggedright\Large}
\setsubsecheadstyle{\raggedright\large}
\setsubsubsecheadstyle{\raggedright\itshape}

% UiO page style
\makepagestyle{uio}
\makeevenfoot{uio}{\thepage}{}{}
\makeoddfoot{uio}{}{}{\thepage}

% Plain headers and footers
\makeevenfoot{plain}{\thepage}{}{}
\makeoddfoot{plain}{}{}{\thepage}

% Colophon
\newcommand{\makecolophon}{%
  \pagestyle{empty}

  \null\vfil

  \calccentering{\unitlength}
  \begin{adjustwidth*}{\unitlength}{-\unitlength}
    \begin{center}
      {\Large\textsf{Colophon}}
    \end{center}
    \begin{center}
      This thesis was typeset using the \LaTeX{} typesetting system
      created by Leslie Lamport.
      The body text is set 12/14.5pt on a 29pc measure with Palatino 
      designed by Hermann Zapf.
      Other fonts include Sans and Typewriter from Donald Knuth's
      Computer Modern family.
    \end{center}
    \begin{center}
      This thesis was written in American English as dictated by
      \emph{The Elements of Style} \citep{strunk00}.
    \end{center}
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

% Automatic aligned sidenote
\newcommand{\sidenote}[2]%
  [0em]{%
  \footnotemark%
  \strictpagechecktrue
  \ifodd\c@page
    \marginpar{%
      \vspace*{#1}
      \RaggedRight \footnotesize
      \textsuperscript{\thefootnote}#2
    }%
  \else
    \marginpar{%
      \vspace*{#1}
      \RaggedLeft \footnotesize
      \textsuperscript{\thefootnote}#2
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
    \textsuperscript{\thefootnote}#2
  }%
}%
\newcommand{\evensidenote}[2]%
  [0em]{%
  \footnotemark%
  \marginpar{%
    \vspace*{#1}
    \RaggedLeft \footnotesize
    \textsuperscript{\thefootnote}#2
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

% Differences between dvips and pdflatex processors handeled here including:
%   * Hyper references and breaking of URLs
%   * PDF type protrusion
\RequirePackage{ifpdf}
\ifpdf
  \RequirePackage[pdftex,plainpages=false]{hyperref}
  \RequirePackage[protrusion=true,expansion=false]{microtype}
\else
  \RequirePackage[ps2pdf]{hyperref}
  \RequirePackage{breakurl}
\fi
\RequirePackage{memhfixc}

% Coloring
\RequirePackage{color}
\definecolor{urlcolor}{rgb}{0.24,0.35,0.5}
\definecolor{linkcolor}{rgb}{0.6,0.2,0.1}
\definecolor{citecolor}{rgb}{0.35,0.45,0}
\hypersetup{%
  colorlinks,
  breaklinks,
  linkcolor=linkcolor,
  citecolor=black,
  filecolor=black,
  urlcolor=urlcolor
}

% Url formatted with sans serif font
\urlstyle{sf}

% Custom commands

% Renders a variable name with a dollar prefix in tt.
\newcommand{\var}[1]{\texttt{\${#1}}}

% Reference shorthands.
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
