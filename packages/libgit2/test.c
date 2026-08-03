#include <stdio.h>
#include <git2.h>

int main(int argc, char *argv[]) {

    // Initialize libgit2
    if (git_libgit2_init() < 0) {
        printf("Error: Failed to initialize libgit2\n");
        return 1;
    }

    // Check if SSH feature was compiled succesfully
    if (!(git_libgit2_features() & GIT_FEATURE_SSH)) {
        printf("Error: libgit2 does not contain ssh support\n");
        git_libgit2_shutdown();
        return 1;
    }

    // Check if HTTPS feature was compiled succesfully
    if (!(git_libgit2_features() & GIT_FEATURE_HTTPS)) {
        printf("Error: libgit2 does not contain https support\n");
        git_libgit2_shutdown();
        return 1;
    }

    // Try to initialize a git repository
    git_repository *repo = NULL;
    if (git_repository_init(&repo, ".", 0) != 0) {
        printf("Error: Failed to initialize git repository\n");
        git_libgit2_shutdown();
        return 1;
    }

    // Free repository
    git_repository_free(repo);

    git_libgit2_shutdown();
    return 0;
}
