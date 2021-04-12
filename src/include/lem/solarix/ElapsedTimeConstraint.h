#if !defined ElapsedTimeConstraint__H
#define ElapsedTimeConstraint__H

#include <lem/noncopyable.h>

namespace Solarix
{
    class ElapsedTimeConstraint : lem::NonCopyable
    {
    public:
        ElapsedTimeConstraint(int _max_elapsed_millisec, int _max_stack_depth);
        ~ElapsedTimeConstraint();

        int GetTimeout() const { return 0; }
        inline bool Exceeded(int current_recursion_depth) const { return false; }
    };
}

#endif
