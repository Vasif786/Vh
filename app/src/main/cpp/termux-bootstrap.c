#include <jni.h>
#include <jni.h>

extern jbyte termux_blob[];
extern jbyte archstr[];
extern int termux_blob_size;

JNIEXPORT jbyteArray JNICALL
Java_vn_vhn_vhscode_CodeServerService_00024Companion_getZip(JNIEnv *env,
                                                            __attribute__((__unused__)) jobject This) {
    jbyteArray ret = (*env)->NewByteArray(env, termux_blob_size);
    (*env)->SetByteArrayRegion(env, ret, 0, termux_blob_size, termux_blob);
    return ret;
}
