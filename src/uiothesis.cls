% UiO LaTeX Thesis Class
%
\ProvidesClass{uiothesis}


% Default options
\newcommand{\@@sides}{twoside}
\newcommand{\@@ptsize}{10pt}
\newcommand{\@@papersize}{a4paper}
\newcommand{\@@status}{final}


% This class is based on the book class
\LoadClass[\@@ptsize,\@@papersize,\@@sides,\@@status]{book}


% Headings
\RequirePackage{fancyhdr}

\pagestyle{fancyplain}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection{} #1}}
\lhead[\fancyplain{}{\bfseries\thepage}]
    {\fancyplain{}{\bfseries\rightmark}}
\rhead[\fancyplain{}{\bfseries\leftmark}]
    {\fancyplain{}{\bfseries\thepage}}
\cfoot[]{}
\addtolength{\headheight}{1.6pt}


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

% Custom commands
\newcommand{\var}[1]{\texttt{\${#1}}}
