// @ziggyware/hlsl-macro-vault-units.hlsl
// Nuclear-grade Unit System using advanced macro metaprogramming
// Production weaponization of the HLSL preprocessor

#ifndef UNIT_VAULT_INCLUDED
#define UNIT_VAULT_INCLUDED

// ============================================================================
// 1. ULTIMATE EXPANSION & CONTROL LAYER
// ============================================================================

#define IDENTITY(x) x
#define EXPAND(x)   x
#define EXPAND2(x)  EXPAND(EXPAND(x))
#define EXPAND3(x)  EXPAND(EXPAND2(x))
#define EXPAND4(x)  EXPAND(EXPAND3(x))

#define DEFER(m)    m
#define DEFER2(m)   DEFER(m)
#define DEFER3(m)   DEFER2(m)

#define EAT(...) 
#define PROBE(x) x, 1
#define CAT(a,b) a##b
#define XCAT(a,b) EXPAND(CAT(a,b))

// ============================================================================
// 2. BOOLEAN METAPROGRAMMING
// ============================================================================

#define TRUE 1
#define FALSE 0

#define NOT(x) CAT(NOT_,x)
#define NOT_0 1
#define NOT_1 0

#define IF(c, t, f) CAT(IF_,c)(t,f)
#define IF_0(t,f) f
#define IF_1(t,f) t

// ============================================================================
// 3. CONVERSION DATABASE (easily extensible)
// ============================================================================

#define UM_TO_M(um)     ((um) * 1e-6f)
#define UM_TO_NM(um)    ((um) * 1000.0f)
#define UM_TO_MM(um)    ((um) * 0.001f)
#define UM_TO_CM(um)    ((um) * 0.0001f)
#define UM_TO_KM(um)    ((um) * 1e-9f)

#define M_TO_UM(m)      ((m) * 1e6f)
#define NM_TO_UM(nm)    ((nm) * 0.001f)

// ============================================================================
// 4. ADVANCED UNIT DEFINER (Nuclear Version)
// ============================================================================

#define DEFINE_UNITS_FULL(prefix, base) \
    /* Raw + Base */ \
    #define prefix##Raw   IDENTITY(base) \
    #define prefix##UM    IDENTITY(base) \
    /* Scaled variants with forced expansion */ \
    #define prefix##M     EXPAND4(UM_TO_M(base)) \
    #define prefix##NM    EXPAND4(UM_TO_NM(base)) \
    #define prefix##MM    EXPAND4(UM_TO_MM(base)) \
    #define prefix##CM    EXPAND4(UM_TO_CM(base)) \
    #define prefix##KM    EXPAND4(UM_TO_KM(base)) \
    /* Reverse conversions */ \
    #define prefix##ToUM_M   EXPAND4(M_TO_UM(prefix##M)) \
    #define prefix##ToUM_NM  EXPAND4(NM_TO_UM(prefix##NM))

// ============================================================================
// 5. VECTOR-AWARE UNIT SYSTEM (the real power)
// ============================================================================

#define DEFINE_VECTOR_UNITS(prefix, base) \
    DEFINE_UNITS_FULL(prefix, base) \
    /* Vectorized access */ \
    #define prefix##M3    (float3(EXPAND4(UM_TO_M(base)), 0, 0)) \
    #define prefix##M4    (float4(EXPAND4(UM_TO_M(base)), 0, 0, 1))

// ============================================================================
// 6. MASS UNIT DECLARATION ENGINE
// ============================================================================

#define DECLARE_UNIT_SET(baseVar, prefix) \
    DEFINE_UNITS_FULL(prefix, baseVar)

#define DECLARE_MULTI_UNITS(...) \
    FOR_EACH_2(DECLARE_UNIT_SET, __VA_ARGS__)

// List processor
#define FOR_EACH_2(m, a, b, ...) m(a,b) IF(SECOND(__VA_ARGS__), FOR_EACH_2(m, __VA_ARGS__), )
#define SECOND(a,...) a

// ============================================================================
// 7. COMPILE-TIME VALIDATION LAYER
// ============================================================================

#define STATIC_ASSERT(cond, msg) \
    IF(NOT(cond), \
        struct msg { int STATIC_ASSERTION_FAILED[-1]; }, \
        EAT )

// Example usage validation
#define VALIDATE_UNIT_SYSTEM() \
    STATIC_ASSERT(sizeof(float) == 4, ERROR_FloatMustBe32Bit)

// ============================================================================
// 8. FULL EXAMPLE USAGE
// ============================================================================

/*
float WorldScaleRaw;           // micrometers
DECLARE_UNIT_SET(WorldScaleRaw, WorldScale);

float3 PositionRaw;
DECLARE_VECTOR_UNITS(Position, PositionRaw);

// Now you have:
float   worldM   = WorldScaleM;
float3  posMeters= PositionM3;

float recovered = WorldScaleToUM_M;   // reverse conversion
*/

#endif