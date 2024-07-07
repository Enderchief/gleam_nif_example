#include <erl_nif.h>
#include "add.h"


static ERL_NIF_TERM add_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    int x, y, ret;
    if (!enif_get_int(env, argv[0], &x)) {
	return enif_make_badarg(env);
    }
    if (!enif_get_int(env, argv[1], &y)) {
	return enif_make_badarg(env);
    }
    ret = add(x, y);
    return enif_make_int(env, ret);
}


static ErlNifFunc nif_funcs[] = {
    {"add", 2, add_nif}
};

ERL_NIF_INIT(add, nif_funcs, NULL, NULL, NULL, NULL)
