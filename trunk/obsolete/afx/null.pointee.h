#ifndef _nd_null_pointee_h__
#define _nd_null_pointee_h__

extern "C" void* _null_ptr();
extern "C" bool _is_null_ptr(void* block);

#ifdef __cplusplus
template <class T>
inline bool _is_null_ptr(T const& something)
{
    return _is_null_ptr((void*)something);
}
#endif /* __cplusplus */

#endif /* _nd_null_pointee_h__ */