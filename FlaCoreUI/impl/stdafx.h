#pragma once

template <typename T>
class Singleton {
public:
    static T *getInstance();
private:
    Singleton() = default;
    ~Singleton() = default;
    Singleton(const Singleton&) = delete;
    Singleton& operator=(const Singleton&) = delete;
};

template <typename T>
T *Singleton<T>::getInstance() {
    static T *instance = new T();
    return instance;
}

#define SINGLETON(Class)                                                                           \
private:                                                                                           \
    friend class Singleton<Class>;                                                                 \
    Class(const Class&) = delete;                                                                  \
    Class& operator=(const Class&) = delete;                                                       \
                                                                                                   \
    public:                                                                                            \
    static Class *getInstance() {                                                                  \
        return Singleton<Class>::getInstance();                                                    \
}                                                                                              \
    static Class* create(QQmlEngine*, QJSEngine*) { return getInstance(); }


#define Q_PROPERTY_AUTO_P(TYPE, M)                                                                 \
Q_PROPERTY(TYPE M MEMBER _##M NOTIFY M##Changed)                                               \
    public:                                                                                            \
    Q_SIGNAL void M##Changed();                                                                    \
    void M(TYPE in_##M) {                                                                          \
        if (_##M == in_##M) return;                                                                \
        _##M = in_##M;                                                                             \
        Q_EMIT M##Changed();                                                                       \
}                                                                                              \
    TYPE M() {                                                                                     \
        return _##M;                                                                               \
}                                                                                              \
                                                                                                     \
    private:                                                                                           \
    TYPE _##M{nullptr};

#define Q_PROPERTY_AUTO(TYPE, M)                                                                   \
Q_PROPERTY(TYPE M MEMBER _##M NOTIFY M##Changed)                                               \
    public:                                                                                            \
    Q_SIGNAL void M##Changed();                                                                    \
    void M(const TYPE &in_##M) {                                                                   \
        if (_##M == in_##M) return;                                                                \
        _##M = in_##M;                                                                             \
        Q_EMIT M##Changed();                                                                       \
}                                                                                              \
    TYPE M() {                                                                                     \
        return _##M;                                                                               \
}                                                                                              \
                                                                                                     \
    private:                                                                                           \
    TYPE _##M{};


#define Q_PROPERTY_READONLY_AUTO(TYPE, M)                                                          \
Q_PROPERTY(TYPE M READ M NOTIFY M##Changed FINAL)                                              \
    public:                                                                                            \
    Q_SIGNAL void M##Changed();                                                                    \
    TYPE M() {                                                                                     \
        return _##M;                                                                               \
}                                                                                              \
                                                                                                     \
    private:                                                                                           \
    void M(const TYPE &in_##M) {                                                                   \
        if (_##M == in_##M) return;                                                                \
        _##M = in_##M;                                                                             \
        Q_EMIT M##Changed();                                                                       \
}                                                                                              \
    TYPE _##M{};


//导入库
#if defined(FLACOREUI_STATIC)
#define COM_EXPORT  // 静态库不需要导出/导入
#else
#if defined(FLACOREUI_LIBRARY)
#define COM_EXPORT Q_DECL_EXPORT
#else
#define COM_EXPORT Q_DECL_IMPORT
#endif
#endif
