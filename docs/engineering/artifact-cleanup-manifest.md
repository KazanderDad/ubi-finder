# Artifact cleanup manifest

On 2026-09-01, the repository root contained 56 ignored one-off patch/check
scripts and logs. The approved plan referred to 57; the live inventory at the
time of cleanup contained 56, so this manifest records the observed state
rather than inventing a missing artifact.

Every item below was untracked, last modified on 2026-08-19 or earlier, and had
no exact-filename reference in tracked application, configuration, workflow,
or documentation files outside the raw Base44 reconstruction material. They
were moved intact from `/Volumes/IomegaAPFS/src/ubi-finder/` to the recoverable
directory `/Users/botmaster/.Trash/ubi-finder-scratch-20260901T183000Z/`.

```text
add_auth_functions.cjs
check.cjs
check_blogs.mjs
check_browser.cjs
check_details.cjs
check_login.cjs
check_programs.cjs
check_services.cjs
create_ecosystem.cjs
deprecate_entities.cjs
fix_comment.cjs
fix_dashboard.cjs
fix_details.py
fix_edit_profile.cjs
fix_manage_program.cjs
fix_submit.cjs
force_patch.cjs
mark_deprecated.cjs
patch.py
patch_app.cjs
patch_app_footer.cjs
patch_auth_context.cjs
patch_auth_ui.cjs
patch_blog.cjs
patch_blogpost.cjs
patch_community_fetch.cjs
patch_dashboard.py
patch_details.cjs
patch_ecosystem.cjs
patch_edit_profile.cjs
patch_edit_profile_order.cjs
patch_editprofile.py
patch_header.cjs
patch_header_active.cjs
patch_header_intercept.cjs
patch_home.cjs
patch_home_text.cjs
patch_image.cjs
patch_init.py
patch_login.cjs
patch_matching.cjs
patch_profile.cjs
patch_programs.cjs
patch_services_content.cjs
patch_services_hero.cjs
patch_userform.cjs
patch_userform_order.cjs
refactor_pages.py
remove_footers.cjs
rewrite_blogpost.cjs
rewrite_blogpost2.py
rewrite_community.cjs
rewrite_jsx.cjs
rewrite_login.cjs
supabase_debug.log
update_program_details.py
```

The tracked `init/` and `base44/` reconstruction sources were removed only
after their useful provenance was preserved in
`base44-migration-provenance.md`. Git history remains the recovery path for
those tracked files. Supabase CLI state, the duplicate community seed, the
unused `Layout` component, and the legacy `SubmitProgram` implementation were
also removed after reference and canonical-source checks.
