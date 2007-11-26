% UiO LaTeX Thesis Class
%
\ProvidesClass{uiothesis}


% Default options
\newcommand{\@@papersize}{a4paper}
\newcommand{\@@ptsize}{10pt}
\newcommand{\@@sides}{twoside}
\newcommand{\@@columns}{onecolumn}
\newcommand{\@@openwhere}{openright}
\newcommand{\@@status}{final}

% Possible options
\DeclareOption{letterpaper}{\renewcommand{\@@papersize}{letterpaper}}
\DeclareOption{a4paper}{\renewcommand{\@@papersize}{a4paper}}
\DeclareOption{ebook}{\renewcommand{\@@papersize}{ebook}}
\DeclareOption{9pt}{\renewcommand{\@@ptsize}{9pt}}
\DeclareOption{10pt}{\renewcommand{\@@ptsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\@@ptsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\@@ptsize}{12pt}}
\DeclareOption{17pt}{\renewcommand{\@@ptsize}{17pt}}
\DeclareOption{oneside}{\renewcommand{\@@sides}{oneside}}
\DeclareOption{twoside}{\renewcommand{\@@sides}{twoside}}
\DeclareOption{onecolumn}{\renewcommand{\@@columns}{onecolumn}}
\DeclareOption{twocolumn}{\renewcommand{\@@columns}{twocolumn}}
\DeclareOption{openright}{\renewcommand{\@@openwhere}{openright}}
\DeclareOption{openleft}{\renewcommand{\@@openwhere}{openleft}}
\DeclareOption{openany}{\renewcommand{\@@openwhere}{openany}}
\DeclareOption{draft}{\renewcommand{\@@status}{draft}}
\DeclareOption{final}{\renewcommand{\@@status}{final}}
\ProcessOptions

% Internal variables
\newcommand{\@subtitle}{}
\newcommand{\@scm}{}

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\scm}[1]{\renewcommand{\@scm}{#1}}

% This class is based on the memoir class
\LoadClass[\@@papersize,%
           \@@ptsize,%
           \@@sides,%
           \@@columns,%
           \@@openwhere,%
           \@@status]{memoir}

% Laying out the page
\settypeblocksize{*}{28pc}{2}
\setlrmargins{5pc}{*}{*}
\setulmargins{*}{*}{3}
\setmarginnotes{2pc}{10pc}{\baselineskip}
\checkandfixthelayout

% Bringhurst chapter style
\makechapterstyle{bringhurst}{%
  \renewcommand{\chapterheadstart}{}
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\printchapternum}{%
    \marginpar{%
      \vspace{90pt}
      \scalebox{4}{\chapnumfont \thechapter}
      \vspace{20pt}
    }%
  }%
  \renewcommand{\afterchapternum}{}
  \renewcommand{\printchaptertitle}[1]{%
    \raggedright\Large\scshape\MakeLowercase{##1}}
  \renewcommand{\afterchaptertitle}{%
    \vskip\onelineskip \hrule\vskip\onelineskip}
}

\setsecheadstyle{\raggedright\large\scshape\MakeLowercase}
  \setbeforesecskip{-\onelineskip}
  \setaftersecskip{\onelineskip}

\setsubsecheadstyle{\raggedright\scshape\MakeLowercase}
  \setbeforesubsecskip{-\onelineskip}
  \setaftersubsecskip{\onelineskip}

\setsubsubsecheadstyle{\sethangfrom{\noindent ##1}\raggedright\itshape}
  \setbeforesubsubsecskip{-\onelineskip}
  \setaftersubsubsecskip{\onelineskip}

% Bringhurst page style
\makepagestyle{bringhurst}
\makeevenfoot{bringhurst}{\thepage}{}{}
\makeoddfoot{bringhurst}{}{}{\thepage}

\newlength{\pwlayi}\setlength{\pwlayi}{0.45\textwidth}
\newlength{\pwlayii}\setlength{\pwlayii}{0.45\pwlayi}
\setlength{\pwlayi}{\headsep}
\addtolength{\pwlayi}{\topskip}
\addtolength{\pwlayi}{7.3\onelineskip}

\newcommand{\bringpicr}[1]{%
  \setlength{\unitlength}{1pt}
  \begin{picture}(0,0)
    \put(\strip@pt\marginparsep, -\strip@pt\pwlayi){%
      \begin{minipage}[t]{\marginparwidth}
         \raggedright\itshape #1
      \end{minipage}}
  \end{picture}
}

\setlength{\pwlayii}{\marginparsep}
\addtolength{\pwlayii}{\marginparwidth}

\newcommand{\bringpicl}[1]{%
  \setlength{\unitlength}{1pt}
  \begin{picture}(0,0)
    \put(-\strip@pt\pwlayii, -\strip@pt\pwlayi){%
      \begin{minipage}[t]{\marginparwidth}
        \raggedleft\itshape #1
      \end{minipage}}
  \end{picture}
}

\makepsmarks{bringhurst}{%
  \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{##1}{##1}}
  \def\sectionmark##1{\markright{##1}}
}

\makeevenhead{bringhurst}{\bringpicl{\rightmark}}{}{}
\makeoddhead{bringhurst}{}{}{\bringpicr{\leftmark}}

% Plain headers and footers
\makeevenfoot{plain}{\thepage}{}{}
\makeoddfoot{plain}{}{}{\thepage}

% Titlepage
\renewcommand{\maketitle}{%
  \begin{titlingpage}
    \calccentering{\unitlength}
    \begin{adjustwidth*}{\unitlength}{-\unitlength}
      \begin{center}
        \includegraphics[width=0.3\textwidth]{uioseal} \\
        \vspace{2cm}
        \textbf{\Huge{\@title}} \\
        \vspace{0.5cm}
        \textbf{\Large{\@subtitle}} \\
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
        \vfill
        \@scm
      \end{center}
    \end{adjustwidth*}
  \end{titlingpage}
}

% Sidenote filler
\newcommand{\sidefill}{%
  \marginpar{%
    \vspace{50pt}
  }%
}%

% Sidenote
\newcommand{\sidenote}[1]{%
  \footnotemark%
  \strictpagechecktrue
  \ifodd\c@page
    \marginpar{%
      \RaggedRight \footnotesize
      \textsuperscript{\thefootnote}\,#1
    }%
  \else
    \marginpar{%
      \RaggedLeft \footnotesize
      \textsuperscript{\thefootnote}\,#1
    }%
  \fi
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

% Hyper references and breaking of URLs
\RequirePackage{ifpdf}
\ifpdf
  \RequirePackage[pdftex,plainpages=false]{hyperref}
  \RequirePackage[protrusion=true,expansion=false]{microtype}
\else
  \RequirePackage[ps2pdf]{hyperref}
  \RequirePackage{breakurl}
\fi
\RequirePackage{memhfixc}

% Custom commands
\newcommand{\var}[1]{\texttt{\${#1}}}
