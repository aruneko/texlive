# TeX Live Docker image
## これなに？
比較的小さめに収めたTeX Liveが入っているDocker Imageです。

## 何が使えるの？
platexとuplatexはコンパイルできます。latexmkも導入済みなので、変更を検知しながらのコンパイルができます。notoフォントも入れてあるのでWebブラウザ上でのPDFプレビューも日本語に対応しています。またPygmentsを導入してあるため、mintedによるソースコードのシンタックスハイライトも利用可能です。

## Docker Imageのビルド方法は？

```bash
$ docker build -t aruneko/texlive .
```

## ビルド済みのイメージを入手するには？

```bash
$ docker pull aruneko/texlive
```

## このイメージを使ってLaTeXのソースをビルドするには？
### platexを利用する場合の例

```bash
$ docker container run -v $(pwd):/texsrc -it --rm aruneko/texlive platex foo.tex
```

### latexmkによる自動コンパイル

```bash
$ docker container run -v $(pwd):/texsrc -it --rm aruneko/texlive latexmk -pvc foo.tex
```
