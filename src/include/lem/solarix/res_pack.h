// -----------------------------------------------------------------------------
// File RES_PACK.H
//
// (c) Koziev Elijah
//
// Content:
// ����� Res_Pack - ����� �������, ������ ���������� (������ ������
// Variator), ������������ � ��������� SOL_CAA. ����� ������� ��������
// � ������ ������ ����� ������ SolPhrasoBlock.
// -----------------------------------------------------------------------------
//
// CD->07.09.1997
// LC->23.04.2018
// --------------

#if !defined( SOL_RESPACK__H ) && !defined SOL_NO_AA
#define SOL_RESPACK__H
#pragma once

#include <lem/math/fp1.h>
#include <lem/stl.h>

#include <lem/solarix/variator.h>

namespace Solarix
{
  using lem::MCollect;
 /***********************************************************************
  ����� ������� - ����� ���������� ��� �������������� �������� ���.
  �� ������ ������ ��� ��������� �������� ��������������� ������ �������
  ������� �����. ���������� ��������� � ����� ������ ���������� �� �����
  ������� - �� ����� �������� �����, � �������� ��������� ������������
  ��������� ���������� - ����� ����� �������� ������������ ����������
  ��� ������� ����� �������.
 ************************************************************************/
 class SynGram;

 class Res_Pack
 {
  private:
   MCollect<Variator*> list; // ������ ����������.

        void Init(const Res_Pack &rp);

  public:
        Res_Pack();
        Res_Pack(const Res_Pack &rp);
        ~Res_Pack();

        void Delete();

        void Clear();

        inline void reserve(int n) { list.reserve(n); }

        void operator=(const Res_Pack &rp);

        inline       MCollect<Variator*>& vars() { return list; }
        inline const MCollect<Variator*>& vars() const { return list; }

#if defined SOL_LOADBIN
        void LoadBin(lem::Stream &binfile);
#endif

        void SaveBin(lem::Stream &binfile) const;

        void Add(Variator *to_add);
        void AddFirst(Variator *to_add);

        inline Res_Pack& operator<<(Variator *to_add)
        {
            Add(to_add); return *this;
        }

        void ForgetPtr(int i);
        inline void SetPtr(int i, Variator *Var) { list[i] = Var; }

   void Print(
              OFormatter &s,
              SynGram &s_gram,
            bool detailed = false
             ) const;

   void PrintRoots(
                   OFormatter &s,
            bool Decoration = true,
            bool EntryKeys = true
                  ) const;

   // �������� ���������� (���������) �� ����� ������� - �������� ���������.
        void Recevoire(Res_Pack *src);

   // ���������� ����� �������� ����� � ����� ���������� ���������
        int GetShortestVar() const;

   // ��������� ������ ��������� � ����������� ������ ������.
        void Save_Shortest_Vars();

   // ������������� ���, ����� ������� ��� ����� �������� ��������
        void SortByLengthDescending();
 };


    inline void Res_Pack::Add(Variator *to_add)
 {
        list.push_back(to_add);
 }

    inline void Res_Pack::AddFirst(Variator *to_add)
 {
        list.Insert(0, to_add);
 }

    inline void Res_Pack::Clear()
 {
  list.clear();
 }

 /*****************************************************************
  ����������� ������ ���������� �� ���������: ��������� � ��������
  iVar ���������� �� NULL, ��������������� ���� ������������ �����.
  �������� ������� ��������� �� ������� iVar �� ����������.
 ******************************************************************/
    inline void Res_Pack::ForgetPtr(int iVar)
 {
        list[iVar] = nullptr;
 }

} // namespace 'Solarix'

#endif
