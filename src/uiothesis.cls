% UiO LaTeX Thesis Class
%
\ProvidesClass{uiothesis}


% Default options
\newcommand{\@@ptsize}{12pt}
\newcommand{\@@papersize}{a4paper}
\newcommand{\@@sides}{twoside}
\newcommand{\@@status}{final}

% Possible options
\DeclareOption{10pt}{\renewcommand{\@@ptsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\@@ptsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\@@ptsize}{12pt}}

\DeclareOption{letterpaper}{\renewcommand{\@@papersize}{letterpaper}}
\DeclareOption{a4paper}{\renewcommand{\@@papersize}{a4paper}}

\DeclareOption{oneside}{\renewcommand{\@@sides}{oneside}}
\DeclareOption{twoside}{\renewcommand{\@@sides}{twoside}}

\DeclareOption{draft}{\renewcommand{\@@status}{draft}}
\DeclareOption{final}{\renewcommand{\@@status}{final}}

\ProcessOptions

% This class is based on the book class
\LoadClass[\@@ptsize,\@@papersize,\@@sides,\@@status]{book}


% Headers
\RequirePackage{fancyhdr}

\pagestyle{fancy}

\fancyhf{}
\fancyhead[LE,RO]{ \thepage}
\fancyhead[LO]{ \nouppercase{\rightmark}}
\fancyhead[RE]{ \nouppercase{\leftmark}}

\renewcommand{\chaptermark}[1]%
  {\markboth{\thechapter.\ #1}{}%
}
\renewcommand{\sectionmark}[1]%
  {\markright{\thesection.\ #1}{}%
}


% Blank doublepage clears
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifodd
      \c@page
    \else
      \hbox{}
      \thispagestyle{empty}
      \newpage
      \if@twocolumn
        \hbox{}
        \newpage
      \fi
    \fi
  \fi%
}

% Title page
\RequirePackage{graphicx}

\renewcommand{\maketitle}{%
  \begin{titlepage}
    {\parindent 0pt%
      {\centering
          \includegraphics[width=0.50\textwidth]{uioseal}
        \vfill
        \vfill
          \textbf{\Huge{\@title}}
        \vfill
          \Large{\@author}
        \vfill
          \large{Master Thesis in Informatics}
        \vfill
          \large{\today}
        \vfill
          \large{Department of Informatics}\\
          \large{Faculty of Mathematics and Natural Sciences}\\
          \large{University of Oslo}
        \vfill
        \vfill
        \vfill
        \vfill
      \par}% end centering
    }% end parindent
  \end{titlepage}
}%


% Hyper references and breaking of URLs
\RequirePackage[ps2pdf]{hyperref}
\RequirePackage{breakurl}


% Footnotes
\renewcommand{\thefootnote}{\fnsymbol{footnote}}


% Custom commands
\newcommand{\var}[1]{\texttt{\${#1}}}
