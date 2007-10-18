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
    \begin{center}
          \includegraphics[width=0.3\textwidth]{uioseal} \\
        \vspace{2cm}
          \textbf{\Huge{\@title}} \\
        \vspace{1cm}
          {\Large\@author} \\
        \vspace{1cm}
          Submitted in partial fulfillment of the requirements \\
          for the degree of Master of Science \\
        \vspace{1cm}
          \@date \\
        \vspace{1cm}
          Department of Informatics \\
          Faculty of Mathematics and Natural Sciences \\
          University of Oslo \\
        \vspace{5cm}
    \end{center}
  \end{titlepage}
}


% Hyper references and breaking of URLs
\RequirePackage[ps2pdf]{hyperref}
\RequirePackage{breakurl}


% Footnotes
\renewcommand{\thefootnote}{\fnsymbol{footnote}}


% Custom commands
\newcommand{\var}[1]{\texttt{\${#1}}}
