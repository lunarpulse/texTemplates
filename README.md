
## Template installation

## Latex installation

### latex installation

```
sudo apt-get install latexlive texlive texlive-base texlive-latex-recommended texlive-latex-extra
```
### aux installation

```
sudo apt-get install latexmk biber
sudo apt-get install texlive-lang-greek texlive-xetex
```
### tlmgr installation

```
sudo apt-get install xzdec
tlmgr init-usertree
tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final
tlmgr update --self
tlmgr update --all
tlmgr install siunitx fixltx2e microtype xcharter ly1 stix gfsdidot bera ctablestack fontenc natbib graphicx color listings xspace acronym rotating hyperref fontspec

```

## unzip and make
