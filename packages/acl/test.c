#include <stdio.h>
#include <sys/acl.h>

int main() {
    // Read the ACL of file perms.txt
    acl_t acl = acl_get_file("perms.txt", ACL_TYPE_ACCESS);
    if (acl == NULL) {
        printf("Test failed: failed to read ACL\n");
        return 1;
    }

    // Print string representation of ACL
    char *text = acl_to_text(acl, NULL);
    printf("%s", text);

    acl_free(text);
    acl_free(acl);    
    return 0;
}
