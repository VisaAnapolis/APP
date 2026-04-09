unit uHashSenha;

{
  SHA-256 puro Pascal - compativel com Delphi 7
  Sem dependencias externas.

  HashSenha(s)   : retorna SHA-256 da senha como string hex de 64 chars (maiusculo)
  SenhasIguais   : compara senha digitada com valor armazenado (hash ou plain text herdado)
}

interface

function HashSenha(const Senha: string): string;
function SenhasIguais(const SenhaDigitada: string; const Armazenada: string): Boolean;

implementation

uses SysUtils;

const
  SHA256_K: array[0..63] of LongWord = (
    $428a2f98, $71374491, $b5c0fbcf, $e9b5dba5,
    $3956c25b, $59f111f1, $923f82a4, $ab1c5ed5,
    $d807aa98, $12835b01, $243185be, $550c7dc3,
    $72be5d74, $80deb1fe, $9bdc06a7, $c19bf174,
    $e49b69c1, $efbe4786, $0fc19dc6, $240ca1cc,
    $2de92c6f, $4a7484aa, $5cb0a9dc, $76f988da,
    $983e5152, $a831c66d, $b00327c8, $bf597fc7,
    $c6e00bf3, $d5a79147, $06ca6351, $14292967,
    $27b70a85, $2e1b2138, $4d2c6dfc, $53380d13,
    $650a7354, $766a0abb, $81c2c92e, $92722c85,
    $a2bfe8a1, $a81a664b, $c24b8b70, $c76c51a3,
    $d192e819, $d6990624, $f40e3585, $106aa070,
    $19a4c116, $1e376c08, $2748774c, $34b0bcb5,
    $391c0cb3, $4ed8aa4a, $5b9cca4f, $682e6ff3,
    $748f82ee, $78a5636f, $84c87814, $8cc70208,
    $90befffa, $a4506ceb, $bef9a3f7, $c67178f2
  );

function ROR32(const V: LongWord; const N: Byte): LongWord;
begin
  Result := (V shr N) or (V shl (32 - N));
end;

function SHA256Hex(const Data: string): string;
var
  H: array[0..7] of LongWord;
  W: array[0..63] of LongWord;
  Msg: string;
  BitLo: LongWord;
  Blocks, Block, i: Integer;
  pB: PChar;
  a, b, c, d, e, f, g, hh: LongWord;
  S0, S1, Ch, Maj, T1, T2: LongWord;
begin
  // Pre-processamento: padding SHA-256
  Msg := Data + #$80;
  while (Length(Msg) mod 64) <> 56 do
    Msg := Msg + #0;
  // Comprimento original em bits como inteiro de 64 bits big-endian (hi = 0)
  BitLo := LongWord(Length(Data)) * 8;
  Msg := Msg + #0#0#0#0;
  Msg := Msg + Chr((BitLo shr 24) and $FF);
  Msg := Msg + Chr((BitLo shr 16) and $FF);
  Msg := Msg + Chr((BitLo shr  8) and $FF);
  Msg := Msg + Chr( BitLo         and $FF);

  // Valores iniciais SHA-256
  H[0] := $6a09e667; H[1] := $bb67ae85;
  H[2] := $3c6ef372; H[3] := $a54ff53a;
  H[4] := $510e527f; H[5] := $9b05688c;
  H[6] := $1f83d9ab; H[7] := $5be0cd19;

  Blocks := Length(Msg) div 64;
  for Block := 0 to Blocks - 1 do
  begin
    pB := @Msg[Block * 64 + 1];

    // Monta schedule W[0..15] a partir dos bytes do bloco (big-endian)
    for i := 0 to 15 do
      W[i] := (LongWord(Ord(pB[i*4  ])) shl 24) or
               (LongWord(Ord(pB[i*4+1])) shl 16) or
               (LongWord(Ord(pB[i*4+2])) shl  8) or
                LongWord(Ord(pB[i*4+3]));

    // Expande para W[16..63]
    for i := 16 to 63 do
    begin
      S0 := ROR32(W[i-15],  7) xor ROR32(W[i-15], 18) xor (W[i-15] shr  3);
      S1 := ROR32(W[i- 2], 17) xor ROR32(W[i- 2], 19) xor (W[i- 2] shr 10);
      W[i] := W[i-16] + S0 + W[i-7] + S1;
    end;

    // Compressao
    a := H[0]; b := H[1]; c := H[2]; d := H[3];
    e := H[4]; f := H[5]; g := H[6]; hh := H[7];

    for i := 0 to 63 do
    begin
      S1  := ROR32(e,  6) xor ROR32(e, 11) xor ROR32(e, 25);
      Ch  := (e and f) xor ((not e) and g);
      T1  := hh + S1 + Ch + SHA256_K[i] + W[i];
      S0  := ROR32(a,  2) xor ROR32(a, 13) xor ROR32(a, 22);
      Maj := (a and b) xor (a and c) xor (b and c);
      T2  := S0 + Maj;
      hh := g; g := f; f := e; e := d + T1;
      d := c; c := b; b := a; a := T1 + T2;
    end;

    H[0] := H[0] + a; H[1] := H[1] + b;
    H[2] := H[2] + c; H[3] := H[3] + d;
    H[4] := H[4] + e; H[5] := H[5] + f;
    H[6] := H[6] + g; H[7] := H[7] + hh;
  end;

  Result := '';
  for i := 0 to 7 do
    Result := Result + IntToHex(Integer(H[i]), 8);
end;

{ Retorna SHA-256 da senha como string hex de 64 caracteres maiusculos }
function HashSenha(const Senha: string): string;
begin
  Result := SHA256Hex(Senha);
end;

{
  Compara senha digitada com o valor armazenado no banco, suportando
  migração gradual: se o valor armazenado tem 64 chars assume que é hash;
  caso contrário compara em plain text (senhas legadas antes da migração).
}
function SenhasIguais(const SenhaDigitada: string; const Armazenada: string): Boolean;
begin
  if Length(Armazenada) = 64 then
    Result := HashSenha(SenhaDigitada) = Armazenada
  else
    Result := SenhaDigitada = Armazenada;
end;

end.
