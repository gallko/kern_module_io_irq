#include "linux/module.h"

MODULE_AUTHOR("Ruslan");
MODULE_VERSION(VERSION);
MODULE_LICENSE("GPL");

static int __init slics_init(void) {
    return 0;
}

static void __exit slics_exit(void) {
    return;
}

module_init(slics_init);
module_exit(slics_exit);
