// #12 26.01.2018 https://github.com/Koziev/GrammarEngine/issues/12
//
// CD->03.11.2005
// LC->26.01.2018
// --------------

#include <lem/conversions.h>
#include <lem/mime.h>

using namespace lem;

MIMEType::MIMEType(void)
{}

// ****************************************************************
// ����������� ��������� ����������� ������������� ������� MimeStr
// �� ��������, �������� "text/html; charset=windows-1251"
// ****************************************************************
MIMEType::MIMEType( const char *MimeStr )
{
 if( MimeStr==NULL )
  return;

 int i=0;
 const int l=strlen(MimeStr); 

 // ��������� type
 while( i<l && MimeStr[i]!='/' )
  {
   type += MimeStr[i];
   i++;
  }

 if( MimeStr[i]!='/' )
  return;

 i++;

 // ��������� subtype
 while( i<l && MimeStr[i]!=';' && MimeStr[i]!=' ' )
  {
   subtype += MimeStr[i];
   i++;
  }

 if( MimeStr[i]=='\0' ) // #12
  return;

 while( i<l && lem::is_space(MimeStr[i]) )
  i++;

 // � ���������� ����� ���� �������� charset=XXX
 const int ipos_charset = lem_findi( MimeStr+i, "charset=" );
 if( ipos_charset!=UNKNOWN )
  {
   charset = MimeStr+ i+ipos_charset + 8;
  }

 return;
}


// *********************************************
// Combine the parts of MIME into one string:
//  "text/plain charset=iso-8858-1"
// *********************************************
std::string MIMEType::string(void) const
{
 std::string res( type );

 if( !subtype.empty() )
  {
   res += '/';
   res += subtype;
  }

 if( !charset.empty() )
  {
   res += " charset=";
   res += charset;
  }

 return res;
}


bool MIMEType::IsUTF8(void) const
{
 return lem::lem_eqi( charset.c_str(), "utf8" ) || lem::lem_eqi( charset.c_str(), "utf-8" );
}

lem::MIMEType MIMEType::GetTextPlain(void)
{
 return MIMEType("text/plain");
}

