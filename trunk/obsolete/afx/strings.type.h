#ifndef _nd_strings_type_h__
#define _nd_strings_type_h__

namespace Strings
{
    /**
     * Символ - число?
     */
    template <typename C> 
    inline bool Is123(C sym) 
    {
        return (sym >= (C)'0') && (sym <= (C)'9'); 
    }

    /**
     * Символ - точка?
     */
    template <typename C> 
    inline bool IsDot(C sym) 
    {
        return (C)'.' == sym; 
    }

    /**
     * Символ - знак числа?
     */
    template <typename C> 
    inline bool IsSignSymbol(C sym) 
    {
        return ((C)'-' == sym) || ((C)'+' == sym); 
    }

    /**
     * Символ - знак числа или число?
     */
    template <typename C> 
    inline bool IsSignOr123(C sym) 
    {
        return  IsSignSymbol(sym) || Is123(sym); 
    }

    /**
     * Символ - знак числа или число или точка?
     */
    template <typename C> 
    inline bool IsSignOr123OrDot(C sym) 
    {
        return  IsSignSymbol(sym) || Is123(sym) || IsDot(sym); 
    }

    /**
     * Символ - латинская литера?
     */
    template <typename C> 
    inline bool IsAbc(C sym) 
    {
        return (sym >= (C)'a') && (sym <= (C)'z'); 
    }

    /**
     * Символ - заглавная латинская литера?
     */
    template <typename C> 
    inline bool IsAbcUpper(C sym) 
    {
        return (sym >= (C)'A') && (sym <= (C)'Z'); 
    }

    /**
     * Предикат поиска вхождения символа.
     */
    template <typename C>
    struct ExactMatching
    {
        ExactMatching(C sym)
            : Symbol(sym) 
        {}

        bool operator() (C sym) const 
        {
            return Symbol == sym; 
        }

    private:
        C Symbol;
    };
}

#endif /* _nd_strings_type_h__ */
