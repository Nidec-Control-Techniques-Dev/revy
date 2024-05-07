-- TODO: [p3] Add iso_codes, country domains, and the like.
create table
    public.countries (
        uuid uuid not null default gen_random_uuid (),
        name text not null,
        un_code character varying(3) not null,
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint countries_pkey primary key (uuid),
        constraint countries_name_key unique (name),
        constraint countries_un_code_key unique (un_code),
        constraint countries_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint countries_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint countries_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;