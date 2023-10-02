# Remove file from git history permanently
[Source](https://www.educative.io/answers/how-to-remove-sensitive-files-and-their-commits-from-git-history)


> Backup your repository: Before making any significant changes, it's good practice to create a backup of your repository. You can do this by simply cloning it to a different location on your machine or by making a zip archive.


## Use the filter-branch command
To remove a specific file from the entire history, you can use the filter-branch command. Here's how:
```bash
# I manually ran one after another
PATH_TO_FILE=vue/project/src/views/Glaucoma.vue
PATH_TO_FILE=vue/project/src/views/AMD.vue
PATH_TO_FILE=vue/project/src/components/Glaucoma.vue
PATH_TO_FILE=vue/project/src/components/GlaucomaBB.vue
PATH_TO_FILE=vue/project/src/components/GlaucomaClick.vue
PATH_TO_FILE=vue/project/src/components/GlaucomaHover.vue
PATH_TO_FILE=vue/project/src/components/AMD.vue
# DIR? (Added -r...look closely)
PATH_TO_FILE=postgres

git filter-branch --force --index-filter "git rm -r --cached --ignore-unmatch $PATH_TO_FILE" --prune-empty --tag-name-filter cat -- --all
```

```bash
WARNING: git-filter-branch has a glut of gotchas generating mangled history
         rewrites.  Hit Ctrl-C before proceeding to abort, then use an
         alternative filtering tool such as 'git filter-repo'
         (https://github.com/newren/git-filter-repo/) instead.  See the
         filter-branch manual page for more details; to squelch this warning,
         set FILTER_BRANCH_SQUELCH_WARNING=1.
Proceeding with filter-branch...

Rewrite 15c9dc6237e46bc661afe3dd23e8ec09fb5d074b (17/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 477ef05fbc5f1759971e4dc52e42094073673ad1 (18/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 5158b16b9c82062b997179070a18136d4ac4a60c (19/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 5b38116b87b8cc1236ab21ca4f7a28fd89198aeb (20/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 69a0cbd714a5e39e3644a009730f295a615da0a4 (21/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 8196ba287cafc625592a0086534dc75028e576d7 (22/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 5fbb5172bfacc3d9885741ff6f20c0c246fc806d (23/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 4bd7aa0e1f317c20673b51f7d45ce44d5d9821d7 (24/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 1c781e1d9d86f95f87b6def3e330a2a148545a0e (25/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 6f664e01dce36f16ba7cdf98f982d32d68cdbfb2 (26/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite dd6e95f4d36d3a7003ddb58f61b93addd06b5910 (27/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite e375496026796953ab8a6afceef04541d9fd7ec7 (28/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 70160fe5bb1e86b4b9048859c573e7a2c59423ce (29/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 30fba669dd273d88806025e96179c721d9144091 (30/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 1fda1924d85963c33ad181a4a79703f0fc00a4bf (31/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 63e6a3e1329e68f31212c40650a902c9c7f5f182 (32/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 66788ff68edf18d4515bb0df85431c7d6b9286fe (33/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 651364c4cd30b3ff95c7f5a83f0937bc956f82fc (34/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 49ea7e6f74fde438c2e1d3706480f56fa74f4165 (35/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite 1c12b4fb450a2c98b4bb7c247dd3f5db68f9ca16 (36/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'
Rewrite b3870824be2e30320066c11d609156bdbce7f0d4 (37/37) (0 seconds passed, remaining 0 predicted)    rm 'vue/project/src/views/Glaucoma.vue'

Ref 'refs/heads/main' was rewritten
Ref 'refs/remotes/origin/main' was rewritten
Ref 'refs/remotes/origin/clean_up_components' was rewritten
Ref 'refs/remotes/origin/frontend-glaucoma' was rewritten
WARNING: Ref 'refs/remotes/origin/main' is unchanged
Ref 'refs/remotes/origin/sample_glaucoma_patient' was rewritten
```

## Garbage collection
After the above step, the commits with the sensitive files are disassociated but still present. To remove these old commits, run:
```bash
git for-each-ref --format="%(refname)" refs/original/ | xargs -I {} git update-ref -d {}
```

Next run garbage collector:
```bash
git gc --prune=now
git gc --aggressive --prune=now

# Ex
bearceb@soms-slce-oph1:~/coris_db_backup_10_02_2023$ git gc --prune=now
Enumerating objects: 585, done.
Counting objects: 100% (585/585), done.
Delta compression using up to 72 threads
Compressing objects: 100% (414/414), done.
Writing objects: 100% (585/585), done.
Total 585 (delta 274), reused 353 (delta 140), pack-reused 0
bearceb@soms-slce-oph1:~/coris_db_backup_10_02_2023$ git gc --aggressive --prune=now
Enumerating objects: 585, done.
Counting objects: 100% (585/585), done.
Delta compression using up to 72 threads
Compressing objects: 100% (554/554), done.
Writing objects: 100% (585/585), done.
Total 585 (delta 288), reused 273 (delta 0), pack-reused 0
```

## Push the changes to the remote repository: If you have pushed the sensitive file to a remote repository, you need to force push the changes to overwrite the history:

## Push the changes to the remote repository
If you have pushed the sensitive file to a remote repository, you need to force push the changes to overwrite the history:
```bash
git push origin --force --all
```
