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

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}

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
\setulmargins{*}{*}{1.414}
\setmarginnotes{2pc}{10pc}{\baselineskip}
\checkandfixthelayout


% Sidenote
\newcommand{\sidenote}[1]{%
  \footnotemark%
  \ifodd\c@page
    \marginpar{%
      \raggedright \footnotesize
      \textsuperscript{\thefootnote}\,#1
    }%
  \else
    \marginpar{%
      \raggedleft \footnotesize
      \textsuperscript{\thefootnote}\,#1
    }%
  \fi
}%


% Bringhurst chapter style
\makechapterstyle{bringhurst}{%
  \renewcommand{\chapterheadstart}{}
  \renewcommand{\printchaptername}{}
  \renewcommand{\chapternamenum}{}
  \renewcommand{\printchapternum}{%
    \marginpar{%
      \vspace{90pt}
      \scalebox{4}{\chapnumfont \thechapter}
    }%
  }%
  \renewcommand{\afterchapternum}{}
  \renewcommand{\printchaptertitle}[1]{%
    \raggedright\Large\scshape\MakeLowercase{##1}}
  \renewcommand{\afterchaptertitle}{%
    \vskip\onelineskip \hrule\vskip\onelineskip}
}

\setsecheadstyle{\raggedright\scshape\MakeLowercase}
  \setbeforesecskip{-\onelineskip}
  \setaftersecskip{\onelineskip}

\setsubsecheadstyle{\sethangfrom{\noindent ##1}\raggedright\itshape}
  \setbeforesubsecskip{-\onelineskip}
  \setaftersubsecskip{\onelineskip}


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


% Hyper references and breaking of URLs
\RequirePackage[ps2pdf]{hyperref}
\RequirePackage{memhfixc}
\RequirePackage{breakurl}


% Custom commands
\newcommand{\var}[1]{\texttt{\${#1}}}
