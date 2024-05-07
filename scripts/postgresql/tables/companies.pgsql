create table
    public.companies (
        uuid uuid not null default gen_random_uuid (),
        name text not null,
        description text not null,
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint companies_pkey primary key (uuid),
        constraint companies_description_key unique (description),
        constraint companies_name_key unique (name),
        constraint companies_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint companies_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint companies_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;