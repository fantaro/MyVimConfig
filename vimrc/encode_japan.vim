" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" エンコードを設定する
"
" Last Change: 25-Mar-2014.
" Maintainer:  樊振剛（ハンシンゴウ） <fantaro@gmail.com>

" 各エンコードを示す文字列のデフォルト値。s:CheckIconvCapabilityを()呼ぶことで
" 実環境に合わせた値に修正される。
"
let s:enc_cp932 = 'cp932'
let s:enc_eucjp = 'euc-jp'
let s:enc_jisx = 'iso-2022-jp'
let s:enc_utf8 = 'utf-8'

" 利用しているiconvライブラリの性能を調べる。
"
" 比較的新しいJISX0213をサポートしているか検査する。euc-jisx0213が定義してい
" る範囲の文字をcp932からeuc-jisx0213へ変換できるかどうかで判断する。
"
function! s:CheckIconvCapability()
  if !has('iconv') | return | endif
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_eucjp = 'euc-jisx0213,euc-jp'
    let s:enc_jisx = 'iso-2022-jp-3'
  else
    let s:enc_eucjp = 'euc-jp'
    let s:enc_jisx = 'iso-2022-jp'
  endif
endfunction

" 'fileencodings'を決定する。
"
" 現在利用している'encoding'の値に応じて、最適な'fileencodings'を設定する。
"
function! s:DetermineFileencodings()
  if !has('iconv') | return | endif
  let value = 'ucs-bom,ucs-2le,ucs-2'
  if &encoding ==? 'utf-8'
    " UTF-8環境向けにfileencodingsを設定する
    let value = 'ucs-bom,utf-8,utf-8-bom,utf-16,utf-16le,cp932,euc-jp,sjis,cp936,euc-cn,big5,cp949,euc-kr'
  elseif &encoding ==? 'cp932'
    " 日本語CP932環境向けにfileencodingsを設定する
    let value = value. ','.s:enc_jisx. ','.s:enc_utf8. ','.s:enc_eucjp
  elseif &encoding ==? 'euc-jp' || &encoding ==? 'euc-jisx0213'
    " 日本語EUC-JP環境向けにfileencodingsを設定する
    let value = value. ','.s:enc_jisx. ','.s:enc_utf8. ','.s:enc_cp932
  else
    " TODO: 必要ならばその他のエンコード向けの設定をココに追加する
  endif
  if has('guess_encode')
    let value = 'guess,'.value
  endif
  let &fileencodings = value
endfunction

"===========================================================================
" パスに日本語を含む際にencを変更した場合の処置.

let s:last_enc = &enc

function! s:OnEncodingChanged()
  " runtimepath(rtp)を変換する.
  if s:last_enc !=# &enc
    if has('iconv')
      let &rtp = iconv(&rtp, s:last_enc, &enc)
    endif
    let s:last_enc = &enc
  endif
endfunction

augroup EncodeJapan
autocmd!
autocmd EncodingChanged * call <SID>OnEncodingChanged()
augroup END

"===========================================================================
" 本ファイルを読み込み(sourceした)時に、最適な設定を実行する。
"
if kaoriya#switch#enabled('utf-8')
  set encoding=utf-8
else
  set encoding=japan
endif
call s:CheckIconvCapability()
call s:DetermineFileencodings()
