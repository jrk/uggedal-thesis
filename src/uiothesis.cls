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

% This class is based on the memoir class
\LoadClass[\@@papersize,%
           \@@ptsize,%
           \@@sides,%
           \@@columns,%
           \@@openwhere,%
           \@@status]{memoir}

% Internal variables
\newcommand{\@subtitle}{}

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}


% Hyper references and breaking of URLs
\RequirePackage[ps2pdf]{hyperref}
\RequirePackage{memhfixc}
\RequirePackage{breakurl}


% Footnotes
\renewcommand{\thefootnote}{\fnsymbol{footnote}}


% Custom commands
\newcommand{\var}[1]{\texttt{\${#1}}}
