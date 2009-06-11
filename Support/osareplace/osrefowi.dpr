program osrefowi;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{ Usage: osrefowi <CHARS_SEND_TO_R> (send CHARS to R (with caption 'R Console')

  Notes:
  - In E the string will be enclosed with a 'ORFW#' prefix and '#ORFW' suffix.
    It arrives here as 'ORFW#...#ORFW' or '"ORFW#...#ORFW"' and we can strip
    it (without ORFW# we couldn't distinct between real '"' and inserted ones.
  - Delphi masks '"' with '\' and sometimes adds a trailing '#10'.
  - Between character post messages some sleep is needed to avoid losses.
  - ALT+CTRL+SHIFT keys must be released before VK_RETURN is sent to R; for
    such activation key we can add a ALTCTRLSHIFT suffix to the command and
    wait a longer before sending VK_RETURN to give user time to release keys. }

uses
  SysUtils,
  Windows,
  Messages;

type
  EOsaMessage = class( Exception );

function FixParameterString( var p: string; const pref: string; const suff: string ): boolean;
  var
    idx: integer;
  begin
    if Copy( p, 1, Length( pref ) ) = pref then begin
      idx:= Pos( suff, p );
      if not ((idx > 0) and
              ((idx + length( suff )) = (length( p ) + 1)) and
              (Copy( p, idx, Length( suff ) ) = suff))
      then begin
        raise Exception.Create( 'there is a ' + pref + ' prefix but no ' + suff + ' suffix' );
      end;
        { delete suffix }
      Delete( p, idx, Length( suff ) );
        { delete prefix }
      Delete( p, 1, Length( pref ) );

        { delete trailing CR, LN }
      if (Length( p ) > 0) and (p[Length( p )] = #10) then begin
        Delete( p, length( p ), 1 );
      end;

      result:= True;
    end else begin
      result:= False;
    end;
  end {FixParameterString};

const
  theCall = 'Usage: osrefowi[.exe] <CHARS_SEND_TO_R>';
  theCaption = 'R Console';
  thePref_1 =  'ORFW#'; theSuff_1 = '#ORFW';
  thePref_2 = '"ORFW#'; theSuff_2 = '#ORFW"';
  theAltCtrlShift = 'ALTCTRLSHIFT';
var
  wnd: HWND;
  m: string;      // s is temp
  i, idx: integer;
  insertedBS: boolean;  // inserted backslash by delphi
  exflag: integer;
  hasAltCtrlShift: boolean;
begin {osrefowi}
  exflag:= 0;
  try
      { note: used CmdLine as ParamCount/ParamStr have problems with ' and " }
    m:= CmdLine;

      { cut program name, some checks }
    idx:= Pos( 'osrefowi', m );
    if idx > 0 then begin
      while (idx < length( m )) and (m[idx] <> ' ') do Inc( idx );
    end;
    if (idx = 0) or (not idx > length( m )) then begin
      raise EOsaMessage.Create( theCall + '(sent: ' + m + ')' );
    end;
    Delete( m, 1, idx );

      { fix parameter string }
    if not (FixParameterString( m, thePref_1, theSuff_1 ) or
            FixParameterString( m, thePref_2, theSuff_2 ))
    then begin
      raise Exception.Create( 'strings sent from e must be enclosed in ' +
          thePref_1 + '/' + theSuff_1 + ' or ' + thePref_2 + '/' + theSuff_2 );
    end;

      { Alt+Ctrl+Shift pause handling }
    hasAltCtrlShift:= Pos( theAltCtrlShift, m ) > 0;
    if hasAltCtrlShift then begin
      Delete( m, Pos( theAltCtrlShift, m ), Length( theAltCtrlShift ) );
      Sleep( 150 );
    end;

      { find R window, focus and send cmdline }
    wnd:= FindWindow( nil, theCaption );
    if wnd <> 0 then begin
      ShowWindow( wnd, SW_RESTORE );
      SetFocus( wnd );
      insertedBS:= False;
      for i:= 1 to length( m ) do begin
        if insertedBS or (m[i] <> '\') then begin
          PostMessage( wnd, WM_CHAR, word(m[i]), 0 );
          insertedBS:= False;
        end else begin
          if (i < length( m )) and (m[i + 1] = '"') then begin
              { ignore \ before a " }
            insertedBS:= True;
          end else begin
            PostMessage( wnd, WM_CHAR, word(m[i]), 0 );
          end;
        end;
          { regularly sleep a little}
        if i mod 20 = 0 then Sleep( 10 );
      end {for};

        { another Alt+Ctrl+Shift pause }
      if hasAltCtrlShift then Sleep( 150 );

        { send VK_RETURN key s}
      PostMessage( wnd, WM_KEYDOWN, VK_RETURN, 0 );

    end else begin
      raise EOsaMessage.CreateFmt( 'Error: couldn''t find R, i.e. window with the caption "%s"', [theCaption] );
    end {if};

  except
    on E: EOsaMessage do begin
      WriteLn( 'osrefowi message: ' + E.Message );
    end;
    on E: Exception do begin
      WriteLn( 'osrefowi exception: ' + E.Message );
      exflag:= 1;
    end;
  end;
    { give back exit code }
  Halt( exflag );

end {osrefowi}.
